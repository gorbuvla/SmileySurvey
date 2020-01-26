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
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(survey.name)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    
                        Text(survey.question)
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                        
                        Text(L10n.Survey.Item.correspondents(survey.totalCorrespondents).uppercased())
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }.layoutPriority(100)
                    
                    Spacer()
                }
            }.padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.random.opacity(0.3), lineWidth: 4)
        )
        .cornerRadius(16)
        .aspectRatio(0.75, contentMode: .fit)
        .background(Color.white)
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

extension Survey {
    var chartData: ChartRating {
        get { ChartRating(excellent: excellent, good: good, bad: bad, disaster: disaster) }
    }
}

extension Color {
    private static let all: [Color] = [.red, .green, .blue, .orange, .yellow, .pink, .purple]
    
    static var random: Color {
        all.randomElement()!
    }
}
