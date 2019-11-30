//
//  ContentView.swift
//  SmileSurvey
//
//  Created by Vlad Gorbunov on 10/11/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //ModalTest()
//            .frame(width: 330, height: 200, alignment: .center)
        
        
            SurveyGridView()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
