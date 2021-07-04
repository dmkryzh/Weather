//
//  PageViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.06.2021.
//

import Foundation
import RealmSwift


class PageViewModel {
    
    var data: DataFromNetwork
    
    let currentDate = Date()
    
//    func getDailyForecast(_ dayNumber: Int) {
//        date = data.getData("@dt = %@ WHERE index = \(dayNumber)")
//    }
    
    var date: Int?

    var rain: Int?

    var title: Int?

    var temp: Int?

    var cityName: Int?


//
    var pageIndex: Int
    
    var selectedCell = [IndexPath]()
    
    init(index: Int, data: DataFromNetwork) {
        pageIndex = index
        self.data = data
        
    }
}
