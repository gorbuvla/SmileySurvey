//
//  ModalPresentableI.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 01/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct ModalPresentableI<SourceView: View, TargetView: View>: View {
    
    @Binding var isPresenting: Bool
    let sourceFactory: () -> SourceView
    let targetFactory: () -> TargetView
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.sourceFactory()
                    .disabled(self.isPresenting)
                    .blur(radius: self.isPresenting ? 3 : 0)
                
                if self.isPresenting {
                    ZStack {
                        self.targetFactory()
                        .animation(.easeInOut(duration: 4))
                    }
                    
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    .onTapGesture {
                        self.isPresenting.toggle()
                    }
                }
            }
        }
    }
}

extension View {
    func modalPresentalbe<TargetView: View>(isPresenting: Binding<Bool>, modalFactory: @escaping () -> TargetView) -> some View {
        return ModalPresentableI(isPresenting: isPresenting, sourceFactory: { self }, targetFactory: modalFactory)
    }
}


//struct ModalPresentableI_Previews: PreviewProvider {
//    static var previews: some View {
//        
//    }
//}
