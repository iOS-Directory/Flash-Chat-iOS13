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
    
    //Initializing Firestore
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2.Set as delegate for the tableView
        tableView.dataSource = self
        
        //Hide back button since we want user to log out if
        //they want to go back to the welcome screen
        navigationItem.hidesBackButton = true
        
        //Also we can set a title
        title = K.appName
        
        // 1.Register custom design file
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        //Method to load messages from DB
        loadMessages()
    }
    
    //Func to get the data from firestore and call it inside the viewDidLoad
    func loadMessages() {
        
        //Tap into the DB
        //For one time update use getDocuments
        //for actively listen for changes to re-run code use addSnapshotListener
        //TO sort the data before the listener we chain a "order" func
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                
                //to stater with an empty array after reload to prevent duplicates
                self.messages = []
                
                if let e = error {
                    print("There was an issue retrieving data \(e)")
                }else{
                    
                    //array of documents
                    if let snapshotDocuments = querySnapshot?.documents {
                        //Loop through the array
                        for doc in snapshotDocuments{
                            //print(doc.data())
                            let data = doc.data()
                            //Unwraping options
                            //Since the data key takes a value with "any" as
                            //data type we must downcast it to a String with as? String
                            if let messageSender = data[K.FStore.senderField]  as? String, let messageBody = data[K.FStore.bodyField]  as? String{
                                
                                //now we create a new instance of Message class
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                
                                //Now append it to the messages array
                                self.messages.append(newMessage)
                                
                                //Since this is a HTTP call we want to use asyc before reloading UI
                                DispatchQueue.main.async {
                                    //This re-run the two methods in the UITableViewDataSource protocol
                                    self.tableView.reloadData()
                                    
                                    //Make the take scroll the the most recent message when the keyboard appears
                                    //Here we specified what row to scroll to and since is an array starts at 0 so we substract 1
                                    //the section is zero because we only have one section
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    //Here we pass the indexPath to the "at" in the scrollToRow() method
                                    //position at the .top and the animation shows an scroll animation when the view loads
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                            
                        }
                    }
                }
        }
    }
    
    //Trigger when user press the send button
    @IBAction func sendPressed(_ sender: UIButton) {
        
        //Capture the message in the inputfield and user email
        //Both are optionals so we use a if let chain to unwrap
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            
            //db = the firestore instance
            //K.FStore.collectionName = messages in Constants file
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error{
                    print("There was an issue saving data \(e)")
                }else{
                    print("Succressfully saved data!: \(messageBody) from \(messageSender)")
                    
                    //Clear input field and because is inside a closure
                    //we must use DispatchQueue.main.async so the action
                    //happens in the foreground instead of the background
                    DispatchQueue.main.async {
                         self.messageTextfield.text = ""
                    }
                   
                }
            }
        }
        
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
    
    //Here we create a cell and return it to the table view, this gets call for every cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //select each message on the array base on the index
        let message = messages[indexPath.row]
        
        //implement the dequeueReusableCell method which will be call the same ammount of times as there are cells
        //pass our reusableCell identifier and the indexPath from above
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
            
            // 2.Set as! to use the custom design
            as! MessageCell
        
        // 3.Now instead of cell.textLabel?.text we can use the name
        //of the custom label in the custom design with name of "label"
        cell.label.text = message.body
        
        //Checks who sent the message if current user or other, for different rendering of UI bubble
        //Auth.auth().currentUser?.email comes from firebase auth
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }//If the message came from some one else
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        
        return cell
    }
}

