//
//  File.swift
//  To Do List
//
//  Created by IMCS2 on 8/1/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class File:UIViewController  {
    
    @IBOutlet weak var textField: UITextField!
        var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let todo: String = textField.text!

        ref = Database.database().reference().child("Student")
        ref.childByAutoId().child("names").setValue(todo)
        
    }
}
