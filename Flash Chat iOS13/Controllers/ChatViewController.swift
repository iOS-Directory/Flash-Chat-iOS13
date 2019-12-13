//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

// 1. Import FireBase
import Firebase

class ChatViewController: UIViewController {
    
    // 1.Create IBOutlet for the tableView
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hello"),
        Message(sender: "ab@2.com", body: "Hey"),
        Message(sender: "1@2.com", body: "How are you?")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2.Set as delegate for the tableView
        tableView.dataSource = self
        
        //Hide back button since we want user to log out if
        //they want to go back to the welcome screen
        navigationItem.hidesBackButton = true
        
        //Also we can set a title
        title = K.appName
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        // 2.FireBase Log out Call
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            //Code to be executed if sign out successful
            
            //Since pages are like layers in top of each other
            //We want to remove all the pages on the top of the welcome
            //screen or root controller and to do this we have access to the
            //Following popViewController() method
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        //End of FireBase Log out Call
    }
}

// 3.Creating extension for the UITableView
extension ChatViewController: UITableViewDataSource {
    
    //Specify how many rows
    //You want a row per message so we better use the count property instead of hardcode it
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //count the ammount of messages in the array
        return messages.count
    }
    
    //Here we create a cell and return it to the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //implement the dequeueReusableCell method which will be call the same ammount of times as there are cells
        //pass our reusableCell identifier and the indexPath from above
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
}

