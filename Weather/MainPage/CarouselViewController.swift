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
    
    weak var coordinator: CarouselCoordinator?
    
    var items: [UIViewController] = []
    
    func populateItems() {
        let backgroundColor:[UIColor] = [.white, .red, .green, .brown]
        backgroundColor.forEach { element in
            let vm = PageViewModel()
            let page = PageViewConroller(vm: vm, color: element)
            items.append(page)
        }
        
    }
    
    func configureBarItems() {
        
        let options = UIBarButtonItem(image: UIImage(named: "burger"), style: .done, target: self, action: #selector(navigateToSettings))
        navigationItem.setLeftBarButton(options, animated: true)
        let location = UIBarButtonItem(image: UIImage(named: "location"), style: .done, target: self, action: #selector(navigateToOnboarding))
        navigationItem.setRightBarButton(location, animated: true)
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
    }
    
    func decoratePageControl() {
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [CarouselViewController.self])
        pageControl.backgroundStyle = .minimal
        pageControl.numberOfPages = items.count
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .blue
        
        let dotImage = UIImage(systemName: "circle.fill")
        pageControl.preferredIndicatorImage = dotImage
    }
    
    @objc func navigateToOnboarding() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func navigateToSettings() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Init
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
        populateItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        dataSource = self
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        decoratePageControl()
        configureBarItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for subView in view.subviews {
            if  subView is UIPageControl {
                
                subView.isHidden = true
                subView.frame.origin.y = view.safeAreaLayoutGuide.layoutFrame.minY
                guard subView.subviews[0].subviews[0].subviews.count == items.count else { return }
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
        navigationController?.isNavigationBarHidden = true
    }
    
}

//MARK: Extentions

extension CarouselViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
    }
    
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return items.last
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        
        return items[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        
        return items[nextIndex]
    }

}



