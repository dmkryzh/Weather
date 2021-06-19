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
    
    init(root: UIViewController) {
        navController = UINavigationController(rootViewController: root)
    }
    
    func start() {
        navController?.isNavigationBarHidden = true
    }
    
    func startCarousel() {
        let coordinator = CarouselCoordinator(nav: navController!)
        coordinator.start()
    }
    
}
