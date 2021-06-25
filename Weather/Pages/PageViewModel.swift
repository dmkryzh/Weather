//
//  PageViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.06.2021.
//

import Foundation


class PageViewModel {
   
    var pageIndex: Int
    
    var selectedCell = [IndexPath]()
    
    init(index: Int) {
        pageIndex = index
    }
}
