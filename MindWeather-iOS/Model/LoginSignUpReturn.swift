//
//  LoginSignUpReturn.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/20.
//

import Foundation

struct LoginSignUpReturn: Codable {
    let token: String
    let user: LoginSignUpUser
}
