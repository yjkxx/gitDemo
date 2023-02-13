//
//  ViewController.swift
//  JSONSingleUserDate
//
//  Created by YoungJoon Kim on 2/11/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    var user = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
    }
    
    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        var inputDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: inputDate ?? Date())
        
    }

    func fetchUser() {
        NetMan.sharedInstance.fetchData(urlString: "https://swapi.py4e.com/api/people/1") {
            [ weak self ]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
                self.user = user
                DispatchQueue.main.async {
                    self.nameLabel.text = user.name ?? ""
                    self.heightLabel.text = user.height ?? ""
                    self.createdLabel.text = self.formatDate(date: user.created ?? "")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

