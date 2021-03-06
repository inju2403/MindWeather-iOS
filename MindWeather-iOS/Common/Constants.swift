//
//  Constants.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/16.
//

import Foundation

struct Constant {
    static let APIBaseUrl = "http://ec2-15-164-244-150.ap-northeast-2.compute.amazonaws.com:8000/"
    
    static let tutorialSegue = "moveTutorialIdentifier"
    static let loginSegue = "moveLoginIdentifier"
    static let signupSegue = "moveSignUpIdentifier"
    static let mainTabBarSegue = "moveMainTabBarIdentifier"
    static let diaryDetailSegue = "moveDiaryDetailIdentifier"
    static let diaryEditSegue = "moveDiaryEditIdentifier"
    static let nickNameEditSegue = "moveNickNameEditIdentifier"
    static let passwordEditSegue = "movePasswordEditIdentifier"
    static let weatherDescriptionSegue = "moveWeatherDescriptionIdentifier"
    static let personalInformationProcessingSegue = "movePersonalInformationProcessingIdentifier"
    
    static let diaryListCellIdentifier = "ReusableCell"
    static let diaryCellNibName = "DiaryListCell"
    
    static let newDiaryValue = 987654321
    
    static let mainColor = 0xFDF5E6 // 메인 색상
    static let brownColor = 0x8B4513 // 텍스트 색상

    static let goldColor = 0xFFA700 // 행복
    static let greyColor = 0xBBBBBB // 중립
    static let pupleColor = 0xA575CD // 걱정
    static let blueColor = 0x42A5F5 // 슬픔
    static let redColor = 0xFF4950 // 분노

    static let happinessName = "행복"
    static let neutralityName = "중립"
    static let worryName = "걱정"
    static let sadnessName = "슬픔"
    static let angerName = "분노"

    static let aWeekEmotionTitle = "한주의 감정"
    static let aMonthEmotionTitle = "한달의 감정"
    static let sixMonthEmotionTitle = "6개월의 감정"
    static let aYearEmotionTitle = "1년의 감정"

    static func token() -> String {
        return "JWT " + UserDefaults.standard.string(forKey: "token")!
    }

    enum receiver {
        static let diarys = "diarys"
        static let diary = "diary"
        static let addOrUpdateDiary = "addOrUpdateDiary"
        static let deleteDiary = "deleteDiary"
        static let newStateDiary = "newStateDiary"
        static let emotions = "emotions"
    }
}

enum NOTIFICATION {
    enum API {
        static let statusCode = "statusCode"
        static let networkError = "networkError"
        static let updateDiarys = "updateDiarys"
        static let updateEmotions = "updateEmotions"

        static let authFailErrorMessage = "인증정보가 만료됐어요.\n로그아웃 후 재로그인해주세요"
        static let serverErrorMessage = "서버가 불안정해요.\n잠시 후에 다시 시도해주세요"
    }
}
