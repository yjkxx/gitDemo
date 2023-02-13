//
//  ViewController.swift
//  JSONCodingKeys
//
//  Created by YoungJoon Kim on 2/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var screenshotImgView: UIImageView!
    @IBOutlet weak var transcodingIdLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var myVideo: [VideoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("yee")
        fetchVideo()
    }

    func fetchVideo() {
        NetMan.sharedInstance.fetchData(urlString: "https://gist.githubusercontent.com/dbackeus/484315/raw/dfeb530f9619bb74af5d537280a0b3b305410d01/videos.json") {
            [ weak self ]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let video):
                self.myVideo = video
                DispatchQueue.main.async {
                    self.screenshotImgView.imageFrom(url: URL(string: video[0].screenshot?.normal ?? "")!)
                    print("imgUrl =", video[0].screenshot?.normal ?? "")
                    self.transcodingIdLabel.text = "transcoding[0].id = \(video[0].transcodings?[0].id ?? "")"
                    self.heightLabel.text = "transcoding[0].height = \(String(video[0].transcodings?[0].height ?? 0))"
                    self.widthLabel.text = "transcoding[0].width = \(String(video[0].transcodings?[0].width ?? 0))"
                    self.titleLabel.text = "title = \(video[0].title ?? "")"
                }
            case .failure(let error):
                print(String(describing: error))
                print(error.localizedDescription)
            }
        }
    }
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
