//
//  SurveyDetailModal.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 16/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct SurveyDetailModal: View {
    
    let survey: Survey
    
    var body: some View {
        VStack {
            SurveyItemView(survey: survey)
            
            Button(action: {}) {
                Text("Continue")
            }
            Button(action: {}) {
                Text("Start again")
            }
            Button(action: {}) {
                Text("Delete")
            }
        }
        .background(Color.white)
        .clipped()
        .shadow(radius: 5)
    }
}

struct SurveyDetailModal_Previews: PreviewProvider {
    static var previews: some View {
        let survey = Survey(
            name: "Questionarie", question: "How was your meal?"
        )
        
        return SurveyDetailModal(survey: survey)
    }
}
