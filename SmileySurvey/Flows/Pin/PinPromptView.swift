//
//  PinPromptView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 27/01/2020.
//  Copyright © 2020 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

struct PinPromptView: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: PinPromptViewModel
    @State var attempts: Int = 0
    
    let onSuccess: () -> ()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.blue.opacity(0.1))
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.all) // a hack to draw under navbar
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Text(self.viewModel.digit1 ?? "_").pinDigitStyle()
                        Text(self.viewModel.digit2 ?? "_").pinDigitStyle()
                        Text(self.viewModel.digit3 ?? "_").pinDigitStyle()
                        Text(self.viewModel.digit4 ?? "_").pinDigitStyle()
                    }.padding(.bottom, 10)
                        
                    Spacer()
                    
                    errorView
                    
                    Spacer()
        
                    // dont think you are the only smart here..
                    // with view builders i cant generate rows and add views in forEach or similar way...
                    
                    buttonRowView(digit1: "1", digit2: "2", digit3: "3")
                        .padding(.bottom, 10)
                        
                    buttonRowView(digit1: "4", digit2: "5", digit3: "6")
                        .padding(.bottom, 10)
                    
                    buttonRowView(digit1: "7", digit2: "8", digit3: "9")
                        .padding(.bottom, 10)
                    
                    buttonRowView(digit1: "*", digit2: "0", digit3: "#")
                        .padding(.bottom, 10)
                    
                    Spacer()
                }.navigationBarItems(trailing: trailingNavItems)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.random.opacity(0.3), lineWidth: 4)
        )
        .modifier(Shake(animatableData: CGFloat(attempts)))
        .fullSpace()
        .onReceive(viewModel.completion) {
            self.presentationMode.wrappedValue.dismiss()
            self.onSuccess()
        }
        .onReceive(viewModel.shake) {
            withAnimation(.default) {
                self.attempts += 1
            }
        }
    }
    
    private var trailingNavItems: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text(L10n.General.exit)
        }
    }
    
    private var errorView: AnyView {
        if let error = viewModel.error {
            return AnyView(Text(error).foregroundColor(.red))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    private func buttonRowView(digit1: String, digit2: String, digit3: String) -> some View {
        return HStack {
            Button(action: { self.viewModel.enter(digit: digit1) }) {
                Text(digit1)
                    .font(.largeTitle)
                    .roundedBackground(.white)
            }
            
            Button(action: { self.viewModel.enter(digit: digit2) }) {
                Text(digit2)
                    .font(.largeTitle)
                    .roundedBackground(.white)
            }
            
            Button(action: { self.viewModel.enter(digit: digit3) }) {
                Text(digit3)
                    .font(.largeTitle)
                    .roundedBackground(.white)
            }
        }
    }
    
    enum Mode {
        case new
        case verify
    }
}

fileprivate extension Text {
    
    func pinDigitStyle() -> some View {
        self.font(.largeTitle).fontWeight(.heavy).padding(.horizontal, 10)
    }
}

fileprivate extension View {
    
    func roundedBackground(_ color: Color) -> some View {
        return self
            .frame(width: 100, height: 50, alignment: .center)
            .padding([.horizontal], 20)
            .padding([.vertical], 10)
            .background(color)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 2)
            )
    }
}
