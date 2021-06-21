//
//  LoginViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/16.
//
import UIKit
import Alamofire

class LoginViewController : UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        UserDefaults.standard.set("false", forKey: "runFirst") // 최초 실행시 설정
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "moveSignUpIdentifier", sender: self)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        let loginRequest = LoginRequest(username: username, password: password)
        
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
                        self.performSegue(withIdentifier: "moveMainTabBarIdentifier", sender: self)
                        break
                    case 400:
                        print("error")
                        break
                    default:
                        break
                    }
                    
                }
    }
    
    // 사용자가 바로 입력할 수 있도록 세팅
    override func viewWillAppear(_ animated: Bool) {
        self.usernameTextField.becomeFirstResponder()
    }
    
    // 키보드 밖을 클릭하면 키보드가 내려가도록 세팅
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    private func setUI() {
        usernameTextField.underlined()
        passwordTextField.underlined()
    }

}

extension UITextField {
    func underlined() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
