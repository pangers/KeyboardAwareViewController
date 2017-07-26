//
//  KeyboardViewController.swift
//  KeyboardAwareViewController
//
//  Created by James Pang on 17/02/2017.
//  Copyright © 2017 James Pang. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController {

    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    var keyboardOpen = false
    
    fileprivate var onKeyboardFinishedAppearing: ((Void) -> Void)?
    fileprivate var onKeyboardFinishedDisappearing: ((Void) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardNotifications()
        setupBackgroundTap()
    }

}

//MARK: - KeyboardAvoidable
extension KeyboardViewController: KeyboardAvoidable {
    func keyboardFinishedAppearing() {
        onKeyboardFinishedAppearing?()
        onKeyboardFinishedAppearing = nil
    }
    
    func keyboardFinishedDisappearing() {
        onKeyboardFinishedDisappearing?()
        onKeyboardFinishedDisappearing = nil
    }
}

//MARK: - Public
extension KeyboardViewController {
    func backgroundTapped() {
        view.endEditing(false)
    }
    
    func runAfterKeyboardClosedIfNeed(completion: @escaping (Void) -> Void) {
        if keyboardOpen {
            view.endEditing(false)
            onKeyboardFinishedDisappearing = completion
        } else {
            completion()
        }
    }
    
    func runAfterKeyboardOpenedIfNeeded(for input: UIResponder, completion: @escaping (Void) -> Void) {
        if keyboardOpen {
            completion()
        } else {
            input.becomeFirstResponder()
            onKeyboardFinishedAppearing = completion
        }
    }
}

//MARK: - Set up
fileprivate extension KeyboardViewController {
    func setupBackgroundTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        view.addGestureRecognizer(tap)
    }
}


