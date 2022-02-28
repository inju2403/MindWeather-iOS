//
//  RepositoryInjector.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2022/02/27.
//

struct RepositoryInjector {
    static func injectDiaryRepo() -> DiaryRepo {
        return DiaryRepoImpl()
    }
}
