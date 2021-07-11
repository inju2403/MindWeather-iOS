# 마음의 날씨 (iOS AI Diary App)    

<div><img src="https://user-images.githubusercontent.com/56947879/125184696-e0b7ad80-e25a-11eb-9c92-6b50799d5392.png"  width="100%"></div>

## Project Description    

'오늘, 내 마음의 날씨는 무엇일까?'    
    
     
'마음의 날씨'는?     
    
딥러닝을 활용한 NLP를 사용하여 한글어 감정 분석을 통해 사용자가 작성한 일기의 내용을 분석하여 감정 상태를 분석, 도출한 뒤, 사용자에게 결과를 그래프로 시각화하여 제공하여 피드백을 줄 수 있는 일기 안드로이드 애플리케이션    


## Background    

일기의 경우, 단순 기록으로만 끝나는 경우가 많은데 이를 넘어서 감정도와 레포트를 제공함으로써 사용자에게 동기부여 및 의미있는 기록을 돕고 사회적으로 긍정적인 결과를 기대할 수 있음



## Role    

iOS 모바일 어플리케이션 UI/UX, 아키텍쳐 설계 및 구축, 데이터 시각화 및 전처리, User contacts    


## Used Libraries
 - [RxSwift](https://github.com/ReactiveX/RxSwift) (RxSwift is the Swift-specific implementation of the Reactive Extensions standard)
 - [Alamofire](https://github.com/Alamofire/Alamofire)  (Alamofire is an HTTP networking library written in Swift)
 - [Charts](https://github.com/danielgindi/Charts) (Beautiful charts for iOS/tvOS/OSX)
    


## Architecture

This iOS AI Diary app uses MVVM architecture. The repository imports entities, the service processes these entities and processes business logic. The view model handles presentation logic.

```kt

// View
diaryListViewModel.diaryList
    .bind(to: diaryListTableView.rx.items(cellIdentifier: K.diaryListCellIdentifier, cellType: DiaryListCell.self)) { (index: Int, element: Diary, cell: DiaryListCell) in
            // todo
        }
    }.disposed(by: disposeBag)

// ViewModel
var disposeBag = DisposeBag()
private let service = DiaryServiceImpl()
var diaryList: BehaviorRelay<[Diary]> = BehaviorRelay(value: [])

func getDiarys() {
    _ = service.getDiarys()
        .subscribe { event in
            switch event {
            case .success(let diarys):
                self.diaryList.accept(diarys)
                break
            case .failure(let error):
                break
            }
        }
        .disposed(by: disposeBag)
}
```

## Author

* **LEE SEUNGJU**
    * **Github** - (https://github.com/inju2403)
    * **Blog**    - (https://blog.naver.com/inju2403)
