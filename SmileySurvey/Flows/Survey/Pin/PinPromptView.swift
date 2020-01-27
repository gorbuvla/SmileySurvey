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
    
    let viewModel: PinPromptViewModel
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
                        Text("1").font(.largeTitle).fontWeight(.heavy)
                        Text("_").font(.largeTitle).padding(.horizontal, 10)
                        Text("_").font(.largeTitle).padding(.horizontal, 10)
                        Text("_").font(.largeTitle).padding(.horizontal, 10)
                    }.padding(.bottom, 50)
                    
                    HStack {
                        Button(action: {}) {
                            Text("1")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                        
                        Button(action: {}) {
                            Text("2")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                        
                        Button(action: {}) {
                            Text("3")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                    }.padding([.bottom], 10)
                    
                    HStack {
                        Button(action: {}) {
                            Text("4")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                        
                        Button(action: {}) {
                            Text("5")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                        
                        Button(action: {}) {
                            Text("6")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                    }.padding([.bottom], 10)
                    
                    HStack {
                        Button(action: {}) {
                            Text("7")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                        
                        Button(action: {}) {
                            Text("8")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                        
                        Button(action: {}) {
                            Text("9")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                    }.padding([.bottom], 10)
                    
                    HStack {
                        Button(action: {}) {
                            Text("*")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                        
                        Button(action: {}) {
                            Text("0")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                        
                        Button(action: {}) {
                            Text("#")
                                .font(.largeTitle)
                                .roundedBackground(.white)
                        }
                    }
                    Spacer()
                }.navigationBarItems(trailing: Button(action: { self.presentationMode.wrappedValue.dismiss() }) { Text("Exit") })
                
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.random.opacity(0.3), lineWidth: 4)
        )
        .fullSpace()
        .onReceive(viewModel.success) {
            self.onSuccess()
        }
    }
    
    enum Mode {
        case new
        case verify
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
