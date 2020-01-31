//
//  StdExtensions.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 30/01/2020.
//  Copyright © 2020 Vlad Gorbunov. All rights reserved.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
