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
    
    func configureBarItems() {
        let options = UIBarButtonItem(image: UIImage(named: "burger"), style: .done, target: self, action: nil)
        navigationItem.setLeftBarButton(options, animated: true)
        let location = UIBarButtonItem(image: UIImage(named: "location"), style: .done, target: self, action: nil)
        navigationItem.setRightBarButton(location, animated: true)
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
    }
    
    var items: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        dataSource = self
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        decoratePageControl()
        configureBarItems()
    }
    
    fileprivate func populateItems() {
        let backgroundColor:[UIColor] = [.white, .red, .green]
        backgroundColor.forEach { element in
            let vm = PageViewModel()
            let page = PageViewConroller(vm: vm, color: element)
            items.append(page)
        }
        
    }
    
    
    func decoratePageControl() {
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [CarouselViewController.self])
        pageControl.backgroundStyle = .minimal
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .white
        pageControl.preferredIndicatorImage = UIImage.init(systemName: "circle.fill")
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
        populateItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for subView in view.subviews {
            if  subView is  UIPageControl {
                subView.frame.origin.y = self.view.safeAreaLayoutGuide.layoutFrame.minY
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
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

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
