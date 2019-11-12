//
//  SurveyRepositoring.swift
//  SmileSurvey
//
//  Created by Vlad Gorbunov on 10/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//
import Combine

protocol SurveyRepositoring {
    // TODO - check for possible errors
    func observeSurveys() -> AnyPublisher<[Survey], Never>
}
