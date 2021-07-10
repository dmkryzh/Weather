//
//  DetailedForecastViewController.swift
//  Weather
//
//  Created by Dmitrii KRY on 18.06.2021.
//

import Foundation
import UIKit
import SnapKit

class DetailedForecastViewController: UIViewController {
    
    var viewModel: DetailedForecastViewModel
    
    var coordinator: CarouselCoordinator
   
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let chartsCollectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var chartsCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: chartsCollectionLayout)
        view.dataSource = self
        view.delegate = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collection")
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        return view
    }()
    
    private lazy var detailedTable: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.separatorColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.register(DetailedForecastTableViewCell.self, forCellReuseIdentifier: "cell")
        view.allowsSelection = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "arrow.backward")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 20, height: 17)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " Прогноз на 24 часа")
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

        chartsCollectionView.snp.makeConstraints() { make in
            make.top.equalTo(cityName.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(180)
        }
        
        detailedTable.snp.makeConstraints{ make in
            make.top.equalTo(chartsCollectionView.snp.bottom).offset(15)
            make.height.equalTo(0)
            make.leading.bottom.trailing.equalTo(contentView)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(cityName, chartsCollectionView, detailedTable)
        let back = UIBarButtonItem(customView: backButton)
        navigationItem.setLeftBarButton(back, animated: true)
        setConstraints()
    }
    
    var height: CGFloat = 0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        height = detailedTable.contentSize.height
        detailedTable.layoutIfNeeded()
        detailedTable.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    
    init(coordinator: CarouselCoordinator, vm: DetailedForecastViewModel) {
        self.coordinator = coordinator
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
        vm.dataDidLoad = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension DetailedForecastViewController: DetailedForecastViewModelUpdate {
    func dataDidLoad() {
        chartsCollectionView.reloadData()
        detailedTable.reloadData()
    }
    
    
}

extension DetailedForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
}

extension DetailedForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailedForecastTableViewCell
        
        cell.cloudyStatus.text = "\(String(describing: viewModel.clouds![indexPath.item]))%"
        cell.windStatus.text = "\(String(describing: viewModel.wind![indexPath.item]))"
        cell.timeLabel.text = viewModel.timeline![indexPath.item]
        
        let completedText = NSMutableAttributedString(string: "")
        let temp = NSAttributedString(string: "\(String(describing: Int(viewModel.arrayOfHourlyForecast![indexPath.item]) ))")
        completedText.append(temp)
        completedText.append(cell.iconGradus)
        cell.degreesLabel.attributedText = completedText
        
        if indexPath.item != 0 {
            cell.dateLabel.text = ""
        }
        
        return cell
    }
    
}

extension DetailedForecastViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 400, height: 150)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension DetailedForecastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath)
        let time = viewModel.timeline!
        let array = viewModel.arrayOfHourlyForecast!
        let icons = viewModel.icons!
        let view = HourlyForecastChartView(time, array, CGRect(x: 0, y: 0, width: 400, height: 150), icons)
        cell.addSubview(view)
        return cell
}
}
