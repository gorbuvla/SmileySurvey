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
    
    private let repository: SurveyRepositoring
    
    @Published var name: String = "" {
        didSet {
            nameValidation = nil
        }
    }
    
    @Published var question: String = "" {
        didSet {
            questionValidation = nil
        }
    }
    
    @Published var nameValidation: String? = nil
    @Published var questionValidation: String? = nil
    
    //@Action var createSurvey: State<(), Never>
    private var actionSubject = PassthroughSubject<(), Never>()
    
    var publisher: AnyPublisher<(), Never> {
        get { actionSubject.eraseToAnyPublisher() }
    }
    
    init(repository: SurveyRepositoring) {
        self.repository = repository
    }
    
    func submit() {
        guard !name.isEmpty && !question.isEmpty else {
            nameValidation = name.isEmpty ? "Must not be empty" : nil
            questionValidation = question.isEmpty ? "Must not be empty" : nil
            return
        }
        
        actionSubject.send(())
        
        repository.createSurvey(survey: Survey(name: name, question: question))
        
        
    
        // 3. get result & navigate back
    }
}

//@propertyWrapper
//class Action<Value, Error> {
//
//    private let subject = CurrentValueSubject<State<Value, Error>, Never>(.idle)
//
//    var wrappedValue: State<Value, Error> {
//        get { subject.value }
//        set { subject.send(newValue) }
//    }
//
//    var loading: AnyPublisher<Bool, Never> {
//        get { subject.map(\.isLoading).eraseToAnyPublisher() }
//    }
//
//    var data: AnyPublisher<Value, Never> {
//        get { subject.compactMap { $0.value }.eraseToAnyPublisher() }
//    }
//
//    var error: AnyPublisher<Error, Never> {
//        get { subject.compactMap { $0.error }.eraseToAnyPublisher() }
//    }
//}
//
//enum State<Value, Error> {
//    case idle
//    case loading
//    case value(Value)
//    case error(Error)
//
//    var isLoading: Bool {
//        switch self {
//        case .loading: return true
//        default: return false
//        }
//    }
//
//    var value: Value? {
//        switch self {
//        case .value(let value): return value
//        default: return nil
//        }
//    }
//
//    var error: Error? {
//        switch self {
//        case .error(let error): return error
//        default: return nil
//        }
//    }
//}
//
//protocol StateConvertible {
//    associatedtype StateValue
//    associatedtype StateError
//
//    var state: State<StateValue, StateError> { get }
//}
//
//extension State: StateConvertible {
//    typealias StateValue = Value
//    typealias StateError = Error
//
//    var state: State<Value, Error> { return self }
//}
//
