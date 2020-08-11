 //
 //  TaskListViewController.swift
 //  ToDoApp
 //
 //  Created by Michael Tseitlin on 05.08.2020.
 //  Copyright © 2020 Michael Tseitlin. All rights reserved.
 //
 
 import UIKit
 
 protocol TaskListDelegate: class {
    func reloadTableView()
 }
 
 class TaskListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: DataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let taskManager = TaskManager()
        dataProvider.taskManager = taskManager
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetailsWithNotification), name: NSNotification.Name("DidSelectRow notification"), object: nil)
    }
    
    @objc func showDetailsWithNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let task = userInfo["task"] as? Task,
           let detailViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {
            fatalError()
        }
        
        detailViewController.task = task
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            vc.delegate = self
            vc.taskManager = self.dataProvider.taskManager
            present(vc, animated: true, completion: nil)
        }
    }
 }
 
 extension TaskListViewController: TaskListDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
 }
 
