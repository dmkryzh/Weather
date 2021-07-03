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
    var rootController: CarouselViewController?
    var parentCoordinator: MainCoordinator?
    
    func start() {
        
        let vc = CarouselViewController(coordinator: self)
        rootController = vc
        navController?.navigationBar.backgroundColor = .clear
        navController?.navigationBar.isTranslucent = true
        navController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navController?.navigationBar.shadowImage = UIImage()
        navController?.navigationBar.tintColor = .black
        navController?.pushViewController(vc, animated: true)
        
    }
    
    func navigateBackToOnboarding() {
        guard let parent = parentCoordinator else { return }
        let vc = OnboardingViewController(coordinator: parent)
        vc.carouselIsAlreadyShown = true
        navController?.pushViewController(vc, animated: true)
    }
    
    func startSettings() {
        let vc = SettingsViewController()
        navController?.pushViewController(vc, animated: true)
    }
    
    func backToPreviousView() {
        navController?.popViewController(animated: true)
    }
    
    func startDetailedView() {
        
        let vc = DetailedForecastViewController(coordinator: self)
        navController?.pushViewController(vc, animated: true)
        
    }
    
    func startDailyView() {
        let vm = DailyForecastViewModel()
        let vc = DailyForecastViewController(vm: vm, coordinator: self)
        navController?.pushViewController(vc, animated: true)
    }
    
    let alert = AddCityAlert()
    
    func startCityAlert() {
        
        alert.configureAddAction { [self] in
            navController?.dismiss(animated: true, completion: self.createPageForCarousel)
        }
        navController?.present(alert.addCityAlert, animated: true)
    }
    
    
    func createPageForCarousel() {
        guard let index = rootController?.pages.count else { return }
        let vm = PageViewModel(index: index)
        let vc = PageViewConroller(vm: vm, coordinator: self)
        vc.view.backgroundColor = .white
        rootController?.pages.append(vc)
        let parent = rootController?.pageController
        parent?.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        alert.net.testGet()
    }
    
    init(nav: UINavigationController) {
        navController = nav
    }
}
