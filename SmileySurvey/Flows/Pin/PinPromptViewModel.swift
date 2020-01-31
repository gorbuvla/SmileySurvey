//
//  PinPromptViewModel.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 27/01/2020.
//  Copyright © 2020 Vlad Gorbunov. All rights reserved.
//

import Foundation
import Combine

class PinPromptViewModel: ObservableObject {
    
    private let settings: UserSettingsRepositoring
    private let continuationSubject = PassthroughSubject<(), Never>()
    let mode: PinPromptView.Mode
    
    @Published var digit1: String? = nil {
        didSet { error = nil }
    }
    
    @Published var digit2: String? = nil {
        didSet { error = nil }
    }
    
    @Published var digit3: String? = nil {
        didSet { error = nil }
    }
    
    @Published var digit4: String? = nil {
        didSet { error = nil }
    }
    
    var completion: AnyPublisher<(), Never> {
        get { continuationSubject.eraseToAnyPublisher() }
    }
    
    @Published var error: String? = nil {
        didSet {
            digit1 = nil
            digit2 = nil
            digit3 = nil
            digit4 = nil
        }
    }

    init(mode: PinPromptView.Mode, settings: UserSettingsRepositoring) {
        self.mode = mode
        self.settings = settings
    }
    
    func enter(digit: String) {
        switch (digit1, digit2, digit3, digit4) {
        case (nil, nil, nil, nil):
            digit1 = digit
        case (_, nil, nil, nil):
            digit2 = digit
        case (_, _, nil, nil):
            digit3 = digit
        case (_, _, _, nil):
            digit4 = digit
        default: digit
        }
        
        
        guard let d1 = digit1, let d2 = digit2, let d3 = digit3, let d4 = digit4 else { return }
        
        let pin = d1 + d2 + d3 + d4
        
        if case let .verify = mode {
            validatePin(pin: pin)
        } else {
            addPin(pin: pin)
        }
    }
    
    private func validatePin(pin: String) {
        if settings.pin == pin {
            continuationSubject.send(())
        } else {
            error = "Pin not valid"
        }
    }
    
    private func addPin(pin: String) {
        settings.pin = pin
        continuationSubject.send(())
    }
}
