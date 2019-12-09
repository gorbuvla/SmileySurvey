//
//  NewSurveyViewModel.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 09/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation

class SurveyFormViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var question: String = ""
    
    @Published var something: String = ""
    @Published var somethingError: String? = nil
    
    func submit() {
        
        if something.isEmpty {
            somethingError = "Cant be empty"
        }
        
        // 1. do validate & emit
        // 2. store survey && show processing
        // 3. get result & navigate back
    }
}
