//
//  Colors.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 25/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

extension Color {
    
    static let ratingDisaster = Color(hex: "ED2327")
    
    static let ratingBad = Color(hex: "F37D7F")
    
    static let ratingGood = Color(hex: "97CE71")
    
    static let ratingExcellent = Color(hex: "049D30")
    
    static let ratingEmpty = Color(hex: "CCCCCC")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}
