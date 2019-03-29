//
//  RanColor.swift
//  PlaygroundBook
//
//  Created by student on 2019/3/20.
//
import Foundation

import UIKit


//color
public func RanColor(index :Int) -> UIColor {
    
    switch index {
    case 0:return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    case 1:return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    case 2:return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    case 3:return #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
    case 4:return #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    case 5:return #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    case 6:return #colorLiteral(red: 0.2506145835, green: 0.7192841172, blue: 0.716160357, alpha: 1)
    case 7:return #colorLiteral(red: 1, green: 0.7801130414, blue: 0.9052978158, alpha: 1)
    default:
        return #colorLiteral(red: 0.9836056828, green: 0.6602786779, blue: 0.6627274752, alpha: 1)
    }
}

