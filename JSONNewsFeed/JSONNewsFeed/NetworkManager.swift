//
//  NetworkManager.swift
//  JSONNewsFeed
//
//  Created by YoungJoon Kim on 2/13/23.
//

import Foundation

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    private init() {
        
    }
    
    func fetchData(urlString: String, completion: @escaping(Result<NewsModel, Error>) -> Void ) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let errorReceived = error {
                completion(.failure(errorReceived))
            } else {
                guard let receivedData = data else { return }
                do {
                    let receivedModel = try JSONDecoder().decode(NewsModel.self, from: receivedData)
                    completion(.success(receivedModel))
                }
                catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
                //let receivedModel = try? JSONDecoder().decode([UserModel].self, from: receivedData)
            }
        }.resume()
    }
}
