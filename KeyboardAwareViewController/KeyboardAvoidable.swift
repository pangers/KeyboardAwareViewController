//
//  KeyboardAvoidable.swift
//  KeyboardAwareViewController
//
//  Created by James Pang on 25/12/16.
//  Copyright © 2016 James Pang. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardAvoidable: class {
    var keyboardOpen: Bool { get set }
    func keyboardFinishedAppearing()
    func keyboardFinishedDisappearing()
}

//MARK: - Public
extension KeyboardAvoidable where Self: UIViewController {
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil, using: {
            [weak self] notification in
            //Had to use block because protocols don't understand selectors
            //Therefore whoever conforms to `KeyboardAvoidable` needs to call `removeKeyboardNotifications` in deinit
            self?.keyboardWillAppear(notification)
        })
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil, using: {
            [weak self] notification in
            //Had to use block because protocols don't understand selectors
            //Therefore whoever conforms to `KeyboardAvoidable` needs to call `removeKeyboardNotifications` in deinit
            self?.keyboardWillDisappear(notification)
        })
    }
    
    //Need to call this in deinit of ViewController
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - Private
fileprivate extension KeyboardAvoidable where Self: UIViewController {
    func keyboardWillAppear(_ notification: Notification) {
        let keyboardInfo = KeyboardNotification(notification)
        let duration = keyboardInfo.animationDuration
        let curve = keyboardInfo.animationCurve
        let keyboardEndFrame = keyboardInfo.keyboardFrameEnd
        //This check needs to be done because keyboardWillAppear could get called twice in a row
        //Eg. If you focus on a UITextField, then focus on another UITextField without dismissing the Keyboard
        //We only need to adjust the view frame on the first time
        if !keyboardOpen && !keyboardInfo.keyboardHeightChanged {
            //This means the keyboard is appearing from disappeared state
            view.frame.size.height -= keyboardEndFrame.height
            animate(with: duration, and: curve, keyboardOpened: true)
        } else if keyboardOpen && keyboardInfo.keyboardHeightChanged {
            //This means something about the keyboard change
            //Eg. Word suggestions hidden/show
            view.frame.size.height += -keyboardInfo.keyboardHeightDelta
            animate(with: duration, and: curve, keyboardOpened: true)
        }
    }
    
    func keyboardWillDisappear(_ notification: Notification) {
        let keyboardInfo = KeyboardNotification(notification)
        let duration = keyboardInfo.animationDuration
        let curve = keyboardInfo.animationCurve
        let keyboardStartFrame = keyboardInfo.keyboardFrameStart
        if keyboardOpen {
            view.frame.size.height += keyboardStartFrame.height
            animate(with: duration, and: curve, keyboardOpened: false)
        }
    }
    
    func animate(with duration: TimeInterval, and options: UIViewAnimationOptions, keyboardOpened: Bool) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: options,
                       animations: { self.view.layoutIfNeeded() },
                       completion: {
                        completed in
                        self.keyboardOpen = keyboardOpened
                        if keyboardOpened {
                            self.keyboardFinishedAppearing()
                        } else {
                            self.keyboardFinishedDisappearing()
                        }
        })
    }
}
