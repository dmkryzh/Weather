//
//  DailyForecastViewController.swift
//  Weather
//
//  Created by Dmitrii KRY on 24.06.2021.
//

import Foundation
import UIKit
import SnapKit

class DailyForecastViewController: UIViewController {
    
    var viewModel: DailyForecastViewModel
    
    var coordinator: CarouselCoordinator
    
    let sunAndMoonView = SunAndMoonView()
    
    let airQuality = AirQualityView()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var backButton: UIButton = {
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "arrow.backward")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 20, height: 17)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " Дневная погода")
        completeText.append(textAfterIcon)
        
        
        let view = UIButton(type: .system)
        view.setAttributedTitle(completeText, for: .normal)
        view.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        view.titleLabel?.textAlignment = .left
        
        let color = UIColor.gray
        view.setTitleColor(color, for: .normal)
        view.addTarget(self, action: #selector(backToPreviousController), for: .touchUpInside)
        return view
    }()
    
    let cityName: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        view.textAlignment = .left
        return view
    }()
    
    
    @objc func backToPreviousController() {
        coordinator.backToPreviousView()
    }
    
    private lazy var dayTable: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        view.register(DailyForecastCell.self, forCellReuseIdentifier: "cell")
        view.register(DailyForecastHeaderCell.self, forHeaderFooterViewReuseIdentifier: "header")
        view.layer.cornerRadius = 5
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var nightTable: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        view.register(DailyForecastCell.self, forCellReuseIdentifier: "cell")
        view.register(DailyForecastHeaderCell.self, forHeaderFooterViewReuseIdentifier: "header")
        view.layer.cornerRadius = 5
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let dailyLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: dailyLayout)
        view.dataSource = self
        view.delegate = self
        view.register(DailyForecastCollectionCell.self, forCellWithReuseIdentifier: "collection")
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .white
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        return view
    }()
    
    func setConstraints() {
        
        scrollView.snp.makeConstraints() { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        contentView.snp.makeConstraints() { make in
            make.edges.width.equalTo(scrollView)
        }
        
        cityName.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(48)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom).offset(40)
            make.leading.equalTo(contentView.snp.leading)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(40)
        }
        
        dayTable.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(40)
            make.width.equalTo(344)
            make.height.equalTo(335)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        nightTable.snp.makeConstraints { make in
            make.top.equalTo(dayTable.snp.bottom).offset(12)
            make.width.equalTo(344)
            make.height.equalTo(335)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        sunAndMoonView.snp.makeConstraints { make in
            make.top.equalTo(nightTable.snp.bottom).offset(20)
            make.width.equalTo(344)
            make.height.equalTo(145)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        airQuality.snp.makeConstraints { make in
            make.top.equalTo(sunAndMoonView.snp.bottom).offset(25)
            make.width.equalTo(344)
            make.height.equalTo(160)
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
    }
    
    override func viewDidLoad() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(cityName, dayTable, nightTable, collectionView, sunAndMoonView, airQuality)
        view.backgroundColor = .white
        let back = UIBarButtonItem(customView: backButton)
        navigationItem.setLeftBarButton(back, animated: true)
        cityName.text = viewModel.cityName
        setConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let indexPath = IndexPath(item: viewModel.index ?? 0, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
    }
    
    init(vm: DailyForecastViewModel, coordinator: CarouselCoordinator) {
        viewModel = vm
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        vm.dataDidLoad = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DailyForecastViewController: DailyForecastViewModelUpdate {
    func dataDidLoad() {
        dayTable.reloadData()
        nightTable.reloadData()
    }
}

extension DailyForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == dayTable {
            let day = DailyForecastHeaderCell()
            day.header.text = "День"
            day.centralTemperatureImage.image = UIImage(named: WeatherIcon.getMappedIcon(viewModel.icon ?? ""))
            day.weatherStateText.text = viewModel.title
            let completedText = NSMutableAttributedString(string: "")
            let temp = NSAttributedString(string: " \(Int(viewModel.temperatureDay ?? 0))")
            let gradus = NSAttributedString(attachment: day.gradusIcon)
            let image = NSAttributedString(attachment: day.centralTemperatureImage)
            completedText.append(image)
            completedText.append(temp)
            completedText.append(gradus)
            day.centralTemperature.attributedText = completedText
            return day
            
        } else if tableView == nightTable {
            let night = DailyForecastHeaderCell()
            night.header.text = "Ночь"
            
            night.centralTemperatureImage.image = UIImage(named: WeatherIcon.getMappedIcon(viewModel.icon ?? ""))
            night.weatherStateText.text = viewModel.title
            let completedText = NSMutableAttributedString(string: "")
            let temp = NSAttributedString(string: " \(Int(viewModel.temperatureNight ?? 0))")
            let gradus = NSAttributedString(attachment: night.gradusIcon)
            let image = NSAttributedString(attachment: night.centralTemperatureImage)
            completedText.append(image)
            completedText.append(temp)
            completedText.append(gradus)
            night.centralTemperature.attributedText = completedText
            
            return night
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
}

extension DailyForecastViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        viewModel.getForecast(index: indexPath.item, city: viewModel.cityName)
        
        var tempFeel = 0
        
        if tableView == dayTable {
            tempFeel = Int(viewModel.tempFeelsLikeDay ?? 0)
          
        } else if tableView == nightTable {
            tempFeel = Int(viewModel.tempFeelsLikeNight ?? 0)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastCell
        
        
        
        switch indexPath.item {
        case 0:
            cell.iconTextAndBounds(icon: WeatherIcons.temperature.getIcon(), iconText: "   По ощущениям", statusText: "\(tempFeel)", isWithCircle: true, bounds: CGRect(x: 0, y: -7, width: 24, height: 26))
            return cell
        case 1:
            let text = Int(viewModel.wind ?? 0)
            cell.iconTextAndBounds(icon: WeatherIcons.wind.getIcon(), iconText: "   Ветер", statusText: "\(text) м/с", bounds: CGRect(x: 0, y: -2, width: 24, height: 14))
            return cell
        case 2:
            let text = Int(viewModel.uvi ?? 0)
            cell.iconTextAndBounds(icon: WeatherIcons.ultravioletLevel.getIcon(), iconText: "   Уф индекс", statusText: "\(text)", bounds: CGRect(x: 0, y: -7, width: 24, height: 27))
            return cell
        case 3:
            let text = Int(viewModel.rain ?? 0)
            cell.iconTextAndBounds(icon: WeatherIcons.rain.getIcon(), iconText: "   Дождь", statusText: "\(text)%", bounds: CGRect(x: 0, y: -9, width: 24, height: 30))
            return cell
        case 4:
            let text = viewModel.clouds
            cell.iconTextAndBounds(icon: WeatherIcons.cloud.getIcon(), iconText: "   Облачность", statusText: "\(text ?? 0)%", bounds: CGRect(x: 0, y: -6, width: 24, height: 17))
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    
}

extension DailyForecastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 90, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !viewModel.selectedCell.contains(indexPath.item) else { return }
        let cell = collectionView.cellForItem(at: indexPath) as! DailyForecastCollectionCell
        viewModel.selectedCell = [indexPath.item]
        cell.backgroundColor = .blue
        cell.date.textColor = .white
        collectionView.reloadData()
        
        viewModel.getForecast(index: indexPath.item, city: viewModel.cityName!)
        
        dayTable.reloadData()
        nightTable.reloadData()
    }
    
    
    
}

extension DailyForecastViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! DailyForecastCollectionCell
        cell.date.text = viewModel.datesArray[indexPath.item]
        
        if viewModel.selectedCell.contains(indexPath.item) {
            cell.backgroundColor = .blue
            cell.date.textColor = .white
        }
        else {
            cell.backgroundColor = .white
            cell.date.textColor = .black
        }
        
        return cell
        
    }
    
    
}

