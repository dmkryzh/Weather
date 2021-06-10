//
//  Coordinator.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.06.2021.
//

import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
