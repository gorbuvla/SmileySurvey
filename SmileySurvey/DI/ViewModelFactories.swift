//
//  ViewModelFactories.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 30/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

final class ViewModelFactories {
    
    private let dependencies: ModelProvider
    
    init(modelDependency: ModelProvider) {
        self.dependencies = modelDependency
    }
    
    var surveyGridViewModel: () -> SurveyGridViewModel {
        return { SurveyGridViewModel(repository: self.dependencies.surveyRepository) }
    }
    
    var surveyFormViewModel: () -> SurveyFormViewModel {
        return { SurveyFormViewModel(repository: self.dependencies.surveyRepository) }
    }
    
    var activeSurveyViewModel: (Survey) -> ActiveSurveyViewModel {
        return { survey in ActiveSurveyViewModel(survey, repository: self.dependencies.surveyRepository) }
    }
    
    var modalDetailViewModel: (UUID) -> ModalDetailViewModel {
        return { surveyId in ModalDetailViewModel(surveyId, repository: self.dependencies.surveyRepository) }
    }
}

let factories = ViewModelFactories(modelDependency: ModelDependency())
