//
//  SurveyRepositoring.swift
//  SmileSurvey
//
//  Created by Vlad Gorbunov on 10/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//
import Combine

protocol SurveyRepositoring {
    
    func create(survey: Survey) -> AnyPublisher<(), Error>
    
    func observe() -> AnyPublisher<[Survey], Never>
    
    func update(_ survey: Survey, rating: Rating) -> AnyPublisher<(), Error>
    
    func delete(survey: Survey) -> AnyPublisher<(), Error>
}

enum Rating {
    case excellent
    case good
    case bad
    case disaster
}
