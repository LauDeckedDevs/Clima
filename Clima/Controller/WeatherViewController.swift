//
//  ViewController.swift
//  Clima
//
//  Created by Laura Garcia Cano on 29/07/2020.
//  Copyright © 2020 LauDecked Devs. All rights reserved
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    

    //MARK: - Properties
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "4dafda03b66db36f9b64d621aecb2b3d"
    let locationManager = CLLocationManager()
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    //MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - GetWeatherData
        
    func getWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON: JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
            } else {
                self.cityLabel.text = "Conection Issues"
            }
        }
    }
    
    //MARK: - JSONParsing
   
    func updateWeatherData(json: JSON) {
        let _/*temp*/ = json["main"]["temp"]
    }
    
    //MARK: - UIUpdates
   
    func updateUIWithWeatherData() {
        //meow
    }
    
    //MARK: - UpdateLocationFuncs
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params: [String: String] = ["lat": latitude,
                                                 "lon": longitude,
                                                 "appid": APP_ID]
            getWeatherData(url: WEATHER_URL, parameters: params)
        } else {
            cityLabel.text = "Location Innacurate"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavaliable"
    }
    
    //MARK: - ChangeCityDelegate
    
    //Write the userEnteredANewCityName Delegate method here:
        
    //Write the PrepareForSegue Method here
}
