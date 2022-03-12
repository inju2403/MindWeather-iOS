//
//  UIFont+Extension.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2022/03/12.
//

import UIKit

extension UIFont {
    class func AppleSDGothic(type: AppleSDGothicType, size: CGFloat) -> UIFont! {
        guard let font = UIFont(name: type.name, size: size) else {
            return nil
        }
        return font
    }

    public enum AppleSDGothicType {
        case nanumpen
        case Nanumgothic
        case NanumMyeongjo
        case NanumMyeongjoBold
        case NanumSquareRoundB
        case NanumSquareRoundR

        var name: String {
            switch self {
            case .nanumpen:
                return "nanumpen"
            case .Nanumgothic:
                return "NanumGothic"
            case .NanumMyeongjo:
                return "NanumMyeongjo"
            case .NanumMyeongjoBold:
                return "NanumMyeongjoBold"
            case .NanumSquareRoundB:
                return "NanumSquareRoundB"
            case .NanumSquareRoundR:
                return "NanumSquareRoundR"
            }
        }
    }
}
