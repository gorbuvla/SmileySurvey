//
//  ShakeModifier.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 09/02/2020.
//  Copyright © 2020 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)), y: 0))
    }
}
