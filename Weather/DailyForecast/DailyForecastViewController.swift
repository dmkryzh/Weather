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
    
    var selectedCell = [IndexPath]()
    
    var coordinator: CarouselCoordinator
    
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
    
    private let cityName: UILabel = {
        let view = UILabel()
        view.text = "Чита"
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
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
    }
    
    override func viewDidLoad() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(cityName, dayTable, nightTable, collectionView)
        view.backgroundColor = .white
        let back = UIBarButtonItem(customView: backButton)
        navigationItem.setLeftBarButton(back, animated: true)
        setConstraints()
    }
    
    init(vm: DailyForecastViewModel, coordinator: CarouselCoordinator) {
        viewModel = vm
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DailyForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == dayTable {
        let day = DailyForecastHeaderCell()
            day.header.text = "День"
            return day
        } else if tableView == nightTable {
            let night = DailyForecastHeaderCell()
            night.header.text = "Ночь"
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
        
        
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastCell
            cell.iconTextAndBounds(icon: WeatherIcons.temperature.getIcon(), iconText: "   По ощущениям", statusText: "11", isWithCircle: true, bounds: CGRect(x: 0, y: -7, width: 24, height: 26))
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastCell
            cell.iconTextAndBounds(icon: WeatherIcons.wind.getIcon(), iconText: "   Ветер", statusText: "5 m\\s ЗЮЗ", bounds: CGRect(x: 0, y: -2, width: 24, height: 14))
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastCell
            cell.iconTextAndBounds(icon: WeatherIcons.ultravioletLevel.getIcon(), iconText: "   Уф индекс", statusText: "4( умерен.)", bounds: CGRect(x: 0, y: -7, width: 24, height: 27))
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastCell
            cell.iconTextAndBounds(icon: WeatherIcons.rain.getIcon(), iconText: "   Дождь", statusText: "55%", bounds: CGRect(x: 0, y: -9, width: 24, height: 30))
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastCell
            cell.iconTextAndBounds(icon: WeatherIcons.cloud.getIcon(), iconText: "   Облачность", statusText: "72%", bounds: CGRect(x: 0, y: -6, width: 24, height: 17))
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
        guard !selectedCell.contains(indexPath) else { return }
        let cell = collectionView.cellForItem(at: indexPath) as! DailyForecastCollectionCell
        selectedCell = [indexPath]
        cell.backgroundColor = .blue
        cell.date.textColor = .white
        collectionView.reloadData()
    }
    
    

}

extension DailyForecastViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! DailyForecastCollectionCell
        
        if selectedCell.contains(indexPath) {
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

