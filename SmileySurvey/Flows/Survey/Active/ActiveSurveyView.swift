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
        VStack {
            Text(viewModel.survey.question)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.primary)
            
            if rotationObserver.mode == .portrait {
                gridReactionView
            } else {
                lineReactionView
            }
        }
        .loading(isLoading: $viewModel.loading)
    }
    
    private var gridReactionView: some View {
        VStack {
            HStack {
                Button(action: { self.viewModel.submit(reaction: .excellent) }) {
                    Image.ratingExcellent.fitIntoBounds()
                }.smallPadding()
                
                Button(action: { self.viewModel.submit(reaction: .good) }) {
                    Image.ratingGood.fitIntoBounds()
                }.smallPadding()
            }
            
            HStack {
                Button(action: { self.viewModel.submit(reaction: .bad) }) {
                    Image.ratingBad.fitIntoBounds()
                }.smallPadding()
                
                Button(action: { self.viewModel.submit(reaction: .disaster) }) {
                    Image.ratingDisaster.fitIntoBounds()
                }.smallPadding()
            }
        }.largePadding()
    }
    
    private var lineReactionView: some View {
        HStack {
            Button(action: { self.viewModel.submit(reaction: .excellent) }) {
                Image.ratingExcellent.fitIntoBounds()
            }.smallPadding()
            
            Button(action: { self.viewModel.submit(reaction: .good) }) {
                Image.ratingGood.fitIntoBounds()
            }.smallPadding()
                
            Button(action: { self.viewModel.submit(reaction: .bad) }) {
                Image.ratingBad.fitIntoBounds()
            }.smallPadding()
                
            Button(action: { self.viewModel.submit(reaction: .disaster) }) {
                Image.ratingDisaster.fitIntoBounds()
            }.smallPadding()
        }.largePadding()
    }
}
