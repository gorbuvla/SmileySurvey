//
//  NewSurveyView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 08/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct NewSurveyView: View {
    
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
                TextField("Something", text: $something)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
            
            Section {
                Button(action: {
                    print("Survey name: \(self.name)")
                }) {
                    Text("Creare survey")
                }
            }
        }.navigationBarTitle("New survey")
    }
}

struct NewSurveyView_Previews: PreviewProvider {
    static var previews: some View {
        NewSurveyView()
    }
}
