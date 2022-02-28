//
//  ChangePassword.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/07/03.
//

import Foundation

struct ChangePassword: Codable {
    let old_password: String
    let new_password1: String
    let new_password2: String
}
