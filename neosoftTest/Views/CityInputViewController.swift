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
   
        guard let city = cityTextField.text else {
         
            return
        }
    
        
     //   viewModel.fetchWeatherData(city: city)
        
        weatherService.fetchWeatherData(city: city) { [weak self] weatherData in
            self?.weatherData?(weatherData)
        }
    }
}


