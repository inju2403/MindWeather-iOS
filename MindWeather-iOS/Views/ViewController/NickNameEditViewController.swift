//
//  NickNameEditViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/07/02.
//

import UIKit
import Alamofire

class NickNameEditViewController: UIViewController {
    
    let token = "JWT " + UserDefaults.standard.string(forKey: "token")!
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        nickNameTextField.delegate = self
        
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeButtonPressed(_ sender: UIButton) {
        print(UserDefaults.standard.string(forKey: "username"))
        guard let username = nickNameTextField.text else {
            return
        }
        
        let changeUserName = ChangeUserName(username: username)
        
        AF.request("\(K.API_BASE_URL)auth/user/",
                   method: .patch,
                   parameters: changeUserName,
                   encoder: JSONParameterEncoder(), headers: ["Authorization" : self.token])
                .responseJSON { response in
                    debugPrint(response.response?.statusCode)
                    switch response.response?.statusCode {
                    case 200:
                        self.showAlert(style: .alert, message: "닉네임 변경 성공.\n새 닉네임으로 다시 로그인해주세요", type: "200")
                        break
                    case 400:
                        self.showAlert(style: .alert, message: "이미 존재하는 닉네임이에요", type: "400")
                        break
                    default:
                        self.showAlert(style: .alert, message: "서버가 불안정해요.\n잠시 후에 다시 시도해주세요", type: "default")
                        break
                    }
                }
    }
    
    // 사용자가 바로 입력할 수 있도록 세팅
    override func viewWillAppear(_ animated: Bool) {
        self.nickNameTextField.becomeFirstResponder()
    }
    
    // 키보드 밖을 클릭하면 키보드가 내려가도록 세팅
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nickNameTextField.resignFirstResponder()
    }
    
    private func setUI() {
        nickNameTextField.underlined()
    }
    
    private func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //닉네임 변경 후에는 로그인 화면으로 이동
        if UserDefaults.standard.string(forKey: "username") == nil {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    
    }
    
    func showAlert(style: UIAlertController.Style, message: String, type: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: style)
        let success = UIAlertAction(title: "확인", style: .default, handler: {_ in
                self.resetDefaults()
                UserDefaults.standard.set(false, forKey: "runFirst")
                
                self.dismiss(animated: true, completion: nil)
        })
        
        let failure = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        let error = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        if type == "200" {
            alert.addAction(success)
        } else if type == "400" {
            alert.addAction(failure)
        } else if type == "default" {
            alert.addAction(error)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension NickNameEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nickNameTextField {
            nickNameTextField.resignFirstResponder()
        }
        return true
    }
}
