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
        
//        AF.request(K.API_BASE_URL+"auth/login/",
//                   method: .post,
//                   parameters: loginRequest,
//                   encoder: JSONParameterEncoder.default).responseJSON { response in
//                    print("-------------------")
//                    print(response)
//                    print(response)
//        }
        
        AlamofireManager
            .shared
            .session
            .request("\(K.API_BASE_URL)auth/login/",
                    method: .post,
                    parameters: loginRequest,
                    encoder: JSONParameterEncoder())
            .responseDecodable(of: LoginSignUpReturn.self) { response in
                print(response)
            }
        
//            .responseJSON(completionHandler: { response in
//                debugPrint(response)
//            })
    }


}
