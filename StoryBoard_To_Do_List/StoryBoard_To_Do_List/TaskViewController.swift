//
//  TaskViewController.swift
//  StoryBoard_To_Do_List
//
//  Created by Siddhatech on 06/09/24.
//

import UIKit

class TaskViewController: UIViewController {
    @IBOutlet var label : UILabel!
    @IBOutlet var buttonDelete : UIButton!
    var task: String?
    var index: Int?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text =  task
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete Task", style: .done, target: self, action: #selector(deleteTask))
    }
    @IBAction func didTapbuttonDelete(){
        guard let index = index else{
            return
        }
        guard let count = UserDefaults().value(forKey: "count") as? Int, count > 0 else {
            return
        }
        for x in index...count{
            UserDefaults().removeObject(forKey: "taks_\(x)")
        }
        navigationController?.popViewController(animated: true)
    }
    @objc func deleteTask() {
        guard let index = index else {
            return
        }

        // Get the current count of tasks
        guard let count = UserDefaults().value(forKey: "count") as? Int, count > 0 else {
            return
        }

        // Remove the task from UserDefaults
        UserDefaults().removeObject(forKey: "taks_\(index)")

        // If there is more than one task, shift the remaining tasks
        if index < count - 1 {
            for x in index...(count - 1) {
                if let task = UserDefaults().value(forKey: "taks_\(x + 1)") as? String {
                    UserDefaults().set(task, forKey: "taks_\(x)")
                } else {
                    UserDefaults().removeObject(forKey: "taks_\(x)")
                }
            }
        }

        // Update the count
        UserDefaults().set(count - 1, forKey: "count")

        // Notify the previous controller and pop this view controller
        navigationController?.popViewController(animated: true)
    }

}
