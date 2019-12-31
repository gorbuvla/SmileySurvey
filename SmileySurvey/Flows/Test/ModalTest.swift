//
//  ModalTest.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 16/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct ModalTest: View {
    
    @State var isPresenting = false
    @State var isFullscreen = false
    @State var sourceRect: CGRect? = nil
    
    let survey = Survey(
        name: "Questionarie", question: "How was your meal?", excellent: 5, good: 3, bad: 3, disaster: 4
    )
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Button(action: {
                    self.isFullscreen = false
                    self.isPresenting = true
                    self.sourceRect = proxy.frame(in: .global)
                }) {
                    SurveyGridItemView(survey: self.survey)
                }
            }
            
            if isPresenting {
                GeometryReader { proxy in
                    Button(action: {
                        //self.isFullscreen = true
                        self.isPresenting = false
                        //self.sourceRect = proxy.frame(in: .global)
                    }) {
                        SurveyGridItemView(survey: self.survey)
                    }
                    
                    .frame(
                        width: self.isFullscreen ? nil : self.sourceRect?.width ?? nil,
                        height: self.isFullscreen ? nil : self.sourceRect?.height ?? nil
                    )
                    .position(
                        self.isFullscreen ? proxy.frame(in: .global).center : self.sourceRect?.center ?? proxy.frame(in: .global).center
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

extension CGRect {
    var center : CGPoint {
        return CGPoint(x:self.midX, y:self.midY)
    }
}


struct ModalTest_Previews: PreviewProvider {
    static var previews: some View {
        ModalTest()
    }
}
