//
//  BaseViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2022/03/10.
//

import UIKit

import Toast_Swift

class BaseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showAPIErrorPopup(notification:)),
            name: NSNotification.Name(rawValue: NOTIFICATION.API.networkError),
            object: nil
        )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name(rawValue: NOTIFICATION.API.networkError),
            object: nil
        )
    }

    @objc func showAPIErrorPopup(notification: NSNotification) {
        var newtworkErrorMessage = ""

        guard let notificationInfo = notification.userInfo as? [String : Int],
            let statusCode = notificationInfo[NOTIFICATION.API.statusCode] else {
              return
        }

        switch statusCode {
        case 401:
            newtworkErrorMessage = NOTIFICATION.API.authFailErrorMessage
        case 500...599:
            newtworkErrorMessage = NOTIFICATION.API.serverErrorMessage
        default:
            newtworkErrorMessage = "\(statusCode) 에러입니다"
        }

        DispatchQueue.main.async {
            self.view.makeToast(
                newtworkErrorMessage,
                duration: 1.5,
                position: .center
            )
        }
    }
}
