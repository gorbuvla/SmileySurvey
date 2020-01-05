//
//  Survey.swift
//  SmileSurvey
//
//  Created by Vlad Gorbunov on 10/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//
import Foundation

struct Survey: Identifiable {
    let id = UUID()
    let name: String
    let question: String
    var excellent: Int = 0
    var good: Int = 0
    var bad: Int = 0
    var disaster: Int = 0
    
    var totalCorrespondents: Int {
        get { excellent + good + bad + disaster }
    }
}

extension DbSurvey {
    
    func toDomainSurvey() throws -> Survey {
        return Survey(name: name!, question: question!, excellent: Int(excellent), good: Int(good), bad: Int(bad), disaster: Int(disaster))
    }
}
