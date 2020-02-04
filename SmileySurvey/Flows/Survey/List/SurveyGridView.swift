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
    
    @State private var isNavigationActive = false
    @State private var modalPresented = false
    
    private var tracksCount: Tracks {
        get { Tracks.count(rotationObserver.mode == Orientation.landscape ? 4 : 3) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                self.listContent
                    .navigationBarTitle(Text(L10n.Survey.Grid.title), displayMode: .inline)
                    .navigationBarItems(trailing: self.trailingNavItem)
            
                    NavigationLink(destination: ActiveSurveyView(viewModel: factories.activeSurveyViewModel()), isActive: self.$isNavigationActive) {
                        EmptyView()
                    }
            }
        }
        .loading(isLoading: $viewModel.loading)
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: self.$modalPresented) {
            SurveyModalDetail(viewModel: factories.modalDetailViewModel()) {
                self.navigateTo()
            }.environmentObject(self.rotationObserver)
        }
    }

    private var listContent: some View {
        get {
            if viewModel.surveys.isEmpty {
                return AnyView(Text(L10n.Survey.Grid.empty))
            } else {
                return AnyView(
                    Grid(self.viewModel.surveys) { survey in
                        Button(action: {
                            self.viewModel.select(survey: survey)
                            self.modalPresented.toggle()
                        }) {
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
                    Image.new.font(.title)
                }
                
                NavigationLink(destination: SettingsView(viewModel: factories.settingsViewModel())) {
                    Image.settings.font(.title)
                }
            }
        }
    }
    
    private func navigateTo() {
        isNavigationActive.toggle()
    }
}

struct SurveyGridView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyGridView()
    }
}
