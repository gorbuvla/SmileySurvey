//
//  GeenralViewExtensions.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 26/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

//
// Custom view extensions applyable for all kinds of views.
//
extension View {
    func largePadding() -> some View {
        return self.padding(.all, 60)
    }
    
    func smallPadding() -> some View {
        return self.padding(.all, 8)
    }
}

extension View {
    
    func fullSpace() -> some View {
        return self.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}
