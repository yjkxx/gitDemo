//
//  NewsModelView.swift
//  JSONNewsFeed
//
//  Created by YoungJoon Kim on 2/13/23.
//

import Foundation
class NewsViewModel {
    var newsArray: NewsModel = NewsModel()
    
    func fetchUsersData(completion :@escaping () -> Void) {
        
        NetworkManager.sharedInstance.fetchData(urlString: "https://gist.githubusercontent.com/congsun/600f3ad57298f9dbc23fedf6b2b25450/raw/73d7a8ed589652339ae3646d0a595298ce5e72c2/newsFeed.json") {  [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                self.newsArray = news
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
