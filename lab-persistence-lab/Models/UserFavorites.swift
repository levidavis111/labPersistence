//
//  UserFavorites.swift
//  lab-persistence-lab
//
//  Created by Levi Davis on 9/30/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

class UserFavorite {
    static var usersFavorites = [Photo]()
    
    static func addPhotoToUserList(photo: Photo)  -> [Photo] {
        usersFavorites.append(photo)
        return usersFavorites
    }
    
    
}
