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
    @State private var showModal = false
    
    @State private var isNavigationActive = false
    
    private var tracksCount: Tracks {
        get { Tracks.count(rotationObserver.mode == Orientation.landscape ? 4 : 2) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
            self.listContent
                .navigationBarTitle(Text(L10n.Survey.Grid.title), displayMode: .inline)
                .navigationBarItems(trailing: self.trailingNavItem)
            
            NavigationLink(destination: ActiveSurveyView(viewModel: factories.activeSurveyViewModel(Survey(name: "Food", question: "How good?"))), isActive: self.$isNavigationActive) {
                EmptyView()
            }
            }
        }
        .loading(isLoading: $viewModel.loading)
        .navigationViewStyle(StackNavigationViewStyle())
            // for debug purposes
        .popover(isPresented: self.$isPresented) {
            ActiveSurveyView(viewModel: factories.activeSurveyViewModel(Survey(name: "Name", question: "whats up?")))
                .environmentObject(self.rotationObserver)
        }
        .sheet(isPresented: self.$viewModel.showing) {
            SurveyModalDetail(viewModel: factories.modalDetailViewModel(self.viewModel.selectedSurvey!.id)) {
                self.navigateTo()
            }.environmentObject(self.rotationObserver)
        }
    }
    
    private func navigateTo() {
        //viewModel.showing = false
        print("ACTIVATE NAVIGATION!!!")
        isNavigationActive = true
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
                    Image.new.font(.title) // TODO: so that icons are pressable... revert later
                }
                Button(action: { self.isPresented.toggle() }) {
                    Image.reload.font(.title) // TODO: so that icons are pressable... revert later
                }
            }
        }
    }
}

struct SurveyGridView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyGridView()
    }
}
