//
//  VideoModelView.swift
//  JSONCodingKeys
//
//  Created by YoungJoon Kim on 2/11/23.
//

import Foundation

class VideoViewModel {
    
    var videoArray: [VideoModel] = []
    
    func fetchTodoData(completion: @escaping() -> Void) {
        NetMan.sharedInstance.fetchData(urlString: "https://gist.githubusercontent.com/dbackeus/484315/raw/dfeb530f9619bb74af5d537280a0b3b305410d01/videos.json") {
            [ weak self ]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let video):
                self.videoArray = video
                completion()
            case .failure(let error):
                print(String(describing: error))
                print(error.localizedDescription)
            }
        }
    }
    
}
