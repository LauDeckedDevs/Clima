//
//  ChangeCityViewController.swift
//  Clima
//
//  Created by Laura Garcia Cano on 29/07/2020.
//  Copyright © 2020 LauDecked Devs. All rights reserved
//

import UIKit

    //MARK: - Protocol

protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}

class ChangeCityViewController: UIViewController {
    
    //MARK: - Properties
    
    var delegate: ChangeCityDelegate?
    @IBOutlet weak var changeCityTextField: UITextField!

    //MARK: - getWeatherButton
    
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        let cityName = changeCityTextField.text!
        delegate?.userEnteredANewCityName(city: cityName)
        self.dismiss(animated: true, completion: nil)
    }
}
