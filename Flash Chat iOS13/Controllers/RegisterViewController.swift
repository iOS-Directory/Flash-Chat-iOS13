//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

// 1. Impoprting the firebase module
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        // 2. Trigger the auth method when IBAction is trigger
        //Here are are unwrapping the optionals with the if let
        //in a chain using a coma "," to separate both
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            
            //FireBare code
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                //My logic
                if let e = error {
                    //localizedDescription is automatically translating the error to the lenguage in which the iphone is set, also we can create a label to display error for the user
                    print(e.localizedDescription)
                }else{
                    //If there are no errors we will redirect user to the chat
                    //Here we paste the name indentifier of the sague from the register to the chat
                    //inside the performSegue() method
                    //Instead of using the identifier as string we use a constant
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    
                }
                //End of My logic
            }
            //END of FireBare code
        }
    }
}
