//
//  PageViewConroller.swift
//  Weather
//
//  Created by Dmitrii KRY on 10.06.2021.
//

import Foundation
import UIKit
import SnapKit

class HeaderView: UIView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 344, height: 212))
        backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
  
        let path = UIBezierPath(ovalIn: CGRect(x: 33, y: 17, width: 280, height: 246))
        
        let clip = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 344, height: 140))
        
        let color = UIColor(red: 0.967, green: 0.868, blue: 0.004, alpha: 1)
        
        clip.addClip()
        path.lineWidth = 3
        path.lineCapStyle = .round
        color.setStroke()
        path.stroke()
        
    }
    
}

class PageViewConroller: UIViewController {
    
    let headerView: UIView = {
        let view = HeaderView()
        return view
    }()
    
    func constraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    convenience init(color: UIColor) {
        self.init()
        view.backgroundColor = color
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerView)
        //constraints()
    }
    
    override func viewDidLayoutSubviews() {
        //headerView.frame.origin.x = view.safeAreaLayoutGuide.layoutFrame.origin.x + 16
        headerView.frame.origin.y = view.safeAreaLayoutGuide.layoutFrame.origin.y + 26
        headerView.center.x = view.center.x
    }
}

