//
//  DonutChart.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 16/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct ChartRating {
    let excellent: Int
    let good: Int
    let bad: Int
    let disaster: Int
}

struct DonutChart: View {

    let data: ChartRating

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(DonutChart.computeSegments(for: proxy.frame(in: .local), with: self.data)) { segment in
                    DonutChartSegment(segment: segment)
                }
            }
        }
    }
    
    private static func computeSegments(for rect: CGRect, with data: ChartRating) -> [DonutSegment] {
        let arrayData = [(data.disaster, Color.ratingDisaster), (data.bad, Color.ratingBad), (data.good, Color.ratingGood), (data.excellent, Color.ratingExcellent)]
        let total = arrayData.map { (value, _) in value }.reduce(0, +) // 😱 so cool
        let degreesPerPoint = 360.0 / Double(total)
        let radius = min(rect.width, rect.height) / 2
        let center = rect.center
        
        var lastDegree = 0.0
        var segments = [DonutSegment]()

        arrayData.forEach { (value, color) in
            let arcDegrees = Double(value) * degreesPerPoint
            let segment = DonutSegment(radius: radius, center: center, startDegree: lastDegree, endDegree: lastDegree + arcDegrees, value: value, color: color)
            
            segments.append(segment)
            lastDegree += arcDegrees
        }
        
        return segments
    }
}

#if DEBUG
struct DonutChart_Previews: PreviewProvider {
    static var previews: some View {
        // same data as in JMs example
        let data = ChartRating(
            excellent: 858,
            good: 358,
            bad: 115,
            disaster: 100
        )
        return DonutChart(data: data)
    }
}
#endif
