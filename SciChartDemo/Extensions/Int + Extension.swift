//
//  Int + Extension.swift
//  SciChartDemo
//
//  Created by Nikita Batrakov on 03.09.2022.
//

import Foundation

extension Int {
    static func random() -> Int {
        Self.random(in: -1...1)
    }
}
