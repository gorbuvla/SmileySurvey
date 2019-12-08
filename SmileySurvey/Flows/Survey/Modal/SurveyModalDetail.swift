//
//  SurveyModalDetail.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 30/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct SurveyModalDetail: View {
    
    let survey: Survey
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
            Rectangle()
                .foregroundColor(Color.blue.opacity(0.1))
                .background(Color.white)
            
            HStack {
                DonutChart(data: survey.chartData)
                    .padding()
            
                VStack(alignment: .leading) {
                    Text(survey.name)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                
                    Text(survey.question)
                        .font(.subheadline)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    
                    Text("Number of corrspondents: \(survey.totalCorrespondents)".uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.random.opacity(0.3), lineWidth: 4)
        )
        .cornerRadius(16)
        .aspectRatio(0.75, contentMode: .fit)
    }
}

struct SurveyModalDetail_Previews: PreviewProvider {
    static var previews: some View {
        let survey = Survey(
            name: "Questionarie", question: "How was your meal?", excellent: 5, good: 3, bad: 3, disaster: 4
        )

        return SurveyModalDetail(survey: survey)
    }
}
