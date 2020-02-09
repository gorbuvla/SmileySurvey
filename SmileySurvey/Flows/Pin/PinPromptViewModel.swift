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
    private let shakeSubject = PassthroughSubject<(), Never>()
    let mode: PinPromptView.Mode
    
    private var pinDigit1: String? = nil {
        didSet { digit1 = pinDigit1?.hideIfVerification(mode: mode) }
    }
    
    private var pinDigit2: String? = nil {
        didSet { digit2 = pinDigit2?.hideIfVerification(mode: mode) }
    }
    
    private var pinDigit3: String? = nil {
        didSet { digit3 = pinDigit3?.hideIfVerification(mode: mode) }
    }
    
    private var pinDigit4: String? = nil {
        didSet { digit4 = pinDigit4?.hideIfVerification(mode: mode) }
    }
    
    @Published var digit1: String? = nil {
        didSet {
            guard let _ = digit1 else { return }
            error = nil
        }
    }
    
    @Published var digit2: String? = nil {
        didSet {
            guard let _ = digit2 else { return }
            error = nil
        }
    }
    
    @Published var digit3: String? = nil {
        didSet {
            guard let _ = digit3 else { return }
            error = nil
        }
    }
    
    @Published var digit4: String? = nil {
        didSet {
            guard let _ = digit4 else { return }
            error = nil
        }
    }
    
    var completion: AnyPublisher<(), Never> {
        get { continuationSubject.eraseToAnyPublisher() }
    }
    
    var shake: AnyPublisher<(), Never> {
        get { shakeSubject.eraseToAnyPublisher() }
    }
    
    @Published var error: String? = nil {
        didSet {
            guard let _ = error else { return }
            
            pinDigit1 = nil
            pinDigit2 = nil
            pinDigit3 = nil
            pinDigit4 = nil
            
            shakeSubject.send(())
        }
    }

    init(mode: PinPromptView.Mode, settings: UserSettingsRepositoring) {
        self.mode = mode
        self.settings = settings
    }
    
    func enter(digit: String) {
        switch (pinDigit1, pinDigit2, pinDigit3, pinDigit4) {
        case (nil, nil, nil, nil):
            pinDigit1 = digit; print("first")
        case (_, nil, nil, nil):
            pinDigit2 = digit; print("second")
        case (_, _, nil, nil):
            pinDigit3 = digit; print("third")
        case (_, _, _, nil):
            pinDigit4 = digit; print("fourth")
        default: print("unmatched case")
        }
        
        guard let d1 = pinDigit1, let d2 = pinDigit2, let d3 = pinDigit3, let d4 = pinDigit4 else { return }
        
        let processPin = mode == .new ? addPin : validatePin
        
        processPin(d1 + d2 + d3 + d4)
    }
    
    private func validatePin(pin: String) {
        if settings.pin == pin {
            continuationSubject.send(())
        } else {
            error = L10n.Pin.Error.invalid
        }
    }
    
    private func addPin(pin: String) {
        settings.pin = pin
        continuationSubject.send(())
    }
}

fileprivate extension String {
    
    func hideIfVerification(mode: PinPromptView.Mode) -> String {
        return mode == .new ? self : "*"
    }
}
