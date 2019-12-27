//
//  LoadingView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 30/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct LoadingView<Content: View>: View {
    
    let label: String = "Loading..."
    
    @Binding var isLoading: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isLoading)
                    .blur(radius: self.isLoading ? 3 : 0)
                
                VStack {
                    Text(self.label)
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2, height: geometry.size.height / 4)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isLoading ? 1 : 0)
            }
        }
    }
}

extension View {
    
    func loading(isLoading: Binding<Bool>) -> some View {
        return LoadingView(isLoading: isLoading) { self }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(true)) {
            Text("Hola")
        }
    }
}
