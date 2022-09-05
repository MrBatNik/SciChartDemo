//
//  SciChartView.swift
//  SciChartDemo
//
//  Created by Nikita Batrakov on 03.09.2022.
//

import SciChart

class SciChartView: UIView {
    private var surface: SCIChartSurface!
    private var scatterData: SCIIntegerValues!
    private var scatterDataSeries: SCIXyDataSeries!
    private var xValues: SCIDateValues!
    private var scatterSeries: SCIXyScatterRenderableSeries!
    private var pointMarker: SCIEllipsePointMarker!
    private var xAxes: SCIDateAxis!
    private var yAxes: SCINumericAxis!
    private var horizontalLine: SCIHorizontalLineAnnotation!
    private var rightMarker: SCIAxisMarkerAnnotation!
    private var panModifier: SCIZoomPanModifier!
    private var zoomModifier: SCIPinchZoomModifier!
    
    convenience init (_ point: PointModel) {
        self.init(frame: .zero)
        setStartPoint(point)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SciChartView {
    func setup() {
        surface = SCIChartSurface()
        
        surface.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(surface)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            surface.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            surface.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            surface.leftAnchor.constraint(equalTo: leftAnchor),
            surface.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func setStartPoint(_ point: PointModel) {
        scatterData = SCIIntegerValues()
        scatterDataSeries = SCIXyDataSeries(xType: .date, yType: .int)
        xValues = SCIDateValues()
        scatterSeries = SCIXyScatterRenderableSeries()
        pointMarker = SCIEllipsePointMarker()
        xAxes = SCIDateAxis()
        yAxes = SCINumericAxis()
        horizontalLine = SCIHorizontalLineAnnotation()
        rightMarker = SCIAxisMarkerAnnotation()
        panModifier = SCIZoomPanModifier()
        zoomModifier = SCIPinchZoomModifier()
        
        xValues.add(point.coordinates.x)
        
        scatterData.add(Int32(point.coordinates.y))
        scatterDataSeries.append(x: xValues, y: scatterData)
        
        pointMarker.fillStyle = SCISolidBrushStyle(color: 0xFF32CD32)
        pointMarker.size = CGSize(width: 10, height: 10)
        
        scatterSeries.dataSeries = scatterDataSeries
        scatterSeries.pointMarker = pointMarker
        
        xAxes.visibleRange = SCIDateRange(
            min: point.coordinates.x,
            max: point.coordinates.x.addingTimeInterval(30)
        )
        yAxes.autoRange = .always
        
        horizontalLine.isEditable = true
        horizontalLine.horizontalAlignment = .right
        horizontalLine.stroke = SCISolidPenStyle(color: 0xFFFC9C29, thickness: 2)
        
        rightMarker.isEditable = true
        rightMarker.borderPen = SCISolidPenStyle(color: 0xFF4083B7, thickness: 1)
        rightMarker.backgroundBrush = SCISolidBrushStyle(color: 0xAA4083B7)
        
        updateAnnotations(point)
        
        panModifier.direction = .xDirection
        zoomModifier.direction = .xDirection
        
        SCIUpdateSuspender.usingWith(surface) {
            self.surface.xAxes.add(items: self.xAxes)
            self.surface.yAxes.add(items: self.yAxes)
            self.surface.renderableSeries.add(self.scatterSeries)
            self.surface.annotations.add(items: self.horizontalLine, self.rightMarker)
            self.surface.chartModifiers.add(items: self.panModifier,
                                            self.zoomModifier,
                                            SCIZoomExtentsModifier())
        }
    }
    
    func updateAnnotations(_ point: PointModel) {
        if !surface.annotations.isEmpty {
            surface.annotations.remove(horizontalLine)
            surface.annotations.remove(rightMarker)
        }
        
        horizontalLine.set(x1: point.coordinates.x)
        horizontalLine.set(y1: point.coordinates.y)
        rightMarker.set(y1: point.coordinates.y)
    }
}

extension SciChartView {
    func updateChart(_ point: PointModel) {
        updateAnnotations(point)
        SCIUpdateSuspender.usingWith(surface) {
            self.scatterDataSeries.append(x: point.coordinates.x, y: point.coordinates.y)
            self.surface.annotations.add(items: self.horizontalLine ,self.rightMarker)
            self.surface.zoomExtentsY()
        }
    }
}
