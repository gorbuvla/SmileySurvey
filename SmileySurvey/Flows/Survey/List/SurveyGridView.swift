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
        
    @EnvironmentObject var rotationObserver: RotationObserver
    
    @State private var showsAddNewSurvey: Bool = false
    @ObservedObject var viewModel = factories.surveyGridViewModel()
    
    private var tracksCount: Tracks {
        get { Tracks.count(rotationObserver.mode == Orientation.landscape ? 4 : 2) }
    }
    
    var body: some View {
        LoadingView(isLoading: $viewModel.loading) {
            NavigationView {
                self.listContent
                    .navigationBarTitle(Text(L10n.Survey.Grid.title), displayMode: .inline)
                    .navigationBarItems(leading: self.leadingNavItem, trailing: self.trailingNavItem)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .modalPresentalbe(isPresenting: self.$viewModel.showing, modalFactory: {
                SurveyModalDetail(survey: self.viewModel.selectedSurvey!)
            })
        }
    }

    private var listContent: some View {
        get {
            if viewModel.surveys.isEmpty {
                return AnyView(Text(L10n.Survey.Grid.empty))
            } else {
                return AnyView(
                    Grid(self.viewModel.surveys) { survey in
                        Button(action: { self.viewModel.select(survey: survey) }) {
                            SurveyGridItemView(survey: survey)
                        }
                    }
                    .gridStyle(StaggeredGridStyle(tracks: self.tracksCount))
                )
            }
        }
    }
    
    private var trailingNavItem: some View {
        get {
            NavigationLink(destination: SurveyFormView()) {
                Image.new
            }
        }
    }
    
    private var leadingNavItem: some View {
        get {
             Button(action: { self.viewModel.reload() }) {
                Image.reload
            }
        }
    }
}

struct SurveyGridView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyGridView()
    }
}
