//
//  KeyboardNotification.swift
//  KeyboardAwareViewController
//
//  Created by James Pang on 25/12/16.
//  Copyright © 2016 James Pang. All rights reserved.
//

import Foundation
import UIKit

//Inspiration for this class by kristopherjohnson from https://gist.github.com/kristopherjohnson/13d5f18b0d56b0ea9242
//Modified for my own needs
struct KeyboardNotification {
    let notification: Notification
    let userInfo: [AnyHashable : Any]
    
    init(_ notification: Notification) {
        self.notification = notification
        self.userInfo = notification.userInfo ?? [:]
    }
}

//MARK: - Public
extension KeyboardNotification {
    var keyboardFrameStart: CGRect {
        if let value = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
            return value.cgRectValue
        } else {
            return CGRect.zero
        }
    }
    
    var keyboardFrameEnd: CGRect {
        if let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            return value.cgRectValue
        } else {
            return CGRect.zero
        }
    }
    
    var animationDuration: Double {
        if let value = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
            return value.doubleValue
        } else {
            return 0.25
        }
    }
    
    var animationCurve: UIViewAnimationOptions {
        if let value = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber {
            let intValue = value.intValue
            return UIViewAnimationOptions(rawValue: UInt(intValue << 16))
        } else {
            let defaultCurve = UIViewAnimationCurve.easeInOut.rawValue
            return UIViewAnimationOptions(rawValue: UInt(defaultCurve << 16))
        }
    }
    
    var keyboardStartHeight: CGFloat {
        return keyboardFrameStart.height
    }
    
    var keyboardEndHeight: CGFloat {
        return keyboardFrameEnd.height
    }
    
    var keyboardHeightDelta: CGFloat {
        return keyboardEndHeight - keyboardStartHeight
    }
    
    var keyboardHeightChanged: Bool {
        return keyboardEndHeight != keyboardStartHeight
    }
    
    //Start frame of the keyboard in coordinates of specified view
    // :param: view UIView to whose coordinate system the frame will be converted
    // :returns: frame rectangle in view's coordinate system
    func frameStartFor(view: UIView) -> CGRect {
        return view.convert(keyboardFrameStart, from: view)
    }
    
    //End Frame of the keyboard in the coordinates of the specified view
    // :param: view UIView to whose coordinates system the frame will be converted
    // :returns: frame rectangle in view's coordinate system
    func frameEndFor(view: UIView) -> CGRect {
        return view.convert(keyboardFrameEnd, from: view)
    }
}
