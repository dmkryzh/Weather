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
    
    func start() {
        
        let vc = CarouselViewController(coordinator: self)
        navController?.navigationBar.backgroundColor = .clear
        navController?.navigationBar.isTranslucent = true
        navController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navController?.navigationBar.shadowImage = UIImage()
        navController?.navigationBar.tintColor = .black
        navController?.pushViewController(vc, animated: true)
        
    }
    
    func navigateBackToOnboarding() {
        navController?.popToRootViewController(animated: true)
    }
    
    func startSettings() {
        let vc = SettingsViewController()
        navController?.pushViewController(vc, animated: true)
    }
    
    func startDetailedView() {
        let vc = DetailedForecastViewController()
        navController?.pushViewController(vc, animated: true)
    }
    
    func startDaylyView() {
        
    }
    
    init(nav: UINavigationController) {
        navController = nav
    }
    
    
    
}
