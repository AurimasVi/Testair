//
//  WeatherManager.swift
//  Testair
//
//  Created by Aurimas Vidutis on 27/08/2024.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
    func didUpdateIcon(_ weatherManager: WeatherManager, iconData: Data)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=10692b614cde4a27abc3caf08c696dfa&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            let iconString = decodedData.weather[0].icon
            let dt = decodedData.dt
            let weather = WeatherModel(cityName: name, temperature: Double(temp), description: description, iconString: iconString, dt: dt)
            
            return weather
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func fetchIcon(iconString: String) {
        let weatherIconURL = "https://openweathermap.org/img/wn/\(iconString)@2x.png"
        
        if let iconURL = URL(string: weatherIconURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: iconURL) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let imageData = data {
                    self.delegate?.didUpdateIcon(self, iconData: imageData)
                }
            }
            task.resume()
        }
    }
}


