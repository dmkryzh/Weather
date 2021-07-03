//
//  AddCityAlert.swift
//  Weather
//
//  Created by Dmitrii KRY on 02.07.2021.
//

import Foundation
import UIKit

class AddCityAlert {
    
    let net = NetworkService()

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
            self.getCityPoint()
            guard let completion = completion else { return }
            completion()
        }
        self.addCityAlert.addAction(action)
    }

    func getCityPoint(_ completion: (() -> Void)? = nil) {
        guard let add = addCityAlert.textFields?[0].text else { return }
        self.net.getCityPoint(add)
        guard let completion = completion else { return }
        completion()
    }

}
