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
import RealmSwift


class OnboardingViewController: UIViewController {
    
    
    var isCoordinatesLoaded: (() -> Void)?
    
    var coordinates: String? {
        didSet {
            guard let isCoordinatesLoaded = isCoordinatesLoaded else { return }
            isCoordinatesLoaded()
        }
    }
    
    private let config = Realm.Configuration(
        schemaVersion: 1,
        migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
            }
        })
    
    lazy var realm: Realm? = {
        try? FileManager().removeItem(at: config.fileURL!)
        return try? Realm(configuration: config)
    }()
    
    weak var coordinator: MainCoordinator?
    
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
        
        let attributedText = NSMutableAttributedString(string: "ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА", attributes: [ NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        
        button.setAttributedTitle(attributedText, for: .normal)
        
        button.layer.backgroundColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(requestLocation), for: .touchUpInside)
        return button
    }()
    
    let denyButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", attributes: [ NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor(red: 0.992, green: 0.986, blue: 0.963, alpha: 1)])
        
        button.setAttributedTitle(attributedText, for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(deny), for: .touchUpInside)
        
        return button
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.973, green: 0.961, blue: 0.961, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSMutableAttributedString(string: "Разрешить приложению  Weather \nиспользовать данные \nо местоположении вашего устройства")
        return label
    }()
    
    let firstTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSMutableAttributedString(string: "Чтобы получить более точные прогнозы погоды во время движения или путешествия")
        
        return label
    }()
    
    let secondTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSMutableAttributedString(string: "Вы можете изменить свой выбор в любое время из меню приложения")
        
        return label
    }()
    
    var carouselIsAlreadyShown: Bool = false
    
    @objc func requestLocation() {
        
        location.requestAlwaysAuthorization()
        location.requestWhenInUseAuthorization()
        startLocationManager()
        isCoordinatesLoaded = { [self] in
            coordinator?.didShown = true
            coordinator?.startCarousel(coordinates)
        }
    }
    
    @objc func deny() {
        if carouselIsAlreadyShown {
            coordinator?.showCarousel()
        } else {
            coordinator?.startCarousel()
        }
    }
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            location.delegate = self
            location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            location.startUpdatingLocation()
        }
        
    }
    
    func setInitialSettings() {
        guard let realm = realm else { return }
        if realm.objects(Settings.self).isEmpty {
            try? self.realm?.write() {
                let defaultSettings = Settings()
                defaultSettings.tempType = 0
                defaultSettings.timeFormat = 0
                defaultSettings.windSpeed = 0
                defaultSettings.notifications = 0
                realm.add(defaultSettings)
            }
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
        setInitialSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCoordinates(_ lon: CLLocationDegrees, _ lat: CLLocationDegrees) {
        guard let _ = coordinates else {
            coordinates = "\(lon),\(lat)"
            return }
    }
    
}

extension OnboardingViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        addCoordinates(locValue.longitude, locValue.latitude)
    }
}

