//
//  Weather.swift
//  CarlosFalconett_Weather
//
//  Created by Carlos Falconett on 2021-04-10.
//

import Foundation


struct Weather : Codable{
    //var current: Current //Array containig current temp_c
    var temp_c : Float //temperature in celcious
    var feelslike_c : Float //feels like in celcious
    var winddir: String //wind direction
    var windspeed: Float //wind speed
    var uv: Float //ultra violet rays
    
    init(){
        self.temp_c = 0.0
        self.feelslike_c = 0.0
        self.winddir = "default"
        self.windspeed = 0.0
        self.uv = 0.0
    }
    
    enum CodingKeys: String, CodingKey{
        case current = "current"
        case feelslike_c = "feelslike_c"
        case winddir = "wind_dir"
        case windspeed = "wind_kph"
        case uv = "uv"
        case temp_c = "temp_c"
    }
    
    init(from decoder: Decoder) throws{
        let responso = try decoder.container(keyedBy: CodingKeys.self)
        let currentContainer = try Current.init(from: decoder)
        
        self.temp_c = currentContainer.temp_c
        self.feelslike_c = try responso.decodeIfPresent(Float.self, forKey: .feelslike_c) ?? 0.0
        self.winddir = try responso.decodeIfPresent(String.self, forKey: .winddir) ?? "Not working"
        self.windspeed = try responso.decodeIfPresent(Float.self, forKey: .windspeed) ?? 0.0
        self.uv = try responso.decodeIfPresent(Float.self, forKey: .uv) ?? 0.0
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing
    }
    
}

struct Current: Codable{
    var temp_c : Float //temperature in celcious
    
    enum CodingKeys: String, CodingKey{
        case temp_c = "temp_c"
    }
    
    init(from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.temp_c = try response.decodeIfPresent(Float.self, forKey: .temp_c) ?? 0.0
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing
    }
    
}
