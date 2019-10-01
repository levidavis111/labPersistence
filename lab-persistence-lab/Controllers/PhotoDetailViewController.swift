//
//  PhotoDetailViewController.swift
//  lab-persistence-lab
//
//  Created by Levi Davis on 9/30/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photo: Photo!

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
       
        DispatchQueue.global(qos: .utility).async {
            try? PhotoPersistenceHelper.manager.save(newPhoto: self.photo)
        }
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
//    let newSloth = Sloth(appendages: Int(appendagesStepper.value), speed: Int(appendagesStepper.value))
//    DispatchQueue.global(qos: .utility).async {
//    try? SlothPersistenceHelper.manager.save(newSloth: newSloth)
//    DispatchQueue.main.async {
//    self.navigationController?.popViewController(animated: true)
//    }
//    }
//}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
        // Do any additional setup after loading the view.
    }
    

    private func setupImage() {
        ImageManager.manager.getImage(urlStr: photo.webformatURL) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                     self.photoImageView.image = image
                }
               
            }
        }
    }

}
