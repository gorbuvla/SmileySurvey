//
//  ActiveSurveyViewModel.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 25/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import Combine

class ActiveSurveyViewModel: ObservableObject {
    
    let survey: Survey
    private let repository: SurveyRepositoring
    private var cancellables = Set<AnyCancellable>()
    
    init(_ survey: Survey, repository: SurveyRepositoring) {
        self.survey = survey
        self.repository = repository
    }
    
    func submit(reaction: Rating) {
        repository.update(survey, rating: reaction)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { err in }, receiveValue: {})
            .store(in: &cancellables)
    }
}
