//
//  MainViewController.swift
//  Testair
//
//  Created by Aurimas Vidutis on 27/08/2024.
//

import UIKit

class MainViewController: UIViewController, WeatherManagerDelegate {
    
    let imageView = UIImageView()
    let textField = UITextField()
    let searchButton = UIButton()
    
    var weatherManager = WeatherManager()
    var shouldClearText = false
    var weatherData: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        textField.delegate = self
        textField.autocorrectionType = .no
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        weatherManager.delegate = self
        setupLogo()
        setupTextField()
        setupButton()
    }
    
    // MARK: - Delegate Methods
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print("Did update weather with: \(weather)")
        self.weatherData = weather
        
        weatherManager.fetchIcon(iconString: weather.iconString)
        
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func didUpdateIcon(_ weatherManager: WeatherManager, iconData: Data) {
        DispatchQueue.main.async {
            self.goToNextScreen(with: self.weatherData, iconData: iconData)
        }
    }
    
    func setupLogo() {
        let logoImage = "Logo.png"
        let image = UIImage(named: logoImage)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 220),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupTextField() {
        textField.placeholder = "Enter city name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .darkGray
        
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupButton() {
        searchButton.configuration = .borderedTinted()
        searchButton.configuration?.baseBackgroundColor = .systemBlue
        searchButton.configuration?.title = "GO"
        view.addSubview(searchButton)
        
        searchButton.addTarget(self, action: #selector(startFetchingWeather), for: .touchUpInside)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            searchButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 60),
            searchButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func startFetchingWeather() {
        shouldClearText = true
        textField.endEditing(true)
    }
    
    func goToNextScreen(with weather: WeatherModel?, iconData: Data) {
        guard let weather = weather else { return }
        
        let nextScreen = ResultsViewController()
        nextScreen.weatherModel = weather
        nextScreen.weatherIcon = UIImage(data: iconData)
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shouldClearText = true
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please type the city"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if shouldClearText {
            if let city = textField.text {
                weatherManager.fetchWeather(cityName: city)
            }
            textField.text = ""
            shouldClearText = false
        }
    }
}
