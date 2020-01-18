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

class Action<Input, Output, Error: Swift.Error>: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let loadingSubject = CurrentValueSubject<Bool, Never>(false)
    private let valueSubject = CurrentValueSubject<Output?, Never>(nil)
    private let errorSubject = PassthroughSubject<Error, Never>()
    private let execute: (Input) -> AnyPublisher<Output, Error>
    
    var loading: AnyPublisher<Bool, Never> {
        get { loadingSubject.eraseToAnyPublisher() }
    }
    
    var data: AnyPublisher<Output, Never> {
        get { valueSubject.compactMap { $0 }.eraseToAnyPublisher() }
    }
    
    var error: AnyPublisher<Error, Never> {
        get { errorSubject.eraseToAnyPublisher() }
    }
    
    init(execute: @escaping (Input) -> AnyPublisher<Output, Error>) {
        self.execute = execute
    }
    
    func apply(input: Input) {
        loadingSubject.send(true)
        
        execute(input)
            .mapSingleResult()
            .subscribe(on: DispatchQueue.global())
            .receive(on: RunLoop.main)
            .delay(for: 2, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] result in
                self?.loadingSubject.send(false)
                
                switch result {
                case .success(let output): self?.valueSubject.send(output)
                case .failure(let error): self?.errorSubject.send(error)
                }
            })
            .store(in: &cancellables)
    }
}

extension AnyPublisher {
        
    // ❗️ beware when using `catch(_)` as it will cancel original upstream
    func mapSingleResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        return self
            .map { Result<Output, Failure>.success($0) }
            .catch { error in Just(Result<Output, Failure>.failure(error)) }
            .eraseToAnyPublisher()
    }
}

// MARK: todo

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
