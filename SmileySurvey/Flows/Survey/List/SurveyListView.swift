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
        // TODO: handle empty state as well
        List(viewModel.surveys, id: \.id) { survey in
            SurveyListRow(survey: survey)
        }.background(Color.blue)
    }
}

struct SurveyListRow: View {
    
    let survey: Survey
    
    var body: some View {
        VStack {
            Text(survey.name)
            Text("😎🧛‍♂️😛")
        }.background(Color.red)
    }
}

struct SurveyListView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyListView()
    }
}
