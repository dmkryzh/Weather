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
    
    var coordinator: CarouselCoordinator
    
   
    private lazy var detailedTable: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.register(DetailedForecastTableViewCell.self, forCellReuseIdentifier: "cell")
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
    
    @objc func backToPreviousController() {
        coordinator.backToPreviousView()
    }
    
    func setConstraints() {
    
        detailedTable.snp.makeConstraints{ make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(detailedTable)
        let back = UIBarButtonItem(customView: backButton)
        navigationItem.setLeftBarButton(back, animated: true)
        setConstraints()
    }

    init(coordinator: CarouselCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailedForecastTableViewCell
        return cell
    }
    
    
    
    
}
