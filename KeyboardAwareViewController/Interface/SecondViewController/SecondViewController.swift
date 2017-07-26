//
//  SecondViewController.swift
//  KeyboardAwareViewController
//
//  Created by James Pang on 25/12/16.
//  Copyright © 2016 James Pang. All rights reserved.
//

import UIKit

class SecondViewController: KeyboardViewController {

    var textField: UITextField!
    
    init() {
        super.init(nibName: "KeyboardViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStackViews()
        setupDummyViews()
    }
}

//MARK: - Set up
private extension SecondViewController {
    func configureStackViews() {
        contentStackView.spacing = 20
        topStackView.spacing = 10
        bottomStackView.spacing = 10
    }
    
    func setupDummyViews() {
        for index in 0..<4 {
            let label = UILabel()
            label.backgroundColor = .pastelRed
            label.text = "UILabel #: \(index)"
            
            let textField1 = UITextField()
            textField1.backgroundColor = .pastelGreen
            textField1.placeholder = "UITextField #: \(index)"
            textField1.borderStyle = .roundedRect
            
            contentStackView.addArrangedSubview(label)
            contentStackView.addArrangedSubview(textField1)
        }
        
        for index in 0..<3 {
            let label = UILabel()
            label.backgroundColor = index % 2 == 0 ? .pastelBlue : .pastelYellow
            label.text = "UILabel #: \(index) pinned to top of page"
            topStackView.addArrangedSubview(label)
        }
        
        for index in 0..<1 {
            let label = UILabel()
            label.backgroundColor = index % 2 == 0 ? .pastelOrange : .pastelRed
            label.text = "UILabel #: \(index) bottom of page"
            bottomStackView.addArrangedSubview(label)
        }
        
        textField = UITextField()
        textField.backgroundColor = .pastelGreen
        textField.placeholder = "Outside UITextField"
        textField.borderStyle = .roundedRect
        bottomStackView.addArrangedSubview(textField)
    }
}
