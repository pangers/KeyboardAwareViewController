//
//  PlainScrollViewController.swift
//  KeyboardAwareViewController
//
//  Created by James Pang on 25/12/16.
//  Copyright © 2016 James Pang. All rights reserved.
//

import UIKit

class PlainScrollViewController: UIViewController {

    @IBOutlet weak var contentStackView: UIStackView!
    
    var keyboardOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundTap()
        setupViews()
        setupKeyboardNotifications()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
}

//MARK: - KeyboardAvoidable
extension PlainScrollViewController: KeyboardAvoidable {
    func keyboardFinishedAppearing() {
        
    }
    
    func keyboardFinishedDisappearing() {
        
    }
}

//MARK: - Public
extension PlainScrollViewController {
    func backgroundTapped() {
        view.endEditing(false)
    }
}

//MARK: - Set up
fileprivate extension PlainScrollViewController {
    func setupBackgroundTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        view.addGestureRecognizer(tap)
    }
    
    func setupViews() {
        for index in 0..<20 {
            let label = UILabel()
            label.backgroundColor = .pastelRed
            label.text = "UILabel #: \(index)"
            
            let textField = UITextField()
            textField.backgroundColor = .pastelGreen
            textField.placeholder = "UITextField #: \(index)"
            textField.borderStyle = .roundedRect
            textField.autocorrectionType = .default
            contentStackView.addArrangedSubview(label)
            contentStackView.addArrangedSubview(textField)
        }
    }
}

