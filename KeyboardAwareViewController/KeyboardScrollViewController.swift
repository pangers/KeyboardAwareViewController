//
//  KeyboardScrollViewController.swift
//  KeyboardAwareViewController
//
//  Created by James Pang on 25/12/16.
//  Copyright © 2016 James Pang. All rights reserved.
//

import UIKit

class KeyboardScrollViewController: UIViewController {

    var keyboardOpen = false
    
    @IBOutlet weak var contentStackView: UIStackView! {
        didSet {
            contentStackView.spacing = 20
        }
    }
    @IBOutlet weak var pinnedStackView: UIStackView! {
        didSet {
            pinnedStackView.spacing = 10
        }
    }
    @IBOutlet weak var outerStackView: UIStackView! {
        didSet {
            outerStackView.spacing = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardNotifications()
        setupBackgroundTap()
        setupDummyViews()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
}

//MARK: - KeyboardAvoidable
extension KeyboardScrollViewController: KeyboardAvoidable {
    func keyboardFinishedAppearing() {
        
    }
    
    func keyboardFinishedDisappearing() {
        
    }
}

//MARK: - Public
extension KeyboardScrollViewController {
    func backgroundTapped() {
        view.endEditing(false)
    }
}

//MARK: - Set up
fileprivate extension KeyboardScrollViewController {
    func setupBackgroundTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        view.addGestureRecognizer(tap)
    }
    
    func setupDummyViews() {
        for index in 0..<3 {
            let label = UILabel()
            label.backgroundColor = .pastelRed
            label.text = "UILabel #: \(index)"
            
            let textField = UITextField()
            textField.backgroundColor = .pastelGreen
            textField.placeholder = "UITextField #: \(index)"
            textField.borderStyle = .roundedRect
            
            contentStackView.addArrangedSubview(label)
            contentStackView.addArrangedSubview(textField)
        }
        
        for index in 0..<3 {
            let label = UILabel()
            label.backgroundColor = index % 2 == 0 ? .pastelBlue : .pastelYellow
            label.text = "UILabel #: \(index) pinned to bottom of scrollView"
            pinnedStackView.addArrangedSubview(label)
        }
        
        for index in 0..<2 {
            let label = UILabel()
            label.backgroundColor = index % 2 == 0 ? .pastelOrange : .pastelRed
            label.text = "UILabel #: \(index) outside the scrollView"
            outerStackView.addArrangedSubview(label)
        }
    }
}

