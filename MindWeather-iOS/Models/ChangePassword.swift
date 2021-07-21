//
//  ChangePassword.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/07/03.
//

import Foundation

struct ChangePassword: Codable {
    var old_password: String
    var new_password1: String
    var new_password2: String
}
