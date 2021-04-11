//
//  WeatherFetcher.swift
//  CarlosFalconett_Weather
//
//  Created by Carlos Falconett on 2021-04-10.
//

import Foundation

class WeatherFetcher : ObservableObject{
    var apiURL = ""
    
    @Published var currentWeather = Weather();
    
    private static var shared: WeatherFetcher?
    
    static func getInstance() -> WeatherFetcher{
        if shared != nil{
            return shared!
        }else{
            return WeatherFetcher()
        }
    }
    
    func fetchDataFromAPI(cityname: String){
        let userApi: String = "https://api.weatherapi.com/v1/current.json?key=cefc5359f745422aa4b10453210804&q=\(cityname)&aqi=no"
        print(#function, userApi)
        guard let api = URL(string : userApi) else {
            return
        }
        URLSession.shared.dataTask(with: api){ (data: Data?, response: URLResponse?, error: Error?) in
            
            if let err = error {
                print(#function, "Couldn't fetch data", err)
            } else {
                DispatchQueue.global().async {
                    do{
                        if let jsonData = data{
                            let decoder = JSONDecoder()
                            let decodedList = try decoder.decode(Weather.self, from: jsonData)
                            DispatchQueue.main.async {
                                print(#function,"Decoded Weather Data: \(decodedList)")
                                self.currentWeather = decodedList
                            }
                            
                        }else{
                            print(#function, "No JSON")
                        }
                    }catch let error{
                        print(#function, error)
                    }
                }
                
            }
            
        }.resume()
    }
}
