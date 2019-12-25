//
//  ActiveSurveyView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 25/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct ActiveSurveyView: View {
    
    @EnvironmentObject var rotationObserver: RotationObserver
    @ObservedObject var viewModel: ActiveSurveyViewModel
    
    var body: some View {
        HStack {
            if rotationObserver.mode == .portrait {
                gridReactionView
            } else {
                lineReactionView
            }
        }
    }
    
    private var gridReactionView: some View {
        VStack {
            Text(viewModel.survey.question)
            
            HStack {
                Button(action: { self.viewModel.submit(reaction: .good) }) {
                    Image.ratingDisaster
                }
                
                Button(action: { self.viewModel.submit(reaction: .excellent) }) {
                    Image.ratingDisaster
                }
            }
            
            HStack {
                Button(action: { self.viewModel.submit(reaction: .disaster) }) {
                    Image.ratingDisaster
                }
                
                Button(action: { self.viewModel.submit(reaction: .bad) }) {
                    Image.ratingDisaster
                }
            }
        }
    }
    
    private var lineReactionView: some View {
        Text("Ogo2")
    }
}

struct ActiveSurveyView_Previews: PreviewProvider {
    static var previews: some View {
        let survey = Survey(name: "Active survey", question: "How are you doing today?")
        return ActiveSurveyView(viewModel: factories.activeSurveyViewModel(survey))
            .environmentObject(RotationObserver(mode: .portrait))
    }
}
