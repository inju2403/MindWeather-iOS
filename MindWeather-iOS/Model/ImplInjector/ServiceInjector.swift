//
//  ServiceInjector.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2022/02/27.
//

struct ServiceInjector {
    static func injectDiaryService() -> DiaryService {
        return DiaryServiceImpl(repo: RepositoryInjector.injectDiaryRepo())
    }
}
