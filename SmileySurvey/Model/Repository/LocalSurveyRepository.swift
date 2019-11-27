//
//  LocalSurveyRepository.swift
//  SmileSurvey
//
//  Created by Vlad Gorbunov on 10/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Combine
import Foundation

final class MockedSurveyRepository: SurveyRepositoring {
    
    func observeSurveys() -> AnyPublisher<[Survey], Never> {
        let surveys = (1...10).map { number in
            Survey(name: "Survey \(number) 🤔", question: "How was your meal?", excellent: 858, good: 358, bad: 115, disaster: 100)
        }
        return Just(surveys)
            //.delay(for: 2.0, scheduler: DispatchQueue.global())
            .eraseToAnyPublisher()
    }
}
