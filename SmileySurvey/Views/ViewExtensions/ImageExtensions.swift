//
//  ImageExtensions.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 26/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

extension Image {
    
    func fitIntoBounds() -> some View {
        return self
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
