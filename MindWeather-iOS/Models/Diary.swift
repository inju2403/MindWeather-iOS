//
//  Diary.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import Foundation

struct Diary: Codable {
    var id: Int? = Constant.newDiaryValue
    let content: String?
    let created_at: String?
    let updated_at: String?
    let happiness: Int?
    let neutrality: Int?
    let sadness: Int?
    let worry: Int?
    let anger: Int?
    let qna: String?
    let user: Int?
}
