//
//  CityInputViewController.swift
//  neosoftTest
//
//  Created by Gurmeet Kaur Narang on 31/10/23.
//

import UIKit



class CityInputViewController: UIViewController {
    @IBOutlet private weak var cityTextField: UITextField!
    
    private let viewModel = WeatherViewModel()
    private let weatherService = WeatherService()

    var weatherData: ((WeatherData?) -> Void)?
    
    @IBAction func searchWeatherForCity(_ sender: UIButton) {
        // Check if the user has entered a city name.
        guard let city = cityTextField.text else {
            // If the city name is not entered, you might want to show an error message.
            // You can display an alert or update the UI to inform the user to enter a city name.
            return
        }
    
        
     //   viewModel.fetchWeatherData(city: city)
        
        weatherService.fetchWeatherData(city: city) { [weak self] weatherData in
            self?.weatherData?(weatherData)
        }
    }
}


