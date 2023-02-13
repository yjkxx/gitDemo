//
//  ViewController.swift
//  JSONPhotos
//
//  Created by YoungJoon Kim on 2/11/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var PhotoCollectionView: UICollectionView!
    
    var photoArray: [PhotoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("fp")
        fetchPhoto()
    }

    func fetchPhoto() {
        NetMan.sharedInstance.fetchData(urlString: "https://jsonplaceholder.typicode.com/photos") {
            [ weak self ]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let photo):
                print(photo)
                self.photoArray = photo
                print(photo.count)
                DispatchQueue.main.async {
                    self.PhotoCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        let photo = photoArray[indexPath.row]
        print(photo.thumbnailUrl)
        cell.urlLabel.text = photo.thumbnailUrl
        cell.myPhoto.imageFrom(url: URL(string: photo.thumbnailUrl ?? "")!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoArray.count
    }
    
}

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var myPhoto: UIImageView!
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
