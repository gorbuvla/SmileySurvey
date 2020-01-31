//
//  SettingsViewModel.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 30/01/2020.
//  Copyright © 2020 Vlad Gorbunov. All rights reserved.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    
    private let repository: UserSettingsRepositoring
    
    @Published var pin: String? = nil
    
    init(repository: UserSettingsRepositoring) {
        self.repository = repository
        self.pin = repository.pin
    }
    
    func onUpdated() {
        pin = repository.pin
    }
    
    func delete() {
        repository.pin = ""
        pin = nil
    }
}
