//
//  APIManager.swift
//  sports
//
//  Created by Westley Lashley on 3/20/17.
//  Copyright © 2017 Westley Lashley. All rights reserved.
//

import Foundation

// Sports API
class SportsAPIManager {
    
    func SportsSearchAPI(source: String, completion: @escaping ([SportsAPI]) -> Void) {
        let baseUrlString = "https://newsapi.org/v1/articles?source=\(source)&sortBy=top&apiKey=bd8e9542ee8c4ae5b1ef99e7dadd766f"
        guard let url = URL(string: baseUrlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                print(json)
                guard let items = json["articles"] as? [[String: Any]] else {
                    return
                }
                
                var nfl = [SportsAPI]()
                for item in items {
                    if let sports = SportsAPI.create(from: item) {
                        nfl.append(sports)
                    }
                }
                completion(nfl)
            } catch {
                print("Uh oh. You have an error with \(source)!")
            }
        }
        task.resume()
    }
}
