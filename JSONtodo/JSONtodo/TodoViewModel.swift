//
//  TodoViewModel.swift
//  JSONtodo
//
//  Created by YoungJoon Kim on 2/11/23.
//

import Foundation

class TodoViewModel {
    
    var todoArray: [TodoModel] = []
    
    func fetchTodoData(completion: @escaping() -> Void) {
        NetMan.sharedInstance.fetchData(urlString: "https://jsonplaceholder.typicode.com/todos") {
            [ weak self ]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let todo):
                self.todoArray = todo
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
