//
//  CarouselViewController.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.06.2021.
//

import Foundation
import UIKit
import SnapKit

class CarouselViewController: UIPageViewController {
    
    var pages: [PageViewConroller] = []
    
    var coordinator: CarouselCoordinator
    
    var viewModel: CarouselViewModel
    
    private func definePageViewController() {
        self.dataSource = self
        self.delegate = self
        self.view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        viewModel.getCities()
        if viewModel.cities.count > 0 {
        viewModel.cities.forEach { element in
            let vm = PageViewModel(index: element.value, city: element.key)
            let detailedVm = DetailedForecastViewModel(city: element.key)
            let vc = PageViewConroller(vm: vm, detailedVm: detailedVm, coordinator: coordinator)
            pages.append(vc)
        }

        pages.sort(by: { $0.viewModel.pageIndex < $1.viewModel.pageIndex })
            let vm = PageViewModel(index: pages.count)
            let detailedVm = DetailedForecastViewModel()
            let initialVC = PageViewConroller(vm: vm, detailedVm: detailedVm, coordinator: coordinator)
            initialVC.makeAllContentHidden()
            self.setViewControllers([initialVC], direction: .forward, animated: false, completion: nil)
            
        } else {
            
        let vm = PageViewModel(index: 0)
        let detailedVm = DetailedForecastViewModel()
        let initialVC = PageViewConroller(vm: vm, detailedVm: detailedVm, coordinator: coordinator)
        initialVC.makeAllContentHidden()
        self.setViewControllers([initialVC], direction: .forward, animated: false, completion: nil)
        }
    }
    
    func configureBarItems() {
        let options = UIBarButtonItem(image: UIImage(named: "burger"), style: .done, target: self, action: #selector(navigateToSettings))
        navigationItem.setLeftBarButton(options, animated: true)
        let location = UIBarButtonItem(image: UIImage(named: "location"), style: .done, target: self, action: #selector(navigateToOnboarding))
        navigationItem.setRightBarButton(location, animated: true)
    }
    
    func decoratePageControl() {
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [CarouselViewController.self])
        pageControl.backgroundStyle = .minimal
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.hidesForSinglePage = true
        
        let dotImage = UIImage(systemName: "circle.fill")
        pageControl.preferredIndicatorImage = dotImage
    }
    
    @objc func navigateToOnboarding() {
        coordinator.navigateBackToOnboarding()
    }
    
    @objc func navigateToSettings() {
        coordinator.startSettings()
    }
    
    //MARK: Init
    
    init(coordinator: CarouselCoordinator, vm: CarouselViewModel) {
        self.coordinator = coordinator
        viewModel = vm
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        viewModel.getCities()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarItems()
        definePageViewController()
        decoratePageControl()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIPageControl {
                view.frame = CGRect(x: 0, y: self.view.safeAreaLayoutGuide.layoutFrame.minY - 10, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: 30)
                view.center.x = self.view.center.x
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
}

//MARK: Extentions

extension CarouselViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        
        
        guard let currentVC = viewController as? PageViewConroller else {
            return nil
        }
        
        var index = currentVC.viewModel.pageIndex
        
        
        if index == 0 {
            return nil
        }
        
        index -= 1
  
        
        let vm = PageViewModel(index: index, city: pages[index].viewModel.cityName)
        let detailedVm = DetailedForecastViewModel(city: pages[index].viewModel.cityName)
        let vc: PageViewConroller = PageViewConroller(vm: vm, detailedVm: detailedVm, coordinator: coordinator)
        vc.view.backgroundColor = .white
        vc.coordinator = self.coordinator
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageViewConroller else {
            return nil
        }
        
        var index = currentVC.viewModel.pageIndex
        
        if index == self.pages.count - 1 {
            
            index += 1
            
            let vm = PageViewModel(index: index)
            let detailedVm = DetailedForecastViewModel()
            let vc: PageViewConroller = PageViewConroller(vm: vm, detailedVm: detailedVm, coordinator: coordinator)
            vc.coordinator = self.coordinator
            vc.makeAllContentHidden()
            
            return vc
        }
        
        if index > self.pages.count - 1 {
            return nil
        }
        
        index += 1
        
        let vm = PageViewModel(index: index, city: pages[index].viewModel.cityName)
        let detailedVm = DetailedForecastViewModel(city: pages[index].viewModel.cityName)
        let vc: PageViewConroller = PageViewConroller(vm: vm, detailedVm: detailedVm, coordinator: coordinator)
        vc.view.backgroundColor = .white
        vc.coordinator = self.coordinator
        
        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count + 1
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = self.viewControllers?.first,
              let firstViewControllerIndex = pages.firstIndex(of: firstViewController as! PageViewConroller) else {
            return 0
        }
        return firstViewControllerIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let vc = self.viewControllers?[0] as? PageViewConroller
        self.navigationItem.title = vc?.viewModel.cityName
    }
    
}
