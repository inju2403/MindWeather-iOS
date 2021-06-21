//
//  SignUpRequest.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import Foundation

struct SignUpRequest: Codable {
    let username: String
    let email: String
    let password1: String
    let password2: String
}
