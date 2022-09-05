//
//  ChartViewController.swift
//  SciChartDemo
//
//  Created by Nikita Batrakov on 03.09.2022.
//

import UIKit

protocol ChartViewProtocol: AnyObject {
    func updateChart(_ point: PointModel)
}

final class ChartViewController: UIViewController {
    private var presenter: ChartPresenterProtocol!
    private var point: PointModel!
    private var timer: Timer!
    private var chartView: SciChartView!
    
    deinit {
        print(ChartViewController.self, "deallocated")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activateTimer()
    }
}

private extension ChartViewController {
    func setup() {
        view.backgroundColor = .white
        title = "Chart demo"
        
        point = PointModel()
        chartView = SciChartView(point)
        presenter = ChartPresenter(self, point: point)
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartView)
    }
    
    func activateTimer() {
        timer = Timer(timeInterval: 1.0, repeats: true, block: { [weak self] _ in
            self?.presenter.updateChart()
        })
        
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ChartViewController: ChartViewProtocol {
    func updateChart(_ point: PointModel) {
        chartView.updateChart(point)
    }
}
