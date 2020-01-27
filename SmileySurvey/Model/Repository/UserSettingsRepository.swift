//
//  UserSettingsRepository.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 27/01/2020.
//  Copyright © 2020 Vlad Gorbunov. All rights reserved.
//

import Foundation

protocol UserSettingsRepositoring {
    
    var pin: String? { get set }
}

final class UserSettingsRepository: UserSettingsRepositoring {
    
    @UserDefault("user_pin", defaultValue: nil)
    var pin: String?
}
