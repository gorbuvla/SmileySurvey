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
    
    func create(survey: Survey) -> AnyPublisher<(), Never> {
        return Deferred {
            Future<(), Never> { promise in
                let surveys = self.surveysSubject.value + [survey]
                self.surveysSubject.send(surveys)
                
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
    
    func delete(survey: Survey) -> AnyPublisher<(), Never> {
        return Deferred {
            Future<(), Never> { promise in
                let surveys = self.surveysSubject.value.filter { item in item.id != survey.id }
                
                self.surveysSubject.send(surveys)
                
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
}
