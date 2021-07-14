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
    
    func start() {
        let vm = CarouselViewModel()
        let vc = CarouselViewController(coordinator: self, vm: vm)
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
        let vm = DetailedForecastViewModel(city: rootController?.navigationItem.title ?? "")
        vm.parentViewModel = mainViewModel
        let vc = DetailedForecastViewController(coordinator: self, vm: vm)
        vc.cityName.text = rootController?.navigationItem.title
        navController?.pushViewController(vc, animated: true)
        
    }
    
    func startDailyView(_ index: Int, _ city: String) {
        let vm = DailyForecastViewModel(index: index, city: city)
        vm.selectedCell = [index]
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
        var isCityAlreadyAdded = false
        rootController?.pages.forEach { element in
            if city == element.viewModel.cityName {
                isCityAlreadyAdded = true
            }
        }

        guard !isCityAlreadyAdded else { return }
        
        let index = rootController!.pages.count
        let vm = PageViewModel(index: index, city: city)
        let detailedVm = DetailedForecastViewModel(city: city)
        let vc = PageViewConroller(vm: vm, detailedVm: detailedVm, coordinator: self)
        vc.view.backgroundColor = .white
        rootController?.navigationItem.title = city
        rootController?.pages.append(vc)
        rootController?.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }
    
    init(nav: UINavigationController) {
        navController = nav
    }
}
