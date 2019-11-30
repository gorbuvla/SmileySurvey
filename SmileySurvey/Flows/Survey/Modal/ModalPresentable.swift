//
//  ModalPresentable.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 30/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct ModalPresentable<SourceView: View, TargetView: View>: View {
    
    @State private var isPresenting = false
    @State private var isFullscreen = false
    @State private var sourceRect: CGRect? = nil
    
    
    let source: () -> SourceView
    let target: () -> TargetView
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Button(action: {
                    self.isFullscreen = false
                    self.isPresenting = true
                    self.sourceRect = geometry.frame(in: .global)
                }) {
                    self.source()
                }
            }
            
            if isPresenting {
                GeometryReader { geometry in
                    Button(action: {
                        self.isPresenting = false
                    }) {
                        self.target()
                    }
                    .frame(
                        width: self.isFullscreen ? nil : self.sourceRect?.width ?? nil,
                        height: self.isFullscreen ? nil : self.sourceRect?.height ?? nil
                    )
                    .position(
                        self.isFullscreen ? geometry.frame(in: .global).center : self.sourceRect?.center ?? geometry.frame(in: .global).center
                    )
                        .animation(.easeInOut(duration: 4))
                        .onAppear {
                            //withAnimation(.easeInOut(duration: 4)) {
                                self.isFullscreen = true
                            //}
                    }
                }
            }
        }
    }
}

//struct ModalPresentable_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalPresentable()
//    }
//}
