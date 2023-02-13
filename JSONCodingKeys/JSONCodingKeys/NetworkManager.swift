//
//  NetworkManager.swift
//  JSONCodingKeys
//
//  Created by YoungJoon Kim on 2/11/23.
//

import Foundation

class NetMan {
    
    static let sharedInstance = NetMan()
    
    private init() {}
    
    func fetchData(urlString: String, completion: @escaping(Result<[VideoModel], Error>) -> Void ) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let errorReceived = error {
                completion(.failure(errorReceived))
            } else {
                guard let receivedData = data else { return }
                do {
                    let receivedModel = try
                    JSONDecoder().decode([VideoModel].self, from: receivedData)
                    completion(.success(receivedModel))
                } catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
