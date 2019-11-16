//
//  SurveyItemView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 12/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct SurveyItemView: View {
    
    let survey: Survey
    
    var body: some View {
        VStack {
            Image("img_statistics_placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 330, height: 200, alignment: .center)
            
            VStack {
                Text(survey.name)
                    .font(.headline)
                    .foregroundColor(.secondary)
            
                Text(survey.question)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                
                Text("Number of corrspondents: \(survey.totalCorrespondents)".uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }.padding()
        }.cornerRadius(30)
            .padding([.horizontal])
            .background(Color.white)
            .clipped()
            .shadow(radius: 5)
    }
}

struct SurveyItemView_Previews: PreviewProvider {
    static var previews: some View {
        let survey = Survey(
            id: "id", name: "Questionarie", question: "How was your meal?"
        )
        
        return SurveyItemView(survey: survey)
    }
}
