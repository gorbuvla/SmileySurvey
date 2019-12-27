//
//  SurveyModalDetail.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 30/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct SurveyModalDetail: View {
    
    @State private var active: Bool = false
    
    @EnvironmentObject var rotationObserver: RotationObserver
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: ModalDetailViewModel
    
    var body: some View {
        NavigationView {
        ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
            Rectangle()
                .foregroundColor(Color.blue.opacity(0.1))
                .background(Color.white)
            
            if rotationObserver.isPortrait {
                portraitView
            } else {
                landscapeView
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.random.opacity(0.3), lineWidth: 4)
        )
        .cornerRadius(16)
            .navigationBarItems(trailing: Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                Image.reload
            })
        }
        .popover(isPresented: self.$active) {
            ActiveSurveyView(viewModel: factories.activeSurveyViewModel(self.viewModel.survey))
                .environmentObject(self.rotationObserver)
        }
        .navigationViewStyle(StackNavigationViewStyle())
            .onReceive(viewModel.completion) { self.presentationMode.wrappedValue.dismiss() }
        //.aspectRatio(0.75, contentMode: .fit)
    }
    
    private var portraitView: some View {
        HStack {
            DonutChart(data: self.viewModel.survey.chartData)
                .padding()
        
            VStack(alignment: .leading) {
                Text(self.viewModel.survey.name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            
                Text(self.viewModel.survey.question)
                    .font(.subheadline)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                
                Text("Number of corrspondents: \(self.viewModel.survey.totalCorrespondents)".uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Button(action: { self.active.toggle() }) {
                    Text("Start")
                }
                
                Button(action: { self.viewModel.delete() }) {
                    Text("Delete")
                }
            }
        }.largePadding()
    }
    
    private var landscapeView: some View {
        HStack {
            Text("Ogo2")
        }
    }
}

//struct SurveyModalDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        let survey = Survey(
//            name: "Questionarie", question: "How was your meal?", excellent: 5, good: 3, bad: 3, disaster: 4
//        )
//
//        return SurveyModalDetail(survey: survey)
//    }
//}
