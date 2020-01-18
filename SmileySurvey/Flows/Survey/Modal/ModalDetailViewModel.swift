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
    
    private let surveyId: UUID
    private let repository: SurveyRepositoring
    private let deleteAction: Action<(Survey), (), Error>
    
    // Blank survey by default to prevent madness with control flow in VB... 🤦‍♂️
    @Published var survey: Survey = Survey(name: "", question: "")
    @Published var loading: Bool = false
    
    var completion: AnyPublisher<(), Never> {
        get { deleteAction.data }
    }
    
    init(_ surveyId: UUID, repository: SurveyRepositoring) {
        self.surveyId = surveyId
        self.repository = repository
        self.deleteAction = Action { survey in repository.delete(survey: survey) }
        
        bindUpdates()
        deleteAction.loading.receive(on: RunLoop.main).sink { self.loading = $0 }.store(in: &cancellables)
    }
    
    func delete() {
        deleteAction.apply(input: survey)
    }
    
    private func bindUpdates() {
        loading = true
        repository.observe(filter: .single(id: surveyId))
            .compactMap { $0.first }
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] survey in
                self?.loading = false
                self?.survey = survey
            })
            .store(in: &cancellables)
    }
}

