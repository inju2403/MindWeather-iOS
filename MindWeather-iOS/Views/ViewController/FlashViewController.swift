//
//  ViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/15.
//
import UIKit

class FlashViewController: UIViewController {

    @IBOutlet weak var logoText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        logoText.font = UIFont.AppleSDGothic(type: .nanumpen, size: 40)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let runFirst = UserDefaults.standard.value(forKey: "runFirst")
        let token = UserDefaults.standard.value(forKey: "token")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if token != nil { //자동 로그인
                self.performSegue(withIdentifier: K.mainTabBarSegue, sender: self)
            } else if runFirst == nil {
                self.performSegue(withIdentifier: K.tutorialSegue, sender: self)
            } else {
                self.performSegue(withIdentifier: K.loginSegue, sender: self)
            }
        }
    }
    
}

extension UIFont {
    class func AppleSDGothic(type: AppleSDGothicType, size: CGFloat) -> UIFont! {
        guard let font = UIFont(name: type.name, size: size) else {
            return nil
        }
        return font
    }

    public enum AppleSDGothicType {
        case nanumpen
        case hanna

        var name: String {
            switch self {
            case .nanumpen:
                return "nanumpen"
            case .hanna:
                return "BMHANNAAir_otf"
            }
        }
    }
}
