//
//  ChartPresenter.swift
//  SciChartDemo
//
//  Created by Nikita Batrakov on 03.09.2022.
//

import Foundation

protocol ChartPresenterProtocol {
    init(_ view: ChartViewProtocol, point: PointModel)
    func updateChart()
}

final class ChartPresenter: ChartPresenterProtocol {
    private unowned var view: ChartViewProtocol
    private var point: PointModel
    
    required init(_ view: ChartViewProtocol, point: PointModel) {
        self.view = view
        self.point = point
    }
    
    func updateChart() {
        let increment = increment(point)
        point = PointModel(x: increment.x, y: increment.y)
        view.updateChart(point)
    }
    
    private func increment(_ point: PointModel) -> (x: Date, y: Int) {
        (point.coordinates.x.addingTimeInterval(1),
         point.coordinates.y + Int.random())
    }
}
