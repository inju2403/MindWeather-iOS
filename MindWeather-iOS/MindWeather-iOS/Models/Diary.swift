//
//  Diary.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import Foundation

struct Diary: Codable {
    var id: String = "987654321"
    var content: String
    var created_at: Date = Date()
    var updated_at: Date = Date()
    var happiness: Int
    var neutrality: Int
    var sadness: Int
    var worry: Int
    var anger: Int
    var qna: String
    var user: String
}
