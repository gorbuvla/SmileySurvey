//
//  ActiveSurveyViewModel.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 25/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

enum Reaction {
    case disaster
    case bad
    case good
    case excellent
}

class ActiveSurveyViewModel: ObservableObject {
    
    let survey: Survey
    private let repository: SurveyRepositoring
    
    init(_ survey: Survey, repository: SurveyRepositoring) {
        self.survey = survey
        self.repository = repository
    }
    
    func submit(reaction: Reaction) {}
}
