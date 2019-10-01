//
//  PhotoPersistencHelper.swift
//  lab-persistence-lab
//
//  Created by Levi Davis on 9/30/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct PhotoPersistenceHelper {
    static let manager = PhotoPersistenceHelper()
    
    func save(newPhoto: Photo) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }
    
    func getPhotos() throws -> [Photo] {
        return try persistenceHelper.getObjects()
    }
    
    private let persistenceHelper = PersistenceHelper<Photo>(fileName: "photos.plist")
    private init() {}
}


//struct SlothPersistenceHelper {
//    static let manager = SlothPersistenceHelper()
//
//    func save(newSloth: Sloth) throws {
//        try persistenceHelper.save(newElement: newSloth)
//    }
//
//    func getSloths() throws -> [Sloth] {
//        return try persistenceHelper.getObjects()
//    }
//
//    private let persistenceHelper = PersistenceHelper<Sloth>(fileName: "sloths.plist")
//
//    private init() {}
//}
