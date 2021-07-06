//
//  SettingsViewController.swift
//  Weather
//
//  Created by Dmitrii KRY on 17.06.2021.
//

import Foundation
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    let skyImageViewOne: UIImageView = {
        let image = UIImage(named: "Vector")
        let view = UIImageView(image: image)
        view.alpha = 0.3
        return view
    }()
    
    let skyImageViewTwo: UIImageView = {
        let image = UIImage(named: "Vector-2")
        let view = UIImageView(image: image)
        return view
    }()
    
    let skyImageViewThree: UIImageView = {
        let image = UIImage(named: "Vector-3")
        let view = UIImageView(image: image)
        return view
    }()
    
    lazy var settings: SettingsView = {
        let view = SettingsView()
        view.didTap = { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
        return view
    }()
    
    
    
    func setConstrains() {
        
        settings.snp.makeConstraints{ make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(320)
            make.height.equalTo(330)
        }
        
        skyImageViewOne.snp.makeConstraints{ make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(37)
        }
        
        skyImageViewTwo.snp.makeConstraints{ make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(121)
        }
        
        skyImageViewThree.snp.makeConstraints{ make in
            make.top.equalTo(settings.snp.bottom).offset(81)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(80)
        }
        
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.addSubviews(settings, skyImageViewOne, skyImageViewTwo, skyImageViewThree)
        setConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}
