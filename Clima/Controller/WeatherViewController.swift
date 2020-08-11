//
//  ViewController.swift
//  Clima
//
//  Created by Laura Garcia Cano on 29/07/2020.
//  Copyright © 2020 LauDecked Devs. All rights reserved
//

import UIKit

class WeatherViewController: UIViewController {
    

    //MARK: - Properties
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    /***https://openweathermap.org/appid ****/
    
    //TODO: Declare instance variables here
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    //MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:Set up the location manager here.
    
    }
    
    //MARK: - Networking
        
    //Write the getWeatherData method here:
    
    //MARK: - JSON Parsing
   
    //Write the updateWeatherData method here:
    
    //MARK: - UI Updates
   
    //Write the updateUIWithWeatherData method here:
    
    //MARK: - Location Manager Delegate Methods
    
    //Write the didUpdateLocations method here:
    
    //Write the didFailWithError method here:
    
    //MARK: - Change City Delegate methods
    
    //Write the userEnteredANewCityName Delegate method here:
        
    //Write the PrepareForSegue Method here
}
