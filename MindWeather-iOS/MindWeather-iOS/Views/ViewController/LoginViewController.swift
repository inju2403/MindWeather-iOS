//
//  LoginViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/16.
//
import UIKit
import Alamofire

class LoginViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UserDefaults.standard.set("false", forKey: "runFirst") // 최초 실행시 설정
        
        let loginRequest = LoginRequest(username: "운영", password: "abcd12345!!")
        
        AF.request("\(K.API_BASE_URL)auth/login/",
                   method: .post,
                   parameters: loginRequest,
                   encoder: JSONParameterEncoder())
                .responseDecodable(of: LoginSignUpReturn.self) { response in
                    debugPrint(response)
                    switch response.response?.statusCode {
                    case 200:
                        UserDefaults.standard.set(response.value?.token, forKey: "token")
                        UserDefaults.standard.set(response.value?.user.pk, forKey: "pk")
                        UserDefaults.standard.set(response.value?.user.username, forKey: "username")
                        UserDefaults.standard.set(response.value?.user.email, forKey: "email")
                        
                        //자동로그인, 일기리스트 화면으로 이동 작성 예정
                        break
                    case 400:
                        print("error")
                        break
                    default:
                        break
                    }
                    
                }
        
//        AlamofireManager
//            .shared
//            .session
//            .request("\(K.API_BASE_URL)auth/login/",
//                    method: .post,
//                    parameters: loginRequest,
//                    encoder: JSONParameterEncoder())
//            .responseDecodable(of: LoginSignUpReturn.self) { response in
//                print(response)
//            }
    }


}
