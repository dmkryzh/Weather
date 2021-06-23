//
//  CarouselViewController.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.06.2021.
//

import Foundation
import UIKit
import SnapKit

class CarouselViewController: UIViewController {
    
    var pageController: UIPageViewController?
    
    var pages: [PageViewConroller] = []

    var coordinator: CarouselCoordinator
    
    var height: CGFloat = 0
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    private func setupPageController() {
        
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController?.dataSource = self
        pageController?.delegate = self
        pageController?.view.backgroundColor = .clear
//        addChild(pageController!)
        let vm = PageViewModel(index: 0)
        let initialVC = PageViewConroller(vm: vm)
        initialVC.coordinator = coordinator
        initialVC.makeAllContentHidden()
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: false, completion: nil)
        //self.pageController?.didMove(toParent: self)
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
    
    func setConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalTo(scrollView)
        }
     
        pageController?.view.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(1126)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom)

        }
    }
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(pageController!.view)
        decoratePageControl()
        configureBarItems()
        setConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//                for subView in view.subviews {
//                    if  subView is UIPageControl {
//
//                        subView.isHidden = true
//                        subView.frame.origin.y = view.safeAreaLayoutGuide.layoutFrame.minY
//                        guard subView.subviews[0].subviews[0].subviews.count == pages.count else { return }
//                        subView.isHidden = false
//
//                        guard let dots = subView.subviews.first?.subviews.first?.subviews else { return }
//                        dots.forEach { view in
//                            view.layer.borderWidth = 1
//                            view.layer.borderColor = UIColor.black.cgColor
//                            view.layer.cornerRadius = 6
//                        }
//                    }
//                }
//        
//        let height: CGFloat = pageController!.view.frame.height
//        print(height)
//        pageController!.view.snp.updateConstraints { make in
//            make.height.equalTo(height)
//        }
//        view.layoutIfNeeded()

        
//        height = pageController!.view.
//        pageController!.view.snp.updateConstraints { make in
//            make.height.equalTo(height)
//        }
//        pageController?.view.layoutIfNeeded()
//        view.layoutIfNeeded()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
//        pageController?.view.snp.makeConstraints { make in
//            make.top.equalTo(contentView.snp.top)
//            make.width.equalTo(contentView.snp.width)
//            make.height.equalTo(pageController!.view.frame.height)
//            make.bottom.equalTo(contentView.snp.bottom)
//
//        }
        //setConstraints()
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
        
        var index = currentVC.viewModel.pageIndex
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        let vm = PageViewModel(index: index)
        let vc: PageViewConroller = PageViewConroller(vm: vm)
        vc.view.backgroundColor = .white
        vc.coordinator = self.coordinator
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageViewConroller else {
            return nil
        }
        
        var index = currentVC.viewModel.pageIndex

        if index == self.pages.indices.endIndex - 1 {
            
            index += 1
            
            let vm = PageViewModel(index: index)
            let vc: PageViewConroller = PageViewConroller(vm: vm)
            vc.coordinator = self.coordinator
            vc.makeAllContentHidden()
            
//            pageController?.view.snp.remakeConstraints { make in
//                make.top.equalTo(contentView.snp.top)
//                make.width.equalTo(contentView.snp.width)
//                make.height.equalTo(pageController!.view.frame.height)
//                make.bottom.equalTo(contentView.snp.bottom)
//
//            }
        
            return vc
        }
      
        if index >= self.pages.count - 1 {
            return nil
        }

        index += 1
        
        let vm = PageViewModel(index: index)
        let vc: PageViewConroller = PageViewConroller(vm: vm)
        vc.view.backgroundColor = .white
        vc.coordinator = self.coordinator


        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count + 1
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = self.pageController?.viewControllers?.first,
              let firstViewControllerIndex = pages.firstIndex(of: firstViewController as! PageViewConroller) else {
            return 0
            }
    
            return firstViewControllerIndex
        }
}
