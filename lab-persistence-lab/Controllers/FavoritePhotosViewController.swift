//
//  FavoritePhotosViewController.swift
//  lab-persistence-lab
//
//  Created by Levi Davis on 9/30/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class FavoritePhotosViewController: UIViewController {
    
    var photos = [Photo](){
        didSet {
            photoTableView.reloadData()
        }
    }

    @IBOutlet weak var photoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTableView.dataSource = self
        photoTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    private func loadData() {
        do {
            photos = try PhotoPersistenceHelper.manager.getPhotos()
        } catch {
            print(error)
        }
    }

}



extension FavoritePhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let oneFavorite = photos[indexPath.row]
       
        if let cell = photoTableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? PhotoTableViewCell {
            ImageManager.manager.getImage(urlStr: oneFavorite.previewURL) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.favoriteImageView.image = image
                      
                    }
                }
            }
              return cell
        }
        return UITableViewCell()
    }
}

extension FavoritePhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
