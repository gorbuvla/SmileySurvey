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
    
    @Environment(\.presentationMode)
    private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Form {
            Section(header: Text("Survey")) {
                FormTextFieldView("Survey name", value: $viewModel.name, error: $viewModel.nameValidation)
                
                FormTextFieldView("Survey question", value: $viewModel.question, error: $viewModel.questionValidation)
            }
            
            Section {
                Button(action: { self.viewModel.submit() }) {
                    Text("Create survey")
                }
            }
        }.navigationBarTitle("New survey")
            .onReceive(viewModel.publisher) {
                self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SurveyFormView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyFormView()
    }
}
