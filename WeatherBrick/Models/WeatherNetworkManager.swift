//
//  WeatherManager.swift
//  WeatherBrick
//
//  Created by Екатерина Токарева on 23/12/2022.
//  Copyright © 2022 VAndrJ. All rights reserved.
//

import Foundation
import CoreLocation

final class WeatherNetworkManager {
    
    var onLocationFetch: ((CurrentWeather) -> Void)?
    
    @discardableResult func fetchCurrentWeather(forLatitude latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> CurrentWeather? {
        var components = URLComponents()
           components.scheme = "https"
        components.host = API.URLhost
        components.path = API.URLpath
           components.queryItems = [
               URLQueryItem(name: "lat", value: String(latitude)),
               URLQueryItem(name: "lon", value: String(longitude)),
               URLQueryItem(name: "apikey", value: API.key),
               URLQueryItem(name: "units", value: "metric"),
           ]
        let url = components.url
        return performeRequest(withURL: url)
    }
    
    private func performeRequest(withURL url: URL?) -> CurrentWeather? {
        var result: CurrentWeather?
        guard let url else { return nil }
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data,
               let currentWeather = self.parseJSON(withData: data) {
                self.onLocationFetch?(currentWeather)
                result = currentWeather
            }
        }
        task.resume()
        return result
    }
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        var weatherData: WeatherData?
        do {
            weatherData = try decoder.decode(WeatherData.self, from: data)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        guard let weatherData = weatherData else { return nil }
        return CurrentWeather(weatherData: weatherData)
    }
    
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}
