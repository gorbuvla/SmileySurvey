//
//  SurveyGridView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 27/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI
import Grid

struct Item: Identifiable {
    let id = UUID()
    let number: Int
    let color: Color = .random
}

extension Color {
    private static let all: [Color] = [.red, .green, .blue, .orange, .yellow, .pink, .purple]
    
    static var random: Color {
        all.randomElement()!
    }
}

// TODO - get rid of these once DI is figured out
fileprivate let repository = MockedSurveyRepository()

struct SurveyGridView: View {
    @State var items: [Item] = (0...100).map { Item(number: $0) }
    
    @ObservedObject var viewModel = SurveyListViewModel(repository: repository)
    
    var body: some View {
        NavigationView {
            Grid(viewModel.surveys) { survey in
                SurveyGridItemView(survey: survey)
            }
            .gridStyle(
                StaggeredGridStyle(tracks: 5)
            )
            .navigationBarTitle("Surveys", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {}) {
                    Image(systemName: "gear")
                }
            )
        }
        .navigationViewStyle(
            StackNavigationViewStyle()
        )
    }
}

struct Card: View {
    let title: String
    let color: Color
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
            Rectangle()
                .foregroundColor(color)
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .opacity(0.5)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.white.opacity(0.3), lineWidth: 4)
        )
        .cornerRadius(16)
            .aspectRatio(0.5, contentMode: .fit)
    }
}

struct SurveyGridView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyGridView()
    }
}
