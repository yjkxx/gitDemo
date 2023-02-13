//
//  NetworkManager.swift
//  JSONSingleUserDate
//
//  Created by YoungJoon Kim on 2/11/23.
//

import Foundation

class NetMan {
    
    static let sharedInstance = NetMan()
    
    private init() {}
    
    func fetchData(urlString: String, completion: @escaping(Result<UserModel, Error>) -> Void ) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let errorReceived = error {
                completion(.failure(errorReceived))
            } else {
                guard let receivedData = data else { return }
                do {
                    let receivedModel = try
                    JSONDecoder().decode(UserModel.self, from: receivedData)
                    completion(.success(receivedModel))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
