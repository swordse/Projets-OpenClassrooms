//
//  MétéoViewController.swift
//  Projet9
//
//  Created by Raphaël Goupille on 08/09/2021.
//

import UIKit

final class WeatherViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    
    private let service = WeatherService()
    private let customAlert = CustomAlert()
    
    // main view UI
    @IBOutlet weak var mainWeatherView: UIView!
    @IBOutlet weak var searchBarUI: UISearchBar!
    @IBOutlet weak var mainCityLabel: UILabel!
    @IBOutlet weak var mainWeatherImage: UIImageView!
    @IBOutlet weak var mainActualTempLabel: UILabel!
    @IBOutlet weak var mainMaxTempLabel: UILabel!
    @IBOutlet weak var mainMinTempLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // second view UI
    @IBOutlet weak var secondWeatherView: UIView!
    @IBOutlet weak var secondCityLabel: UILabel!
    @IBOutlet weak var secondWeatherImage: UIImageView!
    @IBOutlet weak var secondActualTempLabel: UILabel!
    @IBOutlet weak var secondMaxTempLabel: UILabel!
    @IBOutlet weak var secondMinTempLabel: UILabel!
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tapGesture)
        
        searchBarUI.delegate = self
        
        activityIndicator.isHidden = true
        mainWeatherView.setShadow()
        mainWeatherView.layer.cornerRadius = 7
        
        secondWeatherView.setShadow()
        secondWeatherView.layer.cornerRadius = 7
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // fetch data for Paris and New York
        service.fetchWeatherId { result in
            DispatchQueue.main.async {
                switch result {
                case.failure(let error):
                    self.customAlert.showAlert(with: "Oups", message: "Une erreur est survenue. Vérifiez votre connexion et réessayez.", on: self)
                    print(error)
                case.success(let success):
                    let result = DisplayableWeather.createCities(result: success)
                    
                    self.updateMainUI(data: result[0])
                    self.updateSecondUI(data: result[1])
                }
            }
        }
    }
    
    // MARK: Methods
    
    // fetch data for the search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let citySearch = searchBar.text else
        { customAlert.showAlert(with: "Oups !", message: "Vous devez renseigner le nom de la ville!", on: self)
            return }
        
        activityIndicator.isVisible(true)
        
        service.fetchWeatherSearch(city: citySearch, callback: { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        self.customAlert.showAlert(with: "Oups !", message: "Votre ville n'a pas été trouvée!", on: self)
                    case .noData:
                        self.customAlert.showAlert(with: "Oups !", message: "Votre ville n'a pas été trouvée!", on: self)
                        
                    case .undecodableData:
                        self.customAlert.showAlert(with: "Oups !", message: "Votre ville n'a pas été trouvée!", on: self)
                        
                    }
                case .success(let success):
                    let result = DisplayableWeather.createCity(result: success)
                    self.updateMainUI(data: result)
                }
                self.activityIndicator.isVisible(false)
            }
        })
        searchBar.resignFirstResponder()
    }
        
    private func updateMainUI(data: DisplayableWeather) {
        mainCityLabel.text = searchBarUI.text?.uppercased()
        
        mainActualTempLabel.text = "\(Formatter.temperatureToString(temp: data.actualTemp))°C"
        mainMaxTempLabel.text = "\(Formatter.temperatureToString(temp: data.maxTemp))°C"
        mainMinTempLabel.text = "\(Formatter.temperatureToString(temp: data.minTemp))°C"
        ImageSetter.setImage(weatherToDisplay: data, imageView: mainWeatherImage)
    }
    
    private func updateSecondUI(data: DisplayableWeather) {
        secondCityLabel.text = data.cityName.uppercased()
        secondActualTempLabel.text = "\(String(data.actualTemp))°C"
        secondMaxTempLabel.text = "\(Formatter.temperatureToString(temp: data.maxTemp))°C"
        secondMinTempLabel.text = "\(Formatter.temperatureToString(temp: data.minTemp))°C"
        ImageSetter.setImage(weatherToDisplay: data, imageView: secondWeatherImage)
    }
    
}
