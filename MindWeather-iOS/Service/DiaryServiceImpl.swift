//
//  DiaryServiceImpl.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/22.
//

import Foundation

import RxSwift

class DiaryServiceImpl: DiaryService {
    
    private let repo: DiaryRepo

    init(repo: DiaryRepo) {
        self.repo = repo
    }
    
    func diarys() -> Single<[Diary]> {
        return repo.diarys()
    }

    func diary(diaryId: Int) -> Single<Diary> {
        return repo.diary(diaryId: diaryId)
    }

    func updateDiary(content: Content, diaryId: Int) -> Single<Diary> {
        return repo.updateDiary(content: content, diaryId: diaryId)
    }

    func deleteDiary(diaryId: Int) -> Single<Bool> {
        return repo.deleteDiary(diaryId: diaryId)
    }

    func emotions() -> Single<[Emotion]> {
        return Single<[Emotion]>.create { [weak self] single in
            self?.repo.diarys()
                .subscribe { event in
                    switch event {
                    case .success(let diarys):
                        //emotions 배열 세팅
                        //emotions -> [한주, 한달, 6개월, 1년]
                        var aWeekEmotion = Emotion()
                        var aMonthEmotion = Emotion()
                        var sixMonthEmotion = Emotion()
                        var aYearEmotion = Emotion()
                        
                        var happinessCnt1year = 0.0
                        var happinessCnt6month = 0.0
                        var happinessCnt1month = 0.0
                        var happinessCnt1week = 0.0

                        var neutralityCnt1year = 0.0
                        var neutralityCnt6month = 0.0
                        var neutralityCnt1month = 0.0
                        var neutralityCnt1week = 0.0

                        var sadnessCnt1year = 0.0
                        var sadnessCnt6month = 0.0
                        var sadnessCnt1month = 0.0
                        var sadnessCnt1week = 0.0

                        var worryCnt1year = 0.0
                        var worryCnt6month = 0.0
                        var worryCnt1month = 0.0
                        var worryCnt1week = 0.0

                        var angerCnt1year = 0.0
                        var angerCnt6month = 0.0
                        var angerCnt1month = 0.0
                        var angerCnt1week = 0.0
                        
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                        
                        dateFormatter.dateFormat = "yyyy"
                        let curYear = Int(dateFormatter.string(from: Date()))!
                        
                        dateFormatter.dateFormat = "MM"
                        let curMonth = Int(dateFormatter.string(from: Date()))!
                        
                        dateFormatter.dateFormat = "dd"
                        let curDay = Int(dateFormatter.string(from: Date()))!
                        let curTimeValue = curYear * (12 * 30) + curMonth * 30 + curDay
                        
                        for index in 0..<diarys.count {
                            let diary = diarys[index]
                            
                            var diaryYear = 0
                            var diaryMonth = 0
                            var diaryDay = 0

                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                            
                            let updatedAt = diary.updated_at!
                            if let index = updatedAt.firstIndex(of: "T") {
                                let substring = updatedAt[..<index]
                                let time = String(substring)
                                let date: Date = dateFormatter.date(from: time)!
                                
                                dateFormatter.dateFormat = "yyyy"
                                diaryYear = Int(dateFormatter.string(from: date))!
                                
                                dateFormatter.dateFormat = "MM"
                                diaryMonth = Int(dateFormatter.string(from: date))!
                                
                                dateFormatter.dateFormat = "dd"
                                diaryDay = Int(dateFormatter.string(from: date))!
                            }
                            
                            let diaryTimeValue = diaryYear * (12 * 30) + diaryMonth * 30 + diaryDay
                            let emotionValues = [diary.happiness, diary.neutrality, diary.sadness, diary.worry, diary.anger]
                            var mx = 0
                            for i in 0..<emotionValues.count {
                                if(mx < emotionValues[i]!) {
                                    mx = emotionValues[i]!;
                                }
                            }
                            
                            if(curTimeValue - diaryTimeValue <= 7) { // 한 주
                                if(diary.happiness == mx) {happinessCnt1week += 1.0}
                                if(diary.anger == mx) {angerCnt1week += 1.0}
                                if(diary.worry == mx) {worryCnt1week += 1.0}
                                if(diary.sadness == mx) {sadnessCnt1week += 1.0}
                                if(diary.neutrality == mx) {neutralityCnt1week += 1.0}
                            }

                            if(curTimeValue - diaryTimeValue <= 30) { // 한 달
                                if(diary.happiness == mx) {happinessCnt1month += 1.0}
                                if(diary.anger == mx) {angerCnt1month += 1.0}
                                if(diary.worry == mx) {worryCnt1month += 1.0}
                                if(diary.sadness == mx) {sadnessCnt1month += 1.0}
                                if(diary.neutrality == mx) {neutralityCnt1month += 1.0}
                            }

                            if(curTimeValue - diaryTimeValue <= 180) { // 6개월
                                if(diary.happiness == mx) {happinessCnt6month += 1.0}
                                if(diary.anger == mx) {angerCnt6month += 1.0}
                                if(diary.worry == mx) {worryCnt6month += 1.0}
                                if(diary.sadness == mx) {sadnessCnt6month += 1.0}
                                if(diary.neutrality == mx) {neutralityCnt6month += 1.0}
                            }

                            if(curTimeValue - diaryTimeValue <= 365) { // 1년
                                if(diary.happiness == mx) {happinessCnt1year += 1.0}
                                if(diary.anger == mx) {angerCnt1year += 1.0}
                                if(diary.worry == mx) {worryCnt1year += 1.0}
                                if(diary.sadness == mx) {sadnessCnt1year += 1.0}
                                if(diary.neutrality == mx) {neutralityCnt1year += 1.0}
                            }
                        }
                        
                        aWeekEmotion = Emotion(happiness: happinessCnt1week, anger: angerCnt1week, worry: worryCnt1week, sadness: sadnessCnt1week, neutrality: neutralityCnt1week)
                        aMonthEmotion = Emotion(happiness: happinessCnt1month, anger: angerCnt1month, worry: worryCnt1month, sadness: sadnessCnt1month, neutrality: neutralityCnt1month)
                        sixMonthEmotion = Emotion(happiness: happinessCnt6month, anger: angerCnt6month, worry: worryCnt6month, sadness: sadnessCnt6month, neutrality: neutralityCnt6month)
                        aYearEmotion = Emotion(happiness: happinessCnt1year, anger: angerCnt1year, worry: worryCnt1year, sadness: sadnessCnt1year, neutrality: neutralityCnt1year)
                        
                        let emotions = [aWeekEmotion, aMonthEmotion, sixMonthEmotion, aYearEmotion]
                        single(.success(emotions))
                        break
                    case .failure(let error):
                        print("Error: ", error)
                        break
                    }
                    
                }
            return Disposables.create()
        }
    }
}
