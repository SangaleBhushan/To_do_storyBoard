//
//  ViewController.swift
//  StoryBoard_To_Do_List
//
//  Created by Siddhatech on 06/09/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView:  UITableView!
    
   var tasks = [String]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTask()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        if  !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true,forKey: "setup")
            UserDefaults().set(0,forKey: "count")
        }
      
        updateTask()
       
        
     }
    func updateTask(){
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        for x in 0...count{
            if let task =  UserDefaults().value(forKey: "taks_\(x)") as? String {
                tasks.append(task)
            }
        }
        tableView.reloadData()
    }
    @IBAction func didTapAdd(){
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async  {
                self.updateTask()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "Task Details"
        vc.task = tasks[indexPath.row]
        vc.index = indexPath.row + 1
        navigationController?.pushViewController(vc, animated: true)
  
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int)-> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text  = tasks[indexPath.row]
        
        return cell
    }
}
