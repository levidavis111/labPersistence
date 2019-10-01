//
//  PhotoAPIClient.swift
//  lab-persistence-lab
//
//  Created by Levi Davis on 9/30/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct PhotoAPIClient {
    
    static let manager = PhotoAPIClient()
    
    func getPhotos(completionHandler: @escaping (Result<[Photo], AppError>) -> () ) {
        NetworkManager.manager.performDataTask(withUrl: photoURL, httpMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    let photoInfo = try Photo.getPhotosFromData(from: data)
                    completionHandler(.success(photoInfo.hits))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    
    
    private var photoURL: URL {
        guard let url = URL(string: "https://pixabay.com/api/?key=13796567-93c506fb8bd4cf19f84df1521&q=dog") else {fatalError("Error: Invalid URL")}
        return url
    }
    
    private init() {}
  
}


//struct ElementAPIClient {
//
//    // MARK: - Static Properties
//
//    static let manager = ElementAPIClient()
//
//    // MARK: - Instance Methods
//
//    static func getElementLargeImageURLString(from name: String) -> String {
//        return "http://images-of-elements.com/\(name.lowercased()).jpg"
//    }
//
//    func getElements(completionHandler: @escaping (Result<[Element], AppError>) -> ())  {
//        NetworkHelper.manager.performDataTask(withUrl: elementURL, andMethod: .get) { (results) in
//            switch results {
//            case .failure(let error):
//                completionHandler(.failure(error))
//            case .success(let data):
//                do {
//                    let elementInfo = try Element.decodeElementsFromData(from: data)
//                    completionHandler(.success(elementInfo))
//                }
//                catch {
//                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
//                }
//
//            }
//        }
//    }
//
//
//    // MARK: - Private Properties and Initializers
//    private var elementURL: URL {
//        guard let url = URL(string: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements") else {
//            fatalError("Error: Invalid URL")
//        }
//        return url
//    }
//
//    private init() {}
//}
