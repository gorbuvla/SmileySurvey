//
//  SurveyRepository.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 26/01/2020.
//  Copyright © 2020 Vlad Gorbunov. All rights reserved.
//

import Foundation
import Combine

protocol CurrentSurveyStore: class {
    
    var currentSurveyId: UUID? { get set }
}

protocol CurrentSurveyProvider {
    
    var selectedSurveyId: AnyPublisher<UUID, Never> { get }
}

final class SurveyStore: CurrentSurveyStore, CurrentSurveyProvider {
    
    private let surveyIdSubject = CurrentValueSubject<UUID?, Never>(nil)
    
    var currentSurveyId: UUID? {
        get {
            surveyIdSubject.value
        }
        set {
            surveyIdSubject.send(newValue)
        }
    }
    
    var selectedSurveyId: AnyPublisher<UUID, Never> {
        get {
            surveyIdSubject.compactMap { $0 }.eraseToAnyPublisher()
        }
    }
}
