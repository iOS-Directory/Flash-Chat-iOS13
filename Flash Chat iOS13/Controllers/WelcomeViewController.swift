//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

//IMPORT THE CLTypingLabel LIBRARY
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
//    @IBOutlet weak var titleLabel: UILabel! INSTEAD WE UE THE CODE BELOW
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
        
    }
}
