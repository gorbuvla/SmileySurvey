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
    @ObservedObject var viewModel = factories.surveyGridViewModel()
    
    @State private var showsAddNewSurvey: Bool = false
    @State private var isPresented = false
    
    private var tracksCount: Tracks {
        get { Tracks.count(rotationObserver.mode == Orientation.landscape ? 4 : 2) }
    }
    
    var body: some View {
        NavigationView {
            self.listContent
                .navigationBarTitle(Text(L10n.Survey.Grid.title), displayMode: .inline)
                .navigationBarItems(leading: self.leadingNavItem, trailing: self.trailingNavItem)
        }
        .loading(isLoading: $viewModel.loading)
        .navigationViewStyle(StackNavigationViewStyle())
//        .modalPresentalbe(isPresenting: self.$viewModel.showing, modalFactory: {
//            SurveyModalDetail(survey: self.viewModel.selectedSurvey!)
//        })
            .popover(isPresented: self.$isPresented) {
            ActiveSurveyView(viewModel: factories.activeSurveyViewModel(Survey(name: "Name", question: "whats up?")))
                .environmentObject(self.rotationObserver)
        }
        .popover(isPresented: self.$viewModel.showing) {
            SurveyModalDetail(viewModel: factories.modalDetailViewModel(self.viewModel.selectedSurvey!))
                .environmentObject(self.rotationObserver)
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
            HStack {
                NavigationLink(destination: SurveyFormView()) {
                    Image.new
                }
                Button(action: { self.isPresented.toggle() }) {
                    Image.reload
                }
//                NavigationLink(destination: ActiveSurveyView(viewModel: factories.activeSurveyViewModel(Survey(name: "Name", question: "whats up?")))) {
//                    Image.reload
//                }
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
