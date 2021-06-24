//
//  PageViewConroller.swift
//  Weather
//
//  Created by Dmitrii KRY on 10.06.2021.
//

import Foundation
import UIKit
import SnapKit

class PageViewConroller: UIViewController {
    
    var coordinator: CarouselCoordinator
 
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    var viewModel: PageViewModel
    
//    func configureBarItems() {
//        
//        let options = UIBarButtonItem(image: UIImage(named: "burger"), style: .done, target: self, action: nil)
//        navigationItem.setLeftBarButton(options, animated: true)
//        let location = UIBarButtonItem(image: UIImage(named: "location"), style: .done, target: self, action: nil)
//        navigationItem.setRightBarButton(location, animated: true)
//        navigationController?.navigationBar.backgroundColor = .clear
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.tintColor = .black
//    }
    
    private let detailedForecastButton: UIButton = {
        let view = UIButton(type: .system)
        let title = NSAttributedString(string: "Подробнее на 24 часа", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 16) as Any])
        view.setAttributedTitle(title, for: .normal)
        let color = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.setTitleColor(color, for: .normal)
        view.titleLabel?.textAlignment = .right
        view.addTarget(self, action: #selector(navigateToDetailedController), for: .touchUpInside)
        return view
    }()
    
    @objc func navigateToDetailedController() {
        coordinator.startDetailedView()
    }
    
    
    private let dailyForecastButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Ежедневный прогноз", for: .normal)
        view.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 18)
        view.titleLabel?.textAlignment = .left
        let color = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.setTitleColor(color, for: .normal)
        return view
    }()
    
    private let severDaysButton: UIButton = {
        let view = UIButton(type: .system)
        let title = NSAttributedString(string: "25 дней", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 16) as Any])
        view.setAttributedTitle(title, for: .normal)
        view.titleLabel?.textAlignment = .right
        let color = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.setTitleColor(color, for: .normal)
        return view
    }()
    
    lazy var headerView: UIView = {
        let view = HeaderView()
        return view
    }()
    
    private let hourlyLayoutForecast: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private let dailyLayoutForecast: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var firstCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: hourlyLayoutForecast)
        view.dataSource = self
        view.delegate = self
        view.register(HourlyForecastCollectionCell.self, forCellWithReuseIdentifier: "collection")
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var secondCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: dailyLayoutForecast)
        view.dataSource = self
        view.delegate = self
        view.register(DailyForecastCollectionViewCell.self, forCellWithReuseIdentifier: "secondCollection")
        view.backgroundColor = .white
        return view
    }()
    
    private let addCityButton: UIButton = {
        let view = UIButton(type: .system)
        view.tintColor = .black
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .ultraLight)
        let image = UIImage(systemName: "cross.fill", withConfiguration: imageConfig)
        view.setImage(image, for: .normal)
        view.isHidden = true
        view.addTarget(self, action: #selector(addCity), for: .touchUpInside)
        return view
    }()
    
    @objc func addCity() {
        guard let index = coordinator.rootController?.pages.count else { return }
        let vm = PageViewModel(index: index)
        let vc = PageViewConroller(vm: vm, coordinator: coordinator)
        vc.view.backgroundColor = .white
        coordinator.rootController?.pages.append(vc)
        let parent = self.parent as! UIPageViewController
        parent.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }
    
    init(vm: PageViewModel, coordinator: CarouselCoordinator) {
        viewModel = vm
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    private func constraints() {
        
        scrollView.snp.makeConstraints() { make in
            make.edges.equalTo(view.snp.edges)
        }

        contentView.snp.makeConstraints() { make in
            make.edges.width.equalTo(scrollView)
        }
        
        if addCityButton.isHidden {
         
            headerView.snp.makeConstraints{ make in
                make.centerX.equalTo(contentView.snp.centerX)
                make.top.equalTo(contentView.snp.top).offset(20)
                make.width.equalTo(344)
                make.height.equalTo(212)
            }
            
            detailedForecastButton.snp.makeConstraints{ make in
                make.trailing.equalTo(headerView.snp.trailing)
                make.top.equalTo(headerView.snp.bottom).offset(33)
                make.width.equalTo(174)
                make.height.equalTo(20)
            }
            
            firstCollectionView.snp.makeConstraints{ make in
                make.top.equalTo(detailedForecastButton.snp.bottom)
                make.leading.equalTo(contentView.snp.leading)
                make.width.equalTo(contentView.snp.width)
                make.height.equalTo(108)
            }
            
            dailyForecastButton.snp.makeConstraints{ make in
                make.leading.equalTo(headerView.snp.leading)
                make.top.equalTo(firstCollectionView.snp.bottom).offset(28)
                make.width.equalTo(200)
                make.height.equalTo(22)
            }
            
            severDaysButton.snp.makeConstraints{ make in
                make.trailing.equalTo(headerView.snp.trailing)
                make.top.equalTo(firstCollectionView.snp.bottom).offset(28)
                make.width.equalTo(83)
                make.height.equalTo(20)
            }
         
            secondCollectionView.snp.makeConstraints{ make in
                make.centerX.equalTo(contentView.snp.centerX)
                make.top.equalTo(severDaysButton.snp.bottom).offset(10)
                make.width.equalTo(344)
                make.height.equalTo(660)
                make.bottom.equalTo(contentView.snp.bottom)
            }

        } else {
            
            addCityButton.snp.makeConstraints{ make in
                make.center.equalTo(view.safeAreaLayoutGuide.snp.center)
                make.width.equalTo(100)
                make.height.equalTo(100)
                make.bottom.equalTo(contentView.snp.bottom)
            }
           
        }
         
    }
    
    func makeAllContentHidden() {
        headerView.isHidden = true
        firstCollectionView.isHidden = true
        detailedForecastButton.isHidden = true
        dailyForecastButton.isHidden = true
        severDaysButton.isHidden = true
        secondCollectionView.isHidden = true
        addCityButton.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(headerView, firstCollectionView, addCityButton, detailedForecastButton, dailyForecastButton, severDaysButton, secondCollectionView)
        constraints()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    func setFrames() {
        //        let safeBorders = view.safeAreaLayoutGuide
        //
        //        headerView.frame.origin.y = safeBorders.layoutFrame.origin.y + 26
        //        headerView.frame.origin.x = safeBorders.layoutFrame.origin.x + 16
        //        headerView.frame.size = CGSize(width: safeBorders.layoutFrame.width - 32, height: 212)
        //        headerView.subviews[0].center.x = view.safeAreaLayoutGuide.layoutFrame.midX
        //
        //        detailedForecastButton.frame.origin.x = safeBorders.layoutFrame.maxX - 189
        //        detailedForecastButton.frame.origin.y = headerView.frame.maxY + 33
        //        detailedForecastButton.frame.size = CGSize(width: 174, height: 20)
        //
        //        forecastSmallCollectionView.frame.origin.x = safeBorders.layoutFrame.origin.x + 16
        //        forecastSmallCollectionView.frame.origin.y = detailedForecastButton.frame.maxY + 10
        //        forecastSmallCollectionView.frame.size = CGSize(width: safeBorders.layoutFrame.width - 16, height: 103)
        //
        //        secondCollectionView.center.x = view.center.x
        //        secondCollectionView.frame.origin.y = forecastSmallCollectionView.frame.maxY + 72
        //        secondCollectionView.frame.size = CGSize(width: safeBorders.layoutFrame.width - 32, height: secondCollectionView.contentSize.height)
        //
        //        dailyForecastButton.frame.origin.x = safeBorders.layoutFrame.origin.x + 16
        //        dailyForecastButton.frame.origin.y = forecastSmallCollectionView.frame.maxY + 40
        //        dailyForecastButton.frame.size = CGSize(width: 200, height: 20)
        //
        //        severDaysButton.frame.origin.x = safeBorders.layoutFrame.maxX - 99
        //        severDaysButton.frame.origin.y = forecastSmallCollectionView.frame.maxY + 40
        //        severDaysButton.frame.size = CGSize(width: 83, height: 20)
        //
        //        addCityButton.center = view.center
    }
    
}

extension PageViewConroller: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.firstCollectionView {
            return 10
            
        } else if collectionView == self.secondCollectionView {
            return 10
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.firstCollectionView {
            
            let cellForecast = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! HourlyForecastCollectionCell
            cellForecast.layer.cornerRadius = 22
            cellForecast.layer.borderWidth = 0
            cellForecast.layer.shadowColor = UIColor(red: 0.4, green: 0.546, blue: 0.942, alpha: 0.68).cgColor
            cellForecast.layer.shadowOffset = CGSize(width: -5, height: 5)
            cellForecast.layer.shadowRadius = 5
            cellForecast.layer.shadowOpacity = 1
            cellForecast.layer.masksToBounds = false
            return cellForecast
            
        } else if collectionView == self.secondCollectionView {
            let secondCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCollection", for: indexPath) as! DailyForecastCollectionViewCell
            secondCollection.layer.cornerRadius = 5
            secondCollection.layer.borderWidth = 0
            secondCollection.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
            return secondCollection
            
        }
        
        return UICollectionViewCell(frame: .zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.secondCollectionView {
            let vc = DailyForecastViewController()
            coordinator.navController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension PageViewConroller: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.firstCollectionView {
            return CGSize(width: 42, height: 83)
        } else if collectionView == self.secondCollectionView {
            return CGSize(width: 344, height: 56)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == self.firstCollectionView {
            return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            
        } else if collectionView == self.secondCollectionView {
            return UIEdgeInsets(top: 0, left: 8, bottom: 10, right: 8)
        }
        
        return UIEdgeInsets()
    }
    
}


