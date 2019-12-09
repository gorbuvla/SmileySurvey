//
//  NewSurveyView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 08/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI
import Combine

struct SurveyFormView: View {
    
    @ObservedObject
    private var viewModel: SurveyFormViewModel = factories.surveyFormViewModel()
    
    @State private var name: String = ""
    @State private var question: String = ""
    @State private var something: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Survey")) {
                TextField("Enter survey name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter survey question", text: $question)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Section(header: Text("Other")) {
                FormTextFieldView("Something", value: $viewModel.something, error: $viewModel.somethingError)
            }
            
            Section {
                Button(action: {
                    self.viewModel.submit()
                }) {
                    Text("Creare survey")
                }
            }
        }.navigationBarTitle("New survey")
    }
}

struct SurveyFormView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyFormView()
    }
}
