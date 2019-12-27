//
//  ModelDetailViewModel.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 27/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Combine
import SwiftUI

class ModalDetailViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    let survey: Survey
    private let repository: SurveyRepositoring
    private let deleteAction: Action<(Survey), (), Never>
    
    @Published var loading: Bool = false
    
    var completion: AnyPublisher<(), Never> {
        get { deleteAction.data }
    }
    
    init(_ survey: Survey, repository: SurveyRepositoring) {
        self.survey = survey
        self.repository = repository
        self.deleteAction = Action { survey in repository.delete(survey: survey) }
        
        deleteAction.loading.receive(on: RunLoop.main).sink { self.loading = $0 }.store(in: &cancellables)
    }
    
    func delete() {
        deleteAction.apply(input: survey)
    }
}

