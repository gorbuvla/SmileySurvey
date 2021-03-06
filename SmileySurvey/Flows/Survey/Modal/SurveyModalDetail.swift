//
//  SurveyModalDetail.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 30/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct SurveyModalDetail: View {
    
    @State private var active = false
    
    @EnvironmentObject private var rotationObserver: RotationObserver
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: ModalDetailViewModel
    let onStart: () -> ()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.blue.opacity(0.1))
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.all) // a hack to draw under navbar
                    
                VStack {
                    if rotationObserver.isPortrait {
                        portraitView
                    } else {
                        landscapeView
                    }
                }
                .smallPadding()
                .navigationBarItems(trailing: trailingItems)
                .padding([.bottom], 60) // to center containing view (iPhone sheets in portrait have large navBar)
            }
        }
        .background(Color.clear)
        .navigationViewStyle(StackNavigationViewStyle())
        .loading(isLoading: $viewModel.loading)
        .fullSpace()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.random.opacity(0.3), lineWidth: 4)
        )
        .onReceive(viewModel.completion) { self.presentationMode.wrappedValue.dismiss() }
    }
    
    private var trailingItems: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Text(L10n.General.done)
        }
    }
    
    private var portraitView: some View {
        VStack {
            DonutChart(data: self.viewModel.survey.chartData)
                    .padding()
            
            Text(self.viewModel.survey.name)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(self.viewModel.survey.question)
                .font(.subheadline)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                
            
            Text(L10n.Survey.Item.correspondents(self.viewModel.survey.totalCorrespondents).uppercased())
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                RatingItemView(ratingItem: RatingItem.excellent(viewModel.survey.excellentPercentage))
                RatingItemView(ratingItem: RatingItem.good(viewModel.survey.goodPercentage))
                RatingItemView(ratingItem: RatingItem.bad(viewModel.survey.badPercentage))
                RatingItemView(ratingItem: RatingItem.disaster(viewModel.survey.disasterPercentage))
            }
                
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                self.onStart()
            }) {
                HStack {
                    Image(systemName: "hand.thumbsup")
                    
                    Text(L10n.Survey.Detail.start)
                        .fontWeight(.bold)
                        .font(.title)
                }
                .foregroundColor(.white)
                .roundedBackground(.green)
            }
            
            Button(action: { self.viewModel.delete() }) {
                HStack {
                    Image.delete
                    
                    Text(L10n.Survey.Detail.delete)
                        .font(.title)
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .roundedBackground(.red)
            }
        }.smallPadding()
    }
    
    private var landscapeView: some View {
        HStack(alignment: VerticalAlignment.center) {
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
                
                Text(L10n.Survey.Item.correspondents(self.viewModel.survey.totalCorrespondents).uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack {
                    RatingItemView(ratingItem: RatingItem.excellent(viewModel.survey.excellentPercentage))
                    RatingItemView(ratingItem: RatingItem.good(viewModel.survey.goodPercentage))
                    RatingItemView(ratingItem: RatingItem.bad(viewModel.survey.badPercentage))
                    RatingItemView(ratingItem: RatingItem.disaster(viewModel.survey.disasterPercentage))
                }
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                self.onStart()
                
                }) {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                        
                        Text(L10n.Survey.Detail.start)
                            .fontWeight(.bold)
                            .font(.title)
                    }
                    .foregroundColor(.white)
                    .roundedBackground(.green)
                }
                
                Button(action: { self.viewModel.delete() }) {
                    HStack {
                        Image(systemName: "trash")
                        
                        Text(L10n.Survey.Detail.delete)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .roundedBackground(.red)
                }
            }
        }.smallPadding()
    }
}

private extension Survey {
    
    var excellentPercentage: Int {
        totalCorrespondents == 0 ? 0 : Int(Double(excellent) / Double(totalCorrespondents) * 100)
    }
    
    var goodPercentage: Int {
        totalCorrespondents == 0 ? 0 : Int(Double(good) / Double(totalCorrespondents) * 100)
    }
    
    var badPercentage: Int {
        totalCorrespondents == 0 ? 0 : Int(Double(bad) / Double(totalCorrespondents) * 100)
    }
    
    var disasterPercentage: Int {
        totalCorrespondents == 0 ? 0 : Int(Double(disaster) / Double(totalCorrespondents) * 100)
    }
}

fileprivate extension View {
    
    func roundedBackground(_ color: Color) -> some View {
        return self
            .padding([.horizontal], 20)
            .padding([.vertical], 10)
            .background(color)
            .cornerRadius(20)
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
