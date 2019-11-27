//
//  SurveyGridItemView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 27/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct SurveyGridItemView: View {
    let survey: Survey
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
            Rectangle()
                .foregroundColor(Color.blue.opacity(0.1))
            
            VStack {
                DonutChart(data: survey.chartData)
                    .padding()
                
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
                        .aspectRatio(contentMode: .fit)
                }.padding()
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.green.opacity(0.3), lineWidth: 4)
        )
        .cornerRadius(16)
            .aspectRatio(0.5, contentMode: .fit)
    }
}

struct SurveyGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        let survey = Survey(
            name: "Questionarie", question: "How was your meal?", excellent: 858, good: 358, bad: 115, disaster: 100
        )
        return SurveyGridItemView(survey: survey).frame(width: 200, height: 300, alignment: .center)
    }
}
