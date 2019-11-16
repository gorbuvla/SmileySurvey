//
//  SwiftUIView.swift
//  SmileSurvey
//
//  Created by Vlad Gorbunov on 10/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI
import Combine

// TODO - get rid of these once DI is figured out
fileprivate let repository = MockedSurveyRepository()
fileprivate let viewModel = SurveyListViewModel(repository: repository)

struct SurveyListView: View {
    
    @ObservedObject var viewModel = SurveyListViewModel(repository: repository)
    
    var body: some View {
        NavigationView {
        // TODO: handle empty state as well
            List(viewModel.surveys, id: \.id) { survey in
                NavigationLink(destination: SurveyDetailModal(survey: survey)) {
                    SurveyListRow(survey: survey)
                }
            }.navigationBarTitle("Surveys") // TODO: resources
        }
    }
}

struct SurveyListRow: View {
    
    let survey: Survey
    
    var body: some View {
        HStack {
            DonutChart(data: survey.chartData)
                .frame(width: 70, height: 70)
            Text(survey.name)
        }
    }
}

extension Survey {
    // TODO: revisit colors once swiftgen is set up
    var chartData: [(Int, Color)] {
        get {
            [
                (disaster, Color.red),
                (bad, Color.yellow),
                (good, Color.blue),
                (excellent, Color.green)
            ]
        }
    }
}

struct SurveyListView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyListView()
    }
}
