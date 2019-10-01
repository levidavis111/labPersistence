//
//  PhotoViewController.swift
//  lab-persistence-lab
//
//  Created by Levi Davis on 9/30/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photos = [Photo]() {
        didSet {
            photoCollectionView.reloadData()
        }
    }
    let cellSpacing: CGFloat = 5.0
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PhotoDetailViewController {
            guard let indexPath = photoCollectionView.indexPath(for: sender as! UICollectionViewCell),
                let photoVC = segue.destination as? PhotoDetailViewController else {return}
            let photo = photos[indexPath.row]
            photoVC.photo = photo
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    private func loadData() {
        PhotoAPIClient.manager.getPhotos { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let photos):
                self.photos = photos
            }
        }
    }
    private func setupCollectionView() {
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        searchBarOutlet.delegate = self
    }
    
}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let onePhoto = photos[indexPath.row]
        if let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell {
            ImageManager.manager.getImage(urlStr: onePhoto.previewURL) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.photoImageView.image = image

                    }
                }
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 2
        let numSpaces: CGFloat = numCells + 1
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}

extension PhotoViewController: UISearchBarDelegate {}
