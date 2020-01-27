//
//  ActiveSurveyViewModel.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 25/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import Combine

class ActiveSurveyViewModel: ObservableObject {
    
    // Blank survey by default to prevent madness with control flow in VB... 🤦‍♂️
    @Published var survey: Survey = Survey(name: "", question: "")
    @Published var loading: Bool = false
    private let settings: UserSettingsRepositoring
    private let provider: CurrentSurveyProvider
    private let repository: SurveyRepositoring
    private var cancellables = Set<AnyCancellable>()
    
    var shouldCheckPin: Bool {
        get { settings.pin != nil }
    }
    
    init(provider: CurrentSurveyProvider, repository: SurveyRepositoring, settings: UserSettingsRepositoring) {
        self.provider = provider
        self.repository = repository
        self.settings = settings
        bindSelection()
    }
    
    func submit(reaction: Rating) {
        repository.update(survey, rating: reaction)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { err in }, receiveValue: {})
            .store(in: &cancellables)
    }
    
    private func bindSelection() {
        loading = true
        provider.selectedSurveyId.flatMap { id in
            self.repository.observe(filter: .single(id: id)).compactMap { $0.isEmpty ? nil : $0.first }
        }
        .subscribe(on: DispatchQueue.global())
        .receive(on: DispatchQueue.main)
        .delay(for: 2.0, scheduler: DispatchQueue.main)
        .sink { [weak self] survey in
            self?.survey = survey
            self?.loading = false
        }
        .store(in: &cancellables)
    }
}
