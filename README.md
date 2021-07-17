# 마음의 날씨 (iOS AI Diary App)    

<div><img src="https://user-images.githubusercontent.com/56947879/125798946-57a5a0a8-cc6f-453e-bf95-49af93bf3eec.png"  width="100%"></div>

## Project Description    

'오늘, 내 마음의 날씨는 무엇일까?'    
    
     
'마음의 날씨'는?     
    
딥러닝을 활용한 NLP를 사용하여 한글어 감정 분석을 통해 사용자가 작성한 일기의 내용을 분석하여 감정 상태를 분석, 도출한 뒤, 사용자에게 결과를 그래프로 시각화하여 제공하여 피드백을 줄 수 있는 일기 iOS 애플리케이션    


## Background    

일기의 경우, 단순 기록으로만 끝나는 경우가 많은데 이를 넘어서 감정도와 레포트를 제공함으로써 사용자에게 동기부여 및 의미있는 기록을 돕고 사회적으로 긍정적인 결과를 기대할 수 있음



## Role    

iOS 모바일 어플리케이션 UI/UX, 아키텍쳐 설계 및 구축, 데이터 시각화 및 전처리, User contacts    


## Used Libraries
 - [RxSwift](https://github.com/ReactiveX/RxSwift) (RxSwift is the Swift-specific implementation of the Reactive Extensions standard)
 - [Alamofire](https://github.com/Alamofire/Alamofire)  (Alamofire is an HTTP networking library written in Swift)
 - [Charts](https://github.com/danielgindi/Charts) (Beautiful charts for iOS/tvOS/OSX)
 - [FSPagerView](https://github.com/WenchaoD/FSPagerView) (FSPagerView is an elegant Screen Slide Library implemented primarily with UICollectionView)
    

<img src="https://user-images.githubusercontent.com/56947879/126030176-ff993351-b655-490c-86f5-9b1521e09638.png" align="right" width="360">

## Architecture

This iOS AI Diary app uses MVVM architecture. The repository imports entities, the service processes these entities and processes business logic. The view model handles presentation logic.

```kt

// View
@IBOutlet weak var content: UILabel!

diaryDetailViewModel.content
    .asDriver()
    .drive(content.rx.text)
    .disposed(by: disposeBag)


// ViewModel
var content: BehaviorRelay<String> = BehaviorRelay(value: "")

func loadDiary(diaryId: Int) {
    _ = service.getDiaryById(diaryId: diaryId)
        .subscribe { event in
            switch event {
            case .success(let diary):
                self.content.accept(diary.content ?? "")
                break
            case .failure(let error):
                print("Error: ", error)
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
    
    
    
## Licence
```
MIT License

Copyright (c) 2021 inju2403

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
