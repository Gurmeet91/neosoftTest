//
//  WeatherViewController.swift
//  neosoftTest
//
//  Created by Gurmeet Kaur Narang on 31/10/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    private let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.weatherData = { [weak self] weatherData in
            guard let weatherData = weatherData else { return }
            
            self?.temperatureLabel.text = "\(weatherData.main.temp)°C"
            self?.descriptionLabel.text = weatherData.weather.first?.description
        }
        
        viewModel.fetchWeatherDataForCurrentLocation()
        
        
        viewModel.locationDenied = { [weak self] in
            self?.showLocationDeniedAlert()
        }
    }
    
    private func showLocationDeniedAlert() {
//            let alertController = UIAlertController(title: "Location Access Denied", message: "Please enable location access in settings to get weather data based on your location.", preferredStyle: .alert)
//            
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertController.addAction(okAction)
//            
//            present(alertController, animated: true, completion: nil)
        
        
        let alert = UIAlertController(title: "Location Access Denied",
                                              message: "Please enable location access in settings to get weather data based on your location.",
                                              preferredStyle: .alert)
                
                let settingsAction = UIAlertAction(title: "Open Settings", style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }

                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                    }
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                
                alert.addAction(settingsAction)
                alert.addAction(cancelAction)
        
        
        
        }
        
        @IBAction func fetchWeatherForCurrentLocation(_ sender: UIButton) {
            viewModel.fetchWeatherDataForCurrentLocation()
        }
        
        @IBAction func goToCityInputPage(_ sender: UIButton) {
            performSegue(withIdentifier: "ToCityInput", sender: nil)
        }
    }
