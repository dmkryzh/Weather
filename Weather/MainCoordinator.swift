//
//  MainCoordinator.swift
//  Weather
//
//  Created by Dmitrii KRY on 19.06.2021.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    var didShown = false
    
    init(nav: UINavigationController = UINavigationController()) {
        navController = nav
    }
    
    func start() {
        let vc = OnboardingViewController(coordinator: self)
        navController.pushViewController(vc, animated: true)
    }
    
    func startCarousel(_ coordinates: String? = nil) {
        let coordinator = CarouselCoordinator(nav: navController)
        coordinator.parentCoordinator = self
        if let coordinates = coordinates {
            DataFromNetwork.shared.getCityByCoordinates(geocode: coordinates) {
                coordinator.start()
                coordinator.createPageForCarousel(DataFromNetwork.shared.cityFromCoordinates ?? "")
            }
            
        } else if didShown {
            coordinator.createPageForCarousel(DataFromNetwork.shared.cityFromCoordinates ?? "")
        } else {
            coordinator.start()
        }
        
    }
    
    func showCarousel() {
        navController.popViewController(animated: true)
    }
    
}
