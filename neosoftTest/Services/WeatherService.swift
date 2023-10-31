//
//  WeatherService.swift
//  neosoftTest
//
//  Created by Gurmeet Kaur Narang on 30/10/23.
//

import Foundation
import Alamofire

class WeatherService {
    private let apiKey = "9f2cd36ed55af20ebbe1b840fe1caf5d"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeatherDataForLocation(latitude: Double, longitude: Double, completion: @escaping (WeatherData?) -> Void) {
            let urlString = "\(baseURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
            
//        AF.request(urlString).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let value = response.result
//                completion(value)
//                
//                // Handle success
//            case .failure(let error):
//                print("Error: \(error)")
//                // Handle error
//            }
//        }
        
        
            AF.request(urlString).responseDecodable(of: WeatherData.self) { response in
                if let weatherData = response.value {
                    completion(weatherData)
                } else {
                    completion(nil)
                }
            }
        }
    
    func fetchWeatherData(city: String, completion: @escaping (WeatherData?) -> Void) {
        let parameters: [String: String] = ["q": city, "appid": apiKey]
        
        AF.request(baseURL, parameters: parameters).responseDecodable(of: WeatherData.self) { response in
            if let weatherData = response.value {
                completion(weatherData)
            } else {
                completion(nil)
            }
        }
    }
}
