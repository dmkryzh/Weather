//
//  CarouselViewController.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.06.2021.
//

import Foundation
import UIKit
import SnapKit

enum Pages: CaseIterable {
    case pageZero
    case pageOne
    case pageTwo
    case pageThree
    
    var name: String {
        switch self {
        case .pageZero:
            return "This is page zero"
        case .pageOne:
            return "This is page one"
        case .pageTwo:
            return "This is page two"
        case .pageThree:
            return "This is page three"
        }
    }
    
    var index: Int {
        switch self {
        case .pageZero:
            return 0
        case .pageOne:
            return 1
        case .pageTwo:
            return 2
        case .pageThree:
            return 3
        }
    }
}

class CarouselViewController: UIViewController {
    
    private var pageController: UIPageViewController?
    
    private var currentIndex: Int = 0
    
    private var pages: [Pages] = Pages.allCases

    var coordinator: CarouselCoordinator

    private func setupPageController() {
        
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController?.dataSource = self
        pageController?.delegate = self
        pageController?.view.backgroundColor = .clear
        pageController?.view.frame = CGRect(x: 0,y: 0,width: view.frame.width,height: view.frame.height)
        
        addChild(pageController!)
        view.addSubview(self.pageController!.view)
        
        let vm = PageViewModel()
        let initialVC = PageViewConroller(vm: vm, color: .green, page: pages[0])
        initialVC.coordinator = coordinator
        
        guard let _ = pages.first else { return }
        
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        self.pageController?.didMove(toParent: self)
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
        pageControl.pageIndicatorTintColor = .blue
        
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
    
    init(coordinator: CarouselCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setupPageController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        decoratePageControl()
        configureBarItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                for subView in view.subviews {
                    if  subView is UIPageControl {
        
                        subView.isHidden = true
                        subView.frame.origin.y = view.safeAreaLayoutGuide.layoutFrame.minY
                        guard subView.subviews[0].subviews[0].subviews.count == pages.count else { return }
                        subView.isHidden = false
        
                        guard let dots = subView.subviews.first?.subviews.first?.subviews else { return }
                        dots.forEach { view in
                            view.layer.borderWidth = 1
                            view.layer.borderColor = UIColor.black.cgColor
                            view.layer.cornerRadius = 6
                        }
                    }
                }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //navigationController?.isNavigationBarHidden = true
    }
    
}

//MARK: Extentions

//extension CarouselViewController: UIPageViewControllerDataSource {
//
//    func presentationCount(for _: UIPageViewController) -> Int {
//        return items.count
//    }
//
//    func presentationIndex(for _: UIPageViewController) -> Int {
//        guard let firstViewController = viewControllers?.first,
//              let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
//            return 0
//        }
//
//        return firstViewControllerIndex
//    }
//
//    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
//            return nil
//        }
//
//        let previousIndex = viewControllerIndex - 1
//
//        guard previousIndex >= 0 else {
//            return items.last
//        }
//
//        guard items.count > previousIndex else {
//            return nil
//        }
//
//        return items[previousIndex]
//    }
//
//    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
//            return nil
//        }
//
//        let nextIndex = viewControllerIndex + 1
//        guard items.count != nextIndex else {
//            return items.first
//        }
//
//        guard items.count > nextIndex else {
//            return nil
//        }
//
//        return items[nextIndex]
//    }
//
//}


extension CarouselViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageViewConroller else {
            return nil
        }
        
        var index = currentVC.page.index
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        let vm = PageViewModel()
        let vc: PageViewConroller = PageViewConroller(vm: vm, color: .green, page: pages[index])
        vc.coordinator = self.coordinator
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageViewConroller else {
            return nil
        }
        
        var index = currentVC.page.index
        
        if index >= self.pages.count - 1 {
            return nil
        }
        
        index += 1
        
        let vm = PageViewModel()
        let vc: PageViewConroller = PageViewConroller(vm: vm, color: .green, page: pages[index])
        vc.coordinator = self.coordinator
        
        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
    
}
