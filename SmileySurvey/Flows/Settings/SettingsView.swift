//
//  SettingsView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 30/01/2020.
//  Copyright © 2020 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    @State private var presented: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text(L10n.Settings.General.title)) {
                Button(action: { self.presented.toggle() }) {
                    HStack {
                        Text(L10n.Settings.General.Pin.title)
                        
                        Spacer()
                        
                        pinTitle
                    }
                }
            }
        }
        .navigationBarTitle(L10n.Settings.title)
        .sheet(isPresented: $presented) {
            PinPromptView(viewModel: factories.pinPromptViewModel(.new)) {
                self.viewModel.onUpdated()
            }
        }
    }
    
    private var pinTitle: AnyView {
        if let pin = self.viewModel.pin, !pin.isEmpty {
            return AnyView(
                HStack{
                    Text(pin).foregroundColor(Color.black)
                    
                    Button(action: { self.viewModel.delete() }) { Image.delete }
                }
            )
        } else {
            return AnyView(Text(L10n.Settings.General.Pin.empty).foregroundColor(Color.gray))
        }
    }
}
