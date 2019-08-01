//
//  ViewController.swift
//  To Do List
//
//  Created by IMCS2 on 7/30/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
var sendingValue = [String]()
var Valueas = [String]()


class ViewController: UITableViewController{
    var ref: DatabaseReference!
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sendingValue.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let  todo: String = sendingValue[indexPath.row]
        print(sendingValue)
        cell.textLabel?.text = todo
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromFirebase()
    }
    
    func fetchDataFromFirebase(){
        //accessing values
        ref = Database.database().reference().child("Student")
        // ref.child("names")
        ref.observe(.value){(snapshot: DataSnapshot) in
            for nameValue in snapshot.children{
                let snapshotContent = nameValue as? DataSnapshot
                let namedata = snapshotContent?.value as? NSDictionary
                sendingValue = [namedata?["names"] as! String]
                
                
                // print(namedata?["names"] as? String)
            }
            tableView.reloadData()
            
        }
        
        
        
        
    }
    
}




