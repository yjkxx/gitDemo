//
//  ViewController.swift
//  JSONNewsFeed
//
//  Created by YoungJoon Kim on 2/13/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var newsArray: NewsModel = NewsModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchNews()
        
    }

    func fetchNews() {
        NetworkManager.sharedInstance.fetchData(urlString: "https://gist.githubusercontent.com/congsun/600f3ad57298f9dbc23fedf6b2b25450/raw/73d7a8ed589652339ae3646d0a595298ce5e72c2/newsFeed.json") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                self.newsArray = news
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
                print(news.articles?[0] ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArray.articles?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as? NewsTableViewCell else { return UITableViewCell() }
        cell.newsTitle.text = newsArray.articles?[indexPath.row].title ?? ""
        cell.newsAuthor.text = newsArray.articles?[indexPath.row].author ?? ""
        cell.newsSource.text = newsArray.articles?[indexPath.row].source?.name ?? ""
        cell.newsImageView.imageFrom(url: URL(string: newsArray.articles?[indexPath.row].urlToImage ?? "") ?? URL(fileURLWithPath: ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
}

extension UIImageView{
  func imageFrom(url:URL){
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url){
        if let image = UIImage(data:data){
          DispatchQueue.main.async{
            self?.image = image
          }
        }
      }
    }
  }
}
