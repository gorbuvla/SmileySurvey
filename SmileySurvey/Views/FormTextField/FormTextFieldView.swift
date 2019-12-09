//
//  FormTextFieldView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 09/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct FormTextFieldView: View {
    
    private let title: String
    private let value: Binding<String>
    private let error: Binding<String?>
    
    init(_ title: String, value: Binding<String>, error: Binding<String?>) {
        self.title = title
        self.value = value
        self.error = error
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(title, text: value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if error.wrappedValue != nil {
                Text(error.wrappedValue ?? "")
                    .fontWeight(.light)
                    .font(.footnote)
                    .foregroundColor(.red)
            }
        }
    }
}

// TODO make preview

//struct FormTextFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormTextFieldView(
//        )
//    }
//}
