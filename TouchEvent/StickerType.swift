//
//  StickerType.swift
//  TouchEvent
//
//  Created by Owner on 2024/08/29.
//

import Foundation

enum StickerType {
    //スタンプの種類を定義
    case flower
    case cloud
    case heart
    case star
    
    //それぞれのスタンプに対応する画像名
    var imageName: String {
        switch self {
        case .flower: "flower"
        case .cloud: "cloud"
        case .heart: "heart"
        case .star: "star"
        }
    }
    
    //それぞれのスタンプの表示名
    var displayName: String {
        switch self {
        case .flower: "花"
        case .cloud: "雲"
        case .heart: "ハート"
        case .star: "星"
        }
    }
}
