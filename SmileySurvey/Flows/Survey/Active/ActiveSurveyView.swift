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
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: ActiveSurveyViewModel
    @State private var pinPresented: Bool = false
    
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
        .navigationBarBackButtonHidden(true) // We handle back navigation in our own way, user has to enter pin if provided
        .navigationBarTitle(Text(viewModel.survey.name), displayMode: .inline)
        .navigationBarItems(trailing: trailingNavItems)
        .sheet(isPresented: $pinPresented) {
            PinPromptView(viewModel: factories.pinPromptViewModel(.verify)) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private var trailingNavItems: some View {
        Button(action: { self.exitSurvey() }) {
            Text(L10n.General.exit)
        }
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
    
    private func exitSurvey() {
        if viewModel.shouldCheckPin {
            pinPresented.toggle()
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
