//
//  NewSurveyViewModel.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 09/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import Combine

class SurveyFormViewModel: ObservableObject {

    // MARK: private properties
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: SurveyRepositoring
    private let submitAction: Action<(Survey), Void, Error>
    
    // MARK: public properties
    
    var completion: AnyPublisher<(), Never> {
        get { submitAction.data }
    }
    
    // MARK: view bindings
    
    @Published var name: String = "" {
        didSet { nameValidation = nil } // erase error when user continues typing
    }
    
    @Published var question: String = "" {
        didSet { questionValidation = nil } // erase error when user continues typing
    }
    
    @Published var nameValidation: String? = nil
    @Published var questionValidation: String? = nil
    
    @Published var loading: Bool = false
    
    
    // MARK: initializtion
    
    init(repository: SurveyRepositoring) {
        self.repository = repository
        submitAction = Action { input in repository.create(survey: input) }
        submitAction.loading.receive(on: RunLoop.main).sink { self.loading = $0 }.store(in: &cancellables)
    }
    
    func submit() {
        guard !name.isEmpty && !question.isEmpty else {
            nameValidation = name.isEmpty ? L10n.Survey.Form.Name.error : nil
            questionValidation = question.isEmpty ? L10n.Survey.Form.Question.error : nil
            return
        }
    
        submitAction.apply(input: Survey(name: name, question: question))
    }
}
