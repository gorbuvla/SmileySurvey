//
//  ModelDependency.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 30/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

protocol ModelProvider {
    
    var surveyRepository: SurveyRepositoring { get }
}

final class ModelDependency: ModelProvider {
    
    lazy var surveyRepository: SurveyRepositoring = CoreDataSurveyRepository(database: Database.shared)
    //lazy var surveyRepository: SurveyRepositoring = MockedSurveyRepository() // TODO: uncomment to debug with mocked data source
}
