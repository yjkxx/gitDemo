//
//  PhotoModelView.swift
//  JSONPhotos
//
//  Created by YoungJoon Kim on 2/11/23.
//

import Foundation
class TodoViewModel {
    
    var photoArray: [PhotoModel] = []
    
    func fetchTodoData(completion: @escaping() -> Void) {
        NetMan.sharedInstance.fetchData(urlString: "https://jsonplaceholder.typicode.com/photos") {
            [ weak self ]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let photo):
                self.photoArray = photo
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
