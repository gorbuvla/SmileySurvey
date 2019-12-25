//
//  SmileyHostingController.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 25/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

extension Notification.Name {
    
    static let custom_viewWillTransition = Notification.Name("SmileyHostingController_viewWillTransition")
}

class SmileyHostingController<Content>: UIHostingController<Content> where Content: View {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        NotificationCenter.default.post(name: .custom_viewWillTransition, object: nil, userInfo: ["size": size])
        super.viewWillTransition(to: size, with: coordinator)
    }
}
