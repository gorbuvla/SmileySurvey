//
//  SurveyGridView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 27/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI
import Grid

struct SurveyGridView: View {
    
    private let kTracksCount = Tracks.count(4)
    
    @State private var showsAddNewSurvey: Bool = false
    @ObservedObject var viewModel = factories.surveyGridViewModel()
    
    var body: some View {
        LoadingView(isLoading: $viewModel.loading) {
            NavigationView {
                self.listContent
                    .navigationBarTitle("Surveys", displayMode: .inline)
                    .navigationBarItems(leading: self.leadingNavItem, trailing: self.trailingNavItem)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }

    private var listContent: some View {
        get {
            if viewModel.surveys.isEmpty {
                return AnyView(Text("No surveys yet"))
            } else {
                return AnyView(
                    Grid(self.viewModel.surveys) { survey in
                        SurveyGridItemView(survey: survey)
                    }
                    .gridStyle(StaggeredGridStyle(tracks: self.kTracksCount))
                )
            }
        }
    }
    
    private var trailingNavItem: some View {
        get {
            Button(action: { self.showsAddNewSurvey = true }) {
                Image(systemName: "plus.circle")
            }
            .alert(isPresented: $showsAddNewSurvey) {
                // TODO: present new survey form
                Alert(title: Text("Add new survey"), message: Text("!!!"), dismissButton: .default(Text("ADD")))
            }
        }
    }
    
    private var leadingNavItem: some View {
        get {
             Button(action: { self.viewModel.reload() }) {
                Image(systemName: "arrow.clockwise.circle")
            }
        }
    }
}

struct SurveyGridView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyGridView()
    }
}
