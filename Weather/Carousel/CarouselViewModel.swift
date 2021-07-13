//
//  CarouselViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 12.07.2021.
//

import Foundation
import RealmSwift

class CarouselViewModel {
    
    lazy var realm: Realm? = {
        return try? Realm()
    }()
    
    var cities = [String: Int]()
    
    func getCities() {
        let array = realm!.objects(City.self)
        array.forEach { element in
            cities[element.city] = element.index
        }
    }
    
}
