//
//  MyPageViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/07/02.
//

import UIKit

import Alamofire

class MyPageViewController : UIViewController {
    
    @IBOutlet weak var logoText: UILabel!
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var weatherExplainButton: UIButton!
    @IBOutlet weak var changeUserNameButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var deleteUserButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        setFonts()
        usernameText.text = UserDefaults.standard.string(forKey: "username")
        emailText.text = UserDefaults.standard.string(forKey: "email")
        
    }
    
    @IBAction func weatherDescriptionButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.weatherDescriptionSegue, sender: self)
    }
    
    @IBAction func changeUserNameButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.nickNameEditSegue, sender: self)
    }
    @IBAction func ChangePasswordButtionPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.passwordEditSegue, sender: self)
    }
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        //로그아웃 팝업 작성 예정
        showAlert(style: .actionSheet, message: "로그아웃 하시겠어요?", type: "logout")
    }
    @IBAction func deleteUserButtonPressed(_ sender: UIButton) {
        //계정삭제 팝업 작성 예정
        showAlert(style: .alert, message: "계정의 모든 정보가 삭제됩니다. 계속 하시겠어요?", type: "deleteUser")
    }
    
    private func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    private func setFonts() {
        logoText.font = UIFont.AppleSDGothic(type: .nanumpen, size: 40)
        
        usernameText.font = UIFont.AppleSDGothic(type: .NanumMyeongjoBold, size: 16)
        emailText.font = UIFont.AppleSDGothic(type: .NanumMyeongjoBold, size: 16)
        
        weatherExplainButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        changeUserNameButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        changePasswordButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        logoutButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        deleteUserButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
    }
    
    func showAlert(style: UIAlertController.Style, message: String, type: String) {
        let titleFont = [NSAttributedString.Key.font: UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)]
        let titleAttrString = NSMutableAttributedString(string: message, attributes: titleFont)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: style)
        alert.setValue(titleAttrString, forKey:"attributedTitle")
        
        let success = UIAlertAction(title: "확인", style: .default, handler: {_ in
            if type == "logout" {
                self.resetDefaults()
                UserDefaults.standard.set(false, forKey: "runFirst")
                
                self.dismiss(animated: true, completion: nil)
            } else if type == "deleteUser" {
                AF.request("\(Constant.APIBaseUrl)auth/delete/",
                           method: .get,
                           headers: ["Authorization" : Constant.token()])
                    .responseJSON { response in
                        debugPrint(response.response?.statusCode)
                        switch response.response?.statusCode {
                        case 200:

                            self.resetDefaults()
                            UserDefaults.standard.set(false, forKey: "runFirst")

                            self.dismiss(animated: true, completion: nil)
                            break
                        case 400:
                            print("error")
                            break
                        default:
                            break
                        }

                    }
            }
        })
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let destructive = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        if type == "logout" {
            success.setValue(UIColor(rgb: Constant.brownColor), forKey: "titleTextColor")
        } else if type == "deleteUser" {
            success.setValue(UIColor(rgb: Constant.greyColor), forKey: "titleTextColor")
        }
        cancel.setValue(UIColor(rgb: Constant.brownColor), forKey: "titleTextColor")
        
        alert.addAction(success)
        if type == "logout" {
            alert.addAction(cancel)
        } else if type == "deleteUser" {
            alert.addAction(destructive)
        }
        self.present(alert, animated: true, completion: nil)
    }
}
