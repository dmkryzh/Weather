//
//  AddCityAlert.swift
//  Weather
//
//  Created by Dmitrii KRY on 02.07.2021.
//

import Foundation
import UIKit

class AddCityAlert {
    
    var coordinator: CarouselCoordinator
    
    lazy var addCityAlert: UIAlertController = {
        
        let alertCont = UIAlertController(title: "Введите город", message: "Введите ваше текущее местоположение", preferredStyle: .alert)
        alertCont.addTextField() { login in
            login.textColor = .black
            login.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            login.autocapitalizationType = .none
            login.tintColor = UIColor.init(named: "accentColor")
            login.autocapitalizationType = .none
            login.placeholder = "Город"
            login.textContentType = .addressCity
        }
        return alertCont
    }()
    
    func configureAddAction(completion: (()-> Void)? = nil) {
        let action = UIAlertAction(title: "Принять", style: .default) { _ in
            guard let completion = completion else { return }
            completion()
        }
        self.addCityAlert.addAction(action)
    }
    
    init(coordinator: CarouselCoordinator) {
        self.coordinator = coordinator
    }
    
}
