//
//  Created by Volodymyr Andriienko on 11/3/21.
//  Copyright © 2021 VAndrJ. All rights reserved.
//

import UIKit
import CoreLocation

final class WeatherBrickViewController: UIViewController {
    
    @IBOutlet private weak var brickImage: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var infoButton: UIButton!
    @IBOutlet private weak var shadowView: UIView!
    
    private var networkWeatherManager = WeatherNetworkManager()
    private var locationManager: CLLocationManager {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }
    private var gradientLayer: CAGradientLayer? {
        didSet {
            gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer?.endPoint = CGPoint(x: 0, y: 1)
            gradientLayer?.colors = [Constants.gradientColorStart, Constants.gradientColorEnd]
        }
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer?.frame = CGRect(x: 0, y: 0, width: infoButton.bounds.size.width, height: infoButton.bounds.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brickImage.isUserInteractionEnabled = true
        gradientLayer = CAGradientLayer()
        if let gradientLayer {
            infoButton.layer.insertSublayer(gradientLayer, at: 0)
        }
        infoButton.layer.cornerRadius = Constants.cornerRadius
        infoButton.layer.masksToBounds = true
        shadowView.layer.cornerRadius = Constants.cornerRadius
        shadowView.clipsToBounds = true
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowRadius = Constants.shadowRadius
        shadowView.layer.shadowOpacity = Constants.shadowOpacity
        shadowView.layer.shadowColor = Constants.shadowColor
        shadowView.layer.shadowOffset = Constants.shadowOffset
        
        setupGesture()
        updateLocationAndWeather()
    }
    
    private func updateLocationAndWeather() {
        locationManager.requestLocation()
        networkWeatherManager.onLocationFetch = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateUIWith(weather: currentWeather)
        }
    }
    
    private func updateUIWith(weather: CurrentWeather) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.locationLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.brickImage.image = UIImage(named: weather.iconNameString)
            if weather.isFoggy {
                self.brickImage.layer.opacity = Constants.foggyImageOpacity
            }
            if weather.isWindy {
                UIView.animate(withDuration: Constants.windAnimationDuration, delay: 0, options: [.repeat, .autoreverse], animations: {
                    self.brickImage.frame = CGRect(x: self.brickImage.frame.origin.x - Constants.windAnimationImageOffset, y: self.brickImage.frame.origin.y, width: self.brickImage.frame.width, height: self.brickImage.frame.height)
                })
            }
            self.descriptionLabel.text = weather.description
        }
    }
    
    private func setupGesture() {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        gestureRecognizer.direction = .down
        brickImage.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func handleGesture() {
        UIView.animate(withDuration: Constants.updateAnimatinDuration, delay: 0) {
            self.brickImage.frame = CGRect(x: self.brickImage.frame.origin.x, y: self.brickImage.frame.origin.y + Constants.updateAnimationImageOffset, width: self.brickImage.frame.width, height: self.brickImage.frame.height)
        } completion: { _ in
            UIView.animate(withDuration: Constants.updateAnimatinDurationBack, delay: 0) {
                self.brickImage.frame = CGRect(x: self.brickImage.frame.origin.x, y: self.brickImage.frame.origin.y - Constants.updateAnimationImageOffset, width: self.brickImage.frame.width, height: self.brickImage.frame.height)
            }
        }
        updateLocationAndWeather()
    }
}

extension WeatherBrickViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        networkWeatherManager.fetchCurrentWeather(forLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        networkWeatherManager.onLocationFetch = { [weak self] currentWeather in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateUIWith(weather: currentWeather)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension WeatherBrickViewController {
    
    private struct Constants {
        static let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        static let gradientColorStart = UIColor(red: 1, green: 0.6, blue: 0.38, alpha: 1).cgColor
        static let gradientColorEnd = UIColor(red: 0.98, green: 0.32, blue: 0.11, alpha: 1).cgColor
        static let cornerRadius:CGFloat = 15
        static let shadowRadius:CGFloat = 6
        static let shadowOpacity: Float = 1
        static let shadowOffset = CGSize(width: 2, height: 2)
        static let foggyImageOpacity: Float = 0.5
        static let windAnimationDuration = 0.5
        static let windAnimationImageOffset: Double = 20
        static let updateAnimatinDuration = 0.5
        static let updateAnimatinDurationBack = 0.3
        static let updateAnimationImageOffset: Double = 30
    }
}

