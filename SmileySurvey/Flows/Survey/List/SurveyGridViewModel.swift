//
//  SurveyListViewModel.swift
//  SmileSurvey
//
//  Created by Vlad Gorbunov on 10/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import Combine

final class SurveyGridViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: SurveyRepositoring
    
    @Published var surveys: [Survey] = []
    @Published var loading: Bool = true
    @Published var showing: Bool = false
    @Published var error: Error? = nil
    @Published var selectedSurvey: Survey? = nil
    
    init(repository: SurveyRepositoring) {
        self.repository = repository
        bindUpdates()
    }
    
    func select(survey: Survey) {
        showing = true
        selectedSurvey = survey
    }
    
    private func bindUpdates() {
        repository.observe(filter: .all)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .delay(for: 2.0, scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] surveys in
                self?.loading = false
                self?.surveys = surveys
            })
            .store(in: &cancellables)
    }
}
