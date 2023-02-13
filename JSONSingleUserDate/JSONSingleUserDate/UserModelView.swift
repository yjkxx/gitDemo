//
//  UserModelView.swift
//  JSONSingleUserDate
//
//  Created by YoungJoon Kim on 2/11/23.
//

import Foundation

class UserViewModel {
    
    var user: UserModel = UserModel()
    
    func fetchUserData(completion: @escaping() -> Void) {
        NetMan.sharedInstance.fetchData(urlString: "https://swapi.py4e.com/api/people/1") {
            [ weak self ]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.user = user
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
