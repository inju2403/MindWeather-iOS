//
//  LoginSignUpUser.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/20.
//

import Foundation

struct LoginSignUpUser: Codable {
    let pk: Int
    let username: String
    let email: String
    let first_name: String
    let last_name: String
}
