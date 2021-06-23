//
//  MainCoordinator.swift
//  Weather
//
//  Created by Dmitrii KRY on 19.06.2021.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var navController: UINavigationController?
    
    init(nav: UINavigationController = UINavigationController()) {
        navController = nav
    }
    
    func start() {
        let vc = OnboardingViewController(coordinator: self)
        navController?.pushViewController(vc, animated: true)
    }
    
    func startCarousel() {
        let coordinator = CarouselCoordinator(nav: navController!)
        coordinator.parentCoordinator = self
        coordinator.start()
        
    }
    
    func showCarousel() {
        navController?.popViewController(animated: true)
    }
    
}
