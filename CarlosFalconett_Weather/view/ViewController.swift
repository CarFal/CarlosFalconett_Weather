//
//  ViewController.swift
//  CarlosFalconett_Weather
//
//  Created by Carlos Falconett on 2021-04-07.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private let weatherfetcher = WeatherFetcher.getInstance()
    private var currentWeather: Weather = Weather()
    private var canceallable: Set<AnyCancellable> = []
    @IBOutlet var pkCountry: UIPickerView!
    
    @IBOutlet var lblFeelslike: UILabel!
    
    @IBOutlet var lblTemp: UILabel!
    
    @IBOutlet var lblWindDir: UILabel!
    
    @IBOutlet var lblWindSpeed: UILabel!
    
    @IBOutlet var lblUV: UILabel!
    
    let citylist = ["London", "Toronto", "New York", "Tokyo", "Seoul", "Panama", "Beijing", "Montreal", "Zhuhai", "Sidney"]
    var city = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pkCountry.delegate = self
        self.pkCountry.dataSource = self
        self.lblFeelslike.text = "0.0"
        self.lblTemp.text = "0.0"
        self.lblWindDir.text = "N/A"
        self.lblWindSpeed.text = "0.0"
        self.lblUV.text = "0.0"
    }
    
    private func receiveChanges(){
        self.weatherfetcher.$currentWeather.receive(on: RunLoop.main)
            .sink{(weather) in
                print(#function, "Receiver weather: ", weather.winddir)
                self.currentWeather = weather
            }
            .store(in: &canceallable)
        self.lblFeelslike.text = "\(self.currentWeather.feelslike_c)"
        self.lblTemp.text = "\(self.currentWeather.temp_c)"
        self.lblWindDir.text = "\(self.currentWeather.winddir)"
        self.lblWindSpeed.text = "\(self.currentWeather.windspeed)"
        self.lblUV.text = "\(self.currentWeather.uv)"
    }
    
    @IBAction func getWeather(){
        //self.weatherfetcher.setApiUrl(cityname: citylist[city])
        self.weatherfetcher.fetchDataFromAPI(cityname: citylist[city])
        self.receiveChanges()
        
    }


}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citylist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citylist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        city = row
    }
}

