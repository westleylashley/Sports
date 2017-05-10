//
//  SportsAPI.swift
//  sports
//
//  Created by Westley Lashley on 3/20/17.
//  Copyright © 2017 Westley Lashley. All rights reserved.
//

import UIKit

class SportsAPI {
    let title: String
    let description: String?
    let url: String?
    var urlToImage: String
    var publishedAt: String
    var imageDownload: UIImage?
    var source: String?
    
    init(title: String, description: String?, url: String?, urlToImage: String, publishedAt: String, imageDownload: UIImage?, source: String?) {
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.imageDownload = imageDownload
        self.source = source
    }
    
    func downloadImage(completion: @escaping (UIImage) -> Void) {
        guard imageDownload == nil else { completion(imageDownload!); return }
        
        guard let url = URL(string: urlToImage) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                return
            }
            if let image = UIImage(data: data) {
                completion(image)
                self.imageDownload = image
            }
        }
        task.resume()
    }
    
    static func create(from dictionary: [String: Any]) -> SportsAPI? {
        
        // Title
        guard let title = dictionary["title"] as? String else {
            return nil
        }
        // Description
        guard let description = dictionary["description"] as? String else {
            return nil
        }
        // URL
        guard let url = dictionary["url"] as? String else {
            return nil
        }
        // Image
        guard let urlToImage = dictionary["urlToImage"] as? String else {
            return nil
        }
        
        // Published At
        guard let publishedAt = dictionary["publishedAt"] as? String else {
            return nil
        }
        // Image Download
        guard let imageDownload = dictionary["imageDownload"] as? UIImage? else {
            return nil
        }
        // Source
        guard let source = dictionary["source"] as? String? else {
            return nil
        }
        

        return SportsAPI(title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt, imageDownload: imageDownload, source: source)
    }
}
