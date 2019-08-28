//
//  ToDo.swift
//  Todo-App
//
//  Created by 岩永彩里 on 2018/06/19.
//  Copyright © 2018年 iwanaga sari. All rights reserved.
//

import UIKit

enum TodoPriority:Int {
    case Low = 0
    case Middle = 1
    case High = 2
    
    func color() -> UIColor {
        switch self {
            case .Low:
            return UIColor.yellow
            case .Middle:
            return UIColor.green
            case .High:
            return UIColor.red
        }
    }
}

class Todo: NSObject {
    var title = ""
    var descript = ""
    var priority:TodoPriority = .Low
}

