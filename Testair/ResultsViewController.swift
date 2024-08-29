//
//  ResultsViewController.swift
//  Testair
//
//  Created by Aurimas Vidutis on 27/08/2024.
//

import UIKit

class ResultsViewController: UIViewController {
    
    let cardView = UIView()
    let temperatureLabel = UILabel()
    let descriptionLabel = UILabel()
    let cityLabel = UILabel()
    let dateLabel = UILabel()
    let weatherImageView = UIImageView()
    
    var weatherModel: WeatherModel?
    var weatherIcon: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupCardView()
        setupImageView()
        setupLabels()
        
        displayWeatherData()
    }
    
    func setupCardView() {
        cardView.backgroundColor = .systemGray5
        cardView.layer.cornerRadius = 10
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
    }
    
    func setupImageView() {
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.contentMode = .scaleAspectFit
        cardView.addSubview(weatherImageView)
        
        NSLayoutConstraint.activate([
            weatherImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            weatherImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 50),
            weatherImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupLabels() {
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont.systemFont(ofSize: 80)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cityLabel.textColor = .white
        cityLabel.font = UIFont.systemFont(ofSize: 20)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.textColor = .white
        dateLabel.font = UIFont.systemFont(ofSize: 20)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .center
        
        cardView.addSubview(temperatureLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(cityLabel)
        cardView.addSubview(dateLabel)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            dateLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            dateLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: padding),
            
            cityLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -padding),
            cityLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
        ])
    }
    
    func displayWeatherData() {
        guard let weather = weatherModel else {
            return
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(weather.dt))
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US")
        
        dateFormatter.dateFormat = "EEE"
        let day = dateFormatter.string(from: date).uppercased()
        
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: date)
        
        let formattedDate = "\(day)\n\(month)"
        
        temperatureLabel.text = "\(Int(weather.temperature))º"
        descriptionLabel.text = "\(weather.description)"
        cityLabel.text = weather.cityName
        dateLabel.text = "\(formattedDate)"
        weatherImageView.image = weatherIcon
        
    }
}

