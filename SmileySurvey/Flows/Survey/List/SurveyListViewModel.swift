//
//  SurveyListViewModel.swift
//  SmileSurvey
//
//  Created by Vlad Gorbunov on 10/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import Combine

// TODO: figure out BaseViewModel with cancellables to reduce boilerplate
final class SurveyListViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: SurveyRepositoring
    
    @Published var surveys: [Survey] = []
    
    init(repository: SurveyRepositoring) {
        self.repository = repository
        bindUpdates()
    }
    
    private func bindUpdates() {
        repository.observeSurveys()
            .subscribe(on: DispatchQueue.global())
            .sink(receiveValue: { [weak self] surveys in self?.surveys = surveys })
            .store(in: &cancellables)
    }
}
