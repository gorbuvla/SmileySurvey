//
//  DonutChartSegment.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 16/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct DonutSegment: Identifiable {
    let id = UUID()
    let radius: CGFloat
    let center: CGPoint
    let startDegree: Double
    let endDegree: Double
    let value: Int
    let color: Color
    
    var outerRadius: CGFloat {
        get { radius }
    }
    
    var innerRadius: CGFloat {
        get { radius / 2 }
    }
}

struct DonutChartSegment: View {
    
    let segment: DonutSegment
    
    var body: some View {
        path.fill()
            .foregroundColor(segment.color)
    }
    
    private var path: Path {
        var path = Path()
        path.addArc(center: segment.center, radius: segment.outerRadius, startAngle: Angle(degrees: segment.startDegree), endAngle: Angle(degrees: segment.endDegree), clockwise: false)
        path.addArc(center: segment.center, radius: segment.innerRadius, startAngle: Angle(degrees: segment.endDegree), endAngle: Angle(degrees: segment.startDegree), clockwise: true)
        path.closeSubpath()
        return path
    }
}

#if DEBUG
struct DonutChartSegment_Previews: PreviewProvider {
    
    static var previews: some View {
        GeometryReader { proxy in
            viewForRect(proxy.frame(in: .local))
        }.frame(width: 200, height: 200)
    }
    
    static func viewForRect(_ rect: CGRect) -> DonutChartSegment {
        let radius = min(rect.width, rect.height) / 2
        let center = rect.center
        let segment = DonutSegment(radius: radius, center: center, startDegree: 0, endDegree: 45, value: 10, color: Color.green)
        
        return DonutChartSegment(segment: segment)
    }
}
#endif
