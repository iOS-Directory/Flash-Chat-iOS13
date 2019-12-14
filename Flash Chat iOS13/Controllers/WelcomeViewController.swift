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
    
    
    
    //The viewWillAppear will be trigger before the user see the screen
    //Hide the navigation bar in this view
    override func viewWillAppear(_ animated: Bool) {
        
        //as best pratice when overwriting a class we should call super some where inside
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    //Since we hide the nav, now when user goes to another screen it will remain hidden
    //So we must unhide when the user leaves this screen
    override func viewWillDisappear(_ animated: Bool) {
        
        //as best pratice when overwriting a class we should call super some where inside
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
