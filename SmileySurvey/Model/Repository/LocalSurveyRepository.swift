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
    
    private static let initialSurveys = (1...10).map { number in
        Survey(name: "Survey \(number) 🤔", question: "How was your meal?", excellent: 858, good: 358, bad: 115, disaster: 100)
    }
    
    private let surveysSubject = CurrentValueSubject<[Survey], Never>(initialSurveys)
    
    func observeSurveys() -> AnyPublisher<[Survey], Never> {
        return surveysSubject.eraseToAnyPublisher()
    }
    
    func createSurvey(survey: Survey) -> AnyPublisher<(), Never> {
        let surveys = surveysSubject.value + [survey]
        surveysSubject.send(surveys)
        
        return Just(())
            .delay(for: 2, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
