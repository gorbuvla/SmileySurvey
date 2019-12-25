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
            Section(header: Text(L10n.Survey.Form.surveySection)) {
                FormTextFieldView(L10n.Survey.Form.Name.hint, value: $viewModel.name, error: $viewModel.nameValidation)
                
                FormTextFieldView(L10n.Survey.Form.Question.hint, value: $viewModel.question, error: $viewModel.questionValidation)
            }
            
            Section {
                Button(action: { self.viewModel.submit() }) {
                    Text(L10n.Survey.Form.create)
                }
            }
        }.navigationBarTitle(L10n.Survey.Form.title)
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
