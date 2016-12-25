//
//  KeyboardScrollViewController.swift
//  KeyboardAwareViewController
//
//  Created by James Pang on 25/12/16.
//  Copyright © 2016 James Pang. All rights reserved.
//

import UIKit

//Reusable ViewController that handles keyboard management
//When subclassing this class, the subclass init method should call `super.init(nibName: "KeyboardScrollViewController", bundle: nil)`
class KeyboardScrollViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    //Anything you want inside the scrollView you put in `contentStackView`
    @IBOutlet weak var contentStackView: UIStackView!
    //Anything you want pinned to the bottom of the scrollView (inside the scrollView) put in `pinnedStackView`
    @IBOutlet weak var pinnedStackView: UIStackView!
    //Anything you want outside of the scrollView put in `outerStackView`
    @IBOutlet weak var outerStackView: UIStackView!
    
    var keyboardOpen = false
    
    fileprivate var onKeyboardFinishedAppearing: ((Void) -> Void)?
    fileprivate var onKeyboardFinishedDisappearing: ((Void) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardNotifications()
        setupBackgroundTap()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
}

//MARK: - KeyboardAvoidable
extension KeyboardScrollViewController: KeyboardAvoidable {
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
extension KeyboardScrollViewController {
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
fileprivate extension KeyboardScrollViewController {
    func setupBackgroundTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        view.addGestureRecognizer(tap)
    }
}
