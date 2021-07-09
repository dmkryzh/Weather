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
    
    var mainViewModel: PageViewModel?
    
    let data = DataFromNetwork()
    
    func start() {
        
        let vc = CarouselViewController(coordinator: self)
        rootController = vc
        navController?.navigationBar.backgroundColor = .clear
        navController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Rubik-Medium", size: 18) as Any]
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
        let vm = DetailedForecastViewModel(city: rootController?.navigationItem.title ?? "", data: data)
        vm.parentViewModel = mainViewModel
        let vc = DetailedForecastViewController(coordinator: self, vm: vm)
        vc.cityName.text = rootController?.navigationItem.title
        navController?.pushViewController(vc, animated: true)
        
    }
    
    func startDailyView() {
        let vm = DailyForecastViewModel()
        let vc = DailyForecastViewController(vm: vm, coordinator: self)
        navController?.pushViewController(vc, animated: true)
    }
    
    func startCityAlert() {
        let alert = AddCityAlert(coordinator: self)
        
        
        alert.configureAddAction { [self] in
            navController?.dismiss(animated: true) {
                let cityName = alert.addCityAlert.textFields?[0].text ?? ""
                createPageForCarousel(cityName)
            }
        }
        navController?.present(alert.addCityAlert, animated: true)
    }
    
    
    func createPageForCarousel(_ city: String) {
        guard let index = rootController?.pages.count else { return }
        let vm = PageViewModel(index: index, city: city, data: data)
        mainViewModel = vm
        rootController?.cities.append(city)
        vm.cities = rootController?.cities ?? [""]
        let vc = PageViewConroller(vm: vm, coordinator: self)
        vc.view.backgroundColor = .white
        rootController?.navigationItem.title = city
        rootController?.pages.append(vc)
        rootController?.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }
    
    init(nav: UINavigationController) {
        navController = nav
    }
}
