//
//  Photo.swift
//  lab-persistence-lab
//
//  Created by Levi Davis on 9/30/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct PhotoWrapper: Codable {

    let hits: [Photo]
    
}

struct Photo: Codable {
    let user: String
    let webformatURL: String
    let previewURL: String

    
    static func getPhotosFromData(from jsonData: Data) throws -> PhotoWrapper {
        let response = try JSONDecoder().decode(PhotoWrapper.self, from: jsonData)
        return response
    }

}


//{
//    "totalHits": 500,
//    "hits": [
//    {
//    "largeImageURL": "https://pixabay.com/get/52e4d4464c56a514f6da8c7dda79367d1236d8e055566c48702972dc9144cd59bc_1280.jpg",
//    "webformatHeight": 423,
//    "webformatWidth": 640,
//    "likes": 268,
//    "imageWidth": 5130,
//    "id": 4415649,
//    "user_id": 8934889,
//    "views": 64091,
//    "comments": 47,
//    "pageURL": "https://pixabay.com/photos/pets-dog-corgi-cute-4415649/",
//    "imageHeight": 3396,
//    "webformatURL": "https://pixabay.com/get/52e4d4464c56a514f6da8c7dda79367d1236d8e055566c48702972dc9144cd59bc_640.jpg",
//    "type": "photo",
//    "previewHeight": 99,
//    "tags": "pets, dog, corgi",
//    "downloads": 35867,
//    "user": "huoadg5888",
//    "favorites": 215,
//    "imageSize": 3129143,
//    "previewWidth": 150,
//    "userImageURL": "",
//    "previewURL": "https://cdn.pixabay.com/photo/2019/08/19/07/45/pets-4415649_150.jpg"
//}
