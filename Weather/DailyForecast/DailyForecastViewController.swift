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
    
    func setConstraints() {
        
        dayTable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.width.equalTo(344)
            make.height.equalTo(335)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        nightTable.snp.makeConstraints { make in
            make.top.equalTo(dayTable.snp.bottom).offset(12)
            make.width.equalTo(344)
            make.height.equalTo(335)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    override func viewDidLoad() {
        view.addSubviews(dayTable, nightTable)
        view.backgroundColor = .white
        setConstraints()
    }
    
    init(vm: DailyForecastViewModel) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DailyForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        DailyForecastHeaderCell()
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
            cell.leftLabelImage.image = WeatherIcons.temperature.getIcon()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastCell
            cell.leftLabelImage.image = WeatherIcons.wind.getIcon()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastCell
            cell.leftLabelImage.image = WeatherIcons.ultravioletLevel.getIcon()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastCell
            cell.leftLabelImage.image = WeatherIcons.rain.getIcon()
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastCell
            cell.leftLabelImage.image = WeatherIcons.cloud.getIcon()
            return cell
        default:
            return UITableViewCell()
        }
      
    }
    
    
    
    
}

