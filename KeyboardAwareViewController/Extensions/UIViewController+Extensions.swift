//
//  UIViewController+Extensions.swift
//  KeyboardAwareViewController
//
//  Created by James Pang on 17/02/2017.
//  Copyright © 2017 James Pang. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /**
     Instantiates the view controller from a nib (assuming nib name is class name)
     */
    static func fromNib() -> Self {
        return internalFromNib(type: self)
    }
    
    private static func internalFromNib<T: UIViewController>(type: T.Type) -> T {
        let classname = NSStringFromClass(self).components(separatedBy: ".").last!
        return  T(nibName: classname, bundle: Bundle.main)
    }
}
