//
//  WeatherFetcher.swift
//  CarlosFalconett_Weather
//
//  Created by Carlos Falconett on 2021-04-10.
//

import Foundation

class WeatherFetcher : ObservableObject{
    var apiURL = "https://api.weatherapi.com/v1/current.json?key=cefc5359f745422aa4b10453210804&q=SELECTED_CITY&aqi=no"
    
    @Published var currentWeather = Weather();
    
    private static var shared: WeatherFetcher?
    
    static func getInstance() -> WeatherFetcher{
        if shared != nil{
            return shared!
        }else{
            return WeatherFetcher()
        }
    }
    
    func setApiUrl(){
        
    }
    
    func fetchDataFromAPI(){
        guard let api = URL(string : apiURL) else {
            return
        }
        URLSession.shared.dataTask(with: api){ (data: Data?, response: URLResponse?, error: Error?) in
            
            if(let err = error){
                
            }
            
        }.resume()
    }
}
