//
//  ViewController.swift
//  Clima
//
//  Created by Laura Garcia Cano on 29/07/2020.
//  Copyright © 2020 LauDecked Devs. All rights reserved
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    

    //MARK: - Properties
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
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
    
    //MARK: - Networking
        
    //Write the getWeatherData method here:
    
    //MARK: - JSONParsing
   
    //Write the updateWeatherData method here:
    
    //MARK: - UIUpdates
   
    //Write the updateUIWithWeatherData method here:
    
    //MARK: - UpdateLocationFuncs
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params: [String: String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
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
