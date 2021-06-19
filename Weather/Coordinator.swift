//
//  Coordinator.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.06.2021.
//

import Foundation
import UIKit

protocol Coordinator {
    var navController: UINavigationController? { get set}
    func start()
}
