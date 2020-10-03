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
import StoreKit

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - Properties
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "4dafda03b66db36f9b64d621aecb2b3d"
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    //MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
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
        if let tempData = json["main"]["temp"].double {
            weatherDataModel.temp = Int(tempData - 273.15)
            weatherDataModel.city = json["name"].stringValue
            lleidaIsCooler()
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUIWithWeatherData()
        } else {
            cityLabel.text = "Weather Unavailable"
        }
    }
    
    //MARK: - UIUpdates
   
    func updateUIWithWeatherData() {
        temperatureLabel.text = "\(weatherDataModel.temp)º"
        cityLabel.text = weatherDataModel.city
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        reviewRequest()
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
    
    //MARK: - LleidaIsCooler
    
    func lleidaIsCooler() {
        if weatherDataModel.city == "Lérida" {
            weatherDataModel.city = "Lleida"
        }
    }
    
    //MARK: - ChangeCityDelegate
    
    func userCustomLocation() {
        
    }
    
    //MARK: - PanSegue
    
   @IBAction func panSegue(sender: UIPanGestureRecognizer) {
        self.performSegue(withIdentifier: "cardViewSegue", sender: nil)
    }


    //MARK: - RequestReview
    
    func reviewRequest() {
        let alert = UIAlertController(title: "Feedback", message: "Are you enjoying the app so far?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes!", style: .default, handler: {_ in SKStoreReviewController.requestReview()}))
        present(alert, animated: true)
    }
}
