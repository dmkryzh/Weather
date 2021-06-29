//
//  SunAndMoonView.swift
//  Weather
//
//  Created by Dmitrii KRY on 26.06.2021.
//

import Foundation
import UIKit
import SnapKit

class SunAndMoonView: UIView {
    
    let titleLeft: UILabel = {
        let view = UILabel()
        view.text = "Солнце и Луна"
        view.textColor = .black
        return view
    }()
    
    let titleRight: UILabel = {
        let view = UILabel()
        view.text = "Полнолуние"
        view.textColor = .black
        return view
    }()
    
    let titleRightIcon: UIImageView = {
        let image = UIImage(systemName: "circle.fill")
        let view = UIImageView(image: image)
        return view
    }()
    
    lazy var sunView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(SunAndMoonCell.self, forCellReuseIdentifier: "cell")
        view.isUserInteractionEnabled = false
        view.separatorStyle = .none
        return view
    }()
    
    lazy var moonView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(SunAndMoonCell.self, forCellReuseIdentifier: "cell")
        view.isUserInteractionEnabled = false
        view.separatorStyle = .none
        return view
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        return view
    }()
    
    func setConstraints() {
        
        titleLeft.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.height.equalTo(22)
            make.width.equalTo(130)
        }
        
        titleRight.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        
        titleRightIcon.snp.makeConstraints { make in
            make.centerY.equalTo(titleRight.snp.centerY)
            make.trailing.equalTo(titleRight.snp.leading)
            make.height.equalTo(15)
            make.width.equalTo(15)
        }
        
        sunView.snp.makeConstraints { make in
            make.top.equalTo(titleLeft.snp.bottom).offset(20)
            make.leading.equalTo(self.snp.leading)
            make.height.equalTo(100)
            make.width.equalTo(160)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(titleLeft.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(0.5)
        }
        
        moonView.snp.makeConstraints { make in
            make.top.equalTo(titleLeft.snp.bottom).offset(20)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(100)
            make.width.equalTo(160)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(titleLeft, titleRight, titleRightIcon, sunView, separator, moonView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SunAndMoonView: UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        36
    }
    
}

extension SunAndMoonView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SunAndMoonCell
        cell.addDashedBottomBorder()
        
        if tableView == sunView {
            
            switch indexPath.item {
            case 0:
                let image = UIImage(named: "Frame")
                cell.updateCell(image: image, leftText: nil, rightText: "14ч 27 мин")
                
                return cell
            case 1:
                cell.updateCell(image: nil, leftText: "Восход", rightText: "05:19")
                
                return cell
            case 2:
                cell.updateCell(image: nil, leftText: "Заход", rightText: "19:46")
                
                return cell
            default:
                
                return cell
            }
            
        } else if tableView == moonView {
            switch indexPath.item {
            case 0:
                let image = UIImage(named: "crescent-moon_1")
                cell.updateCell(image: image, leftText: nil, rightText: "14ч 27 мин")
                
                return cell
            case 1:
                cell.updateCell(image: nil, leftText: "Восход", rightText: "05:19")
                
                return cell
            case 2:
                cell.updateCell(image: nil, leftText: "Заход", rightText: "19:46")
                
                return cell
            default:
                
                return cell
            }
        }
        return cell
    }
}
