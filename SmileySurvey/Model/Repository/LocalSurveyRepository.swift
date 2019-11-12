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
            Survey(id: "\(number)", name: "Survey \(number) 🤔", question: "vbn")
        }
        return Just(surveys)
            //.delay(for: 2.0, scheduler: DispatchQueue.global())
            .eraseToAnyPublisher()
    }
}
