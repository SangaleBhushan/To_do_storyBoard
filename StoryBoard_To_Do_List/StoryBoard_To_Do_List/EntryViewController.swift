//
//  EntryViewController.swift
//  StoryBoard_To_Do_List
//
//  Created by Siddhatech on 06/09/24.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var field :UITextField!
    
    var update: (() ->  Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        field.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    @objc func saveTask(){
        
        guard let text = field.text, !text.isEmpty  else{
            
            return
        }
        let count = UserDefaults().value(forKey: "count") as? Int
        
        let newCount = (count ?? 0) + 1
        UserDefaults().setValue(newCount, forKey: "count")
        UserDefaults().setValue(text, forKey: "taks_\(newCount)")
        
        update?()
        navigationController?.popViewController(animated: true)
    }
}
