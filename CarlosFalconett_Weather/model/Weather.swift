//
//  Weather.swift
//  CarlosFalconett_Weather
//
//  Created by Carlos Falconett on 2021-04-10.
//

import Foundation


struct Weather : Codable{
    var current: Current //Array containig current temp_c
    //var temp_c : Float //temperature in celcious
    var feelslike_c : Decimal //feels like in celcious
    var winddir: String //wind direction
    var windspeed: Decimal //wind speed
    var uv: Decimal //ultra violet rays
    
    init(){
        //self.temp_c = 0.0
        self.current = Current.init()
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
        self.current = try Current.init(from: decoder)
        
        //self.temp_c = currentContainer.temp_c
        self.feelslike_c = try responso.decodeIfPresent(Decimal.self, forKey: .feelslike_c) ?? 0.0
        self.winddir = try responso.decodeIfPresent(String.self, forKey: .winddir) ?? "Not working"
        self.windspeed = try responso.decodeIfPresent(Decimal.self, forKey: .windspeed) ?? 0.0
        self.uv = try responso.decodeIfPresent(Decimal.self, forKey: .uv) ?? 0.0
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing
    }
    
}

struct Current: Codable{
    var temp_c : Decimal //temperature in celcious
    
    enum CodingKeys: String, CodingKey{
        case temp_c = "temp_c"
    }
    
    init(){
        self.temp_c = 0.0
    }
    
    init(from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.temp_c = try response.decodeIfPresent(Decimal.self, forKey: .temp_c) ?? 0.0
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing
    }
    
}
