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
   
    private lazy var detailedTable: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.register(DetailedForecastTableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    func setConstraints() {
    
        detailedTable.snp.makeConstraints{ make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .yellow
       // view.addSubview(detailedTable)
      
       // setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
