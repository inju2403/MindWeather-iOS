//
//  Constants.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/16.
//

import Foundation

struct K {
    static let API_BASE_URL = "http://ec2-15-164-244-150.ap-northeast-2.compute.amazonaws.com:8000/"
    
    static let tutorialSegue = "moveTutorialIdentifier"
    static let loginSegue = "moveLoginIdentifier"
    static let signupSegue = "moveSignUpIdentifier"
    static let mainTabBarSegue = "moveMainTabBarIdentifier"
    static let diaryDetailSegue = "moveDiaryDetailIdentifier"
    static let diaryEditSegue = "moveDiaryEditIdentifier"
    static let nickNameEditSegue = "moveNickNameEditIdentifier"
    static let passwordEditSegue = "movePasswordEditIdentifier"
    
    static let diaryListCellIdentifier = "ReusableCell"
    static let diaryCellNibName = "DiaryListCell"
    
    static let newDiaryValue = 987654321
}
