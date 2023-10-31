//
//  WeatherViewModel.swift
//  neosoftTest
//
//  Created by Gurmeet Kaur Narang on 30/10/23.
//

import Foundation
import CoreLocation
import UIKit

class WeatherViewModel: NSObject {
    private let weatherService = WeatherService()
    private let locationManager = CLLocationManager()
    
    var weatherData: ((WeatherData?) -> Void)?
    var locationDenied: (() -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func fetchWeatherDataForCurrentLocation() {
        locationManager.requestLocation()
    }
    
    func fetchWeatherData(city: String) {
        weatherService.fetchWeatherData(city: city) { [weak self] weatherData in
            self?.weatherData?(weatherData)
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        weatherService.fetchWeatherDataForLocation(latitude: latitude, longitude: longitude) { [weak self] weatherData in
            self?.weatherData?(weatherData)
        }
        
        // Stop updating location to conserve battery
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location manager failed with error: \(error.localizedDescription)")
            // Handle error
        
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
                locationManager.requestLocation()
            } else {
                locationDenied?()
                // Handle when user denies location access
            }
//        if status == .denied {
//            locationDenied?()
      //  }
    }
}
