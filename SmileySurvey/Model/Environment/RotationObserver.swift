//
//  RotationObserver.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 25/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import SwiftUI

enum Orientation {
    case portrait
    case landscape
}

class RotationObserver: ObservableObject {
    
    @Published var mode: Orientation = .portrait
    
    init(mode: Orientation) {
        self.mode = mode
        NotificationCenter.default.addObserver(self, selector: #selector(onTransition(notification:)), name: .custom_viewWillTransition, object: nil)
    }
    
    @objc private func onTransition(notification: Notification) {
        guard let size = notification.userInfo?["size"] as? CGSize else { return }

        mode = size.width > size.height ? .landscape : .portrait
    }    
}
