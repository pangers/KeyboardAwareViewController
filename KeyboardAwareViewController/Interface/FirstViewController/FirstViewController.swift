//
//  FirstViewController.swift
//  KeyboardAwareViewController
//
//  Created by James Pang on 25/12/16.
//  Copyright © 2016 James Pang. All rights reserved.
//

import UIKit

class FirstViewController: KeyboardScrollViewController {
    
    var textField: UITextField!
    
    init() {
        super.init(nibName: "KeyboardScrollViewController", bundle: nil)
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

//MARK: - Public
extension FirstViewController {
    func pushNextScreen() {
        runAfterKeyboardClosedIfNeed { [weak self] in
            let vc = SecondViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Set up
private extension FirstViewController {
    func configureStackViews() {
        contentStackView.spacing = 20
        pinnedStackView.spacing = 10
        outerStackView.spacing = 10
    }
    
    func setupDummyViews() {
        for index in 0..<3 {
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
            label.text = "UILabel #: \(index) pinned to bottom of scrollView"
            pinnedStackView.addArrangedSubview(label)
        }
        
        for index in 0..<1 {
            let label = UILabel()
            label.backgroundColor = index % 2 == 0 ? .pastelOrange : .pastelRed
            label.text = "UILabel #: \(index) outside the scrollView"
            outerStackView.addArrangedSubview(label)
        }
        
        let button = UIButton(type: .system)
        button.setTitle("Push next screen", for: .normal)
        button.addTarget(self, action: #selector(pushNextScreen), for: .touchUpInside)
        outerStackView.addArrangedSubview(button)
        
        textField = UITextField()
        textField.backgroundColor = .pastelGreen
        textField.placeholder = "Outside UITextField"
        textField.borderStyle = .roundedRect
        outerStackView.addArrangedSubview(textField)
    }
}
