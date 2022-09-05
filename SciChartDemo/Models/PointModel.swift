//
//  PointModel.swift
//  SciChartDemo
//
//  Created by Nikita Batrakov on 03.09.2022.
//

import Foundation

struct PointModel {
    private let x: Date
    private let y: Int
    
    init(x: Date = Date(), y: Int = Int.random()) {
        self.x = x
        self.y = y
    }
}

extension PointModel {
    var coordinates: (x: Date, y: Int) {
        (x, y)
    }
}
