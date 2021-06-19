//
//  CarouselCoordinator.swift
//  Weather
//
//  Created by Dmitrii KRY on 19.06.2021.
//

import Foundation
import UIKit

class CarouselCoordinator: Coordinator {
    
    var navController: UINavigationController?
    
    init(nav: UINavigationController) {
        navController = nav
    }
    
    func start() {
        
        let vc = CarouselViewController()
        vc.coordinator = self
        
        let options = UIBarButtonItem(image: UIImage(named: "burger"), style: .done, target: self, action: #selector(startSettings))
        navController?.navigationItem.setLeftBarButton(options, animated: true)
        
        let location = UIBarButtonItem(image: UIImage(named: "location"), style: .done, target: self, action: #selector(navigateBackToOnboarding))
        
        navController?.navigationItem.setRightBarButton(location, animated: true)
        navController?.navigationBar.backgroundColor = .clear
        navController?.navigationBar.isTranslucent = true
        navController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navController?.navigationBar.shadowImage = UIImage()
        navController?.navigationBar.tintColor = .black

        navController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func navigateBackToOnboarding() {
        navController?.popToRootViewController(animated: true)
    }
    
    @objc func startSettings() {
        let vc = SettingsViewController()
        navController?.pushViewController(vc, animated: true)
    }
    
    func startDetailedView() {
        
    }
    
    func startDaylyView() {
        
    }
    
    
}
