//
//  ViewController.swift
//  JSONtodo
//
//  Created by YoungJoon Kim on 2/11/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    
    var todoArray: [TodoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTodo()
    }

    func fetchTodo() {
        NetMan.sharedInstance.fetchData(urlString: "https://jsonplaceholder.typicode.com/todos") {
            [ weak self ]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let todo):
                print("todoCount", todo.count)
                self.todoArray = todo.filter({ $0.completed == true })
                print("filteredCount", self.todoArray.count)
                DispatchQueue.main.async {
                    self.todoTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell else { return UITableViewCell() }
        let todo = todoArray[indexPath.row]
        cell.taskLabel.text = todo.title ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoArray.count
    }
}

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    
}
