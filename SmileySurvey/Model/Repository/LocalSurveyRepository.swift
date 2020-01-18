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
    
    func observe(filter: FilterOption) -> AnyPublisher<[Survey], Never> {
        return surveysSubject
            .map {
                $0.filter { survey in
                    if case .single(let id) = filter {
                        return survey.id == id
                    } else {
                        return true
                    }
                }
            }.eraseToAnyPublisher()
    }
    
    func observe() -> AnyPublisher<[Survey], Never> {
        return surveysSubject.eraseToAnyPublisher()
    }
    
    func update(_ survey: Survey, rating: Rating) -> AnyPublisher<(), Error> {
        return Deferred {
            Future<(), Error> { promise in
                let matched = self.surveysSubject.value.first { $0.id == survey.id }?.plus(rating: rating)
                let others = self.surveysSubject.value.filter { $0.id != survey.id }
                
                if let update = matched {
                    self.surveysSubject.send(others + [update])
                } else {
                    self.surveysSubject.send(others)
                }
                
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
    
    func create(survey: Survey) -> AnyPublisher<(), Error> {
        return Deferred {
            Future<(), Error> { promise in
                let surveys = self.surveysSubject.value + [survey]
                self.surveysSubject.send(surveys)
                
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
    
    func delete(survey: Survey) -> AnyPublisher<(), Error> {
        return Deferred {
            Future<(), Error> { promise in
                let surveys = self.surveysSubject.value.filter { item in item.id != survey.id }
                
                self.surveysSubject.send(surveys)
                
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
}

private extension Survey {
    func plus(rating: Rating) -> Survey {
        var ret = self
        
        switch rating {
        case .excellent:
            ret.excellent += 1
        case .good:
            ret.good += 1
        case .bad:
            ret.bad += 1
        case .disaster:
            ret.disaster += 1
        }
        
        return ret
    }
}
