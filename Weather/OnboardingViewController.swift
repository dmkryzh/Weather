//
//  OnboardingViewController.swift
//  Weather
//
//  Created by Dmitrii KRY on 07.06.2021.
//

import UIKit
import SnapKit
import CoreLocation
import MapKit

class OnboardingViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    
    let location: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let containertView: UIView = {
        let content = UIView()
        return content
    }()
    
    let onboardingLogo: UIImageView = {
        let image = UIImage(named: "onboardingLogo")
        let view = UIImageView(image: image)
        return view
    }()
    
    let useLocationButton: UIButton = {
        let button = UIButton(type: .system)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        
        let attributedText = NSMutableAttributedString(string: "ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА", attributes: [NSAttributedString.Key.kern: -0.12, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        
        button.setAttributedTitle(attributedText, for: .normal)
        
        button.layer.backgroundColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(requestLocation), for: .touchUpInside)
        return button
    }()
    
    let denyButton: UIButton = {
        let button = UIButton(type: .system)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.11
        
        let attributedText = NSMutableAttributedString(string: "НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor(red: 0.992, green: 0.986, blue: 0.963, alpha: 1)])
        
        button.setAttributedTitle(attributedText, for: .normal)
        button.contentHorizontalAlignment = .right
        
        return button
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.973, green: 0.961, blue: 0.961, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.11
        
        label.attributedText = NSMutableAttributedString(string: "Разрешить приложению  Weather \nиспользовать данные \nо местоположении вашего устройства", attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        return label
    }()
    
    let firstTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.21
        
        label.attributedText = NSMutableAttributedString(string: "Чтобы получить более точные прогнозы погоды во время движения или путешествия", attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        return label
    }()
    
    let secondTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.21
        
        label.attributedText = NSMutableAttributedString(string: "Вы можете изменить свой выбор в любое время из меню приложения", attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        return label
    }()
    
    @objc func requestLocation() {
        location.requestAlwaysAuthorization()
        location.requestWhenInUseAuthorization()
        startLocationManager()
        coordinator?.startCarousel()
        
//        let main = CarouselViewController()
//        navigationController?.pushViewController(main, animated: true)
    }
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            location.delegate = self
            location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            location.startUpdatingLocation()
        }
        
    }
    
    func constraints() {
        
        scrollView.snp.makeConstraints() { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        containertView.snp.makeConstraints() { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        onboardingLogo.snp.makeConstraints { make in
            make.width.equalTo(304.5)
            make.height.equalTo(334)
            make.top.equalTo(containertView.snp.top)
            make.centerX.equalTo(containertView.snp.centerX)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingLogo.snp.bottom).offset(30)
            make.leading.trailing.equalTo(containertView).inset(19)
        }
        
        firstTextLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(containertView).inset(19)
        }
        
        secondTextLabel.snp.makeConstraints { make in
            make.top.equalTo(firstTextLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containertView).inset(19)
        }
        
        useLocationButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(secondTextLabel.snp.bottom).offset(40)
            make.leading.trailing.equalTo(containertView).inset(19)
        }
        
        denyButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(useLocationButton.snp.bottom).offset(25)
            make.leading.trailing.equalTo(containertView).inset(19)
            make.bottom.equalTo(containertView)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.addSubview(scrollView)
        scrollView.addSubview(containertView)
        containertView.addSubviews(onboardingLogo, headerLabel, firstTextLabel, secondTextLabel, useLocationButton, denyButton)
        constraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //navigationController?.isNavigationBarHidden = true
    }
    
}

extension OnboardingViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

