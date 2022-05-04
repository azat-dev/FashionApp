//
//  ImageLoader.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 04.05.22.
//

import Foundation
import UIKit

class ImageLoader {
    private let baseUrl: String
    private var session = URLSession(configuration: URLSessionConfiguration.default)
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    

    func load(url: String, completionHandler: @escaping (_ error: Error?, _ image: UIImage?) -> Void) {
        guard let imageUrl = URL(string: "\(baseUrl)\(url)") else {
            let wrongUrlError = NSError(domain: "WrongUrl", code: 0)
            completionHandler(wrongUrlError, nil)
            return
        }
                
        let dataTask = session.dataTask(with: imageUrl) {
            data, response, error in
            
            if let error = error {
                completionHandler(error, nil)
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let data = data
            else {
                
                let wrongResponseError = NSError(domain: "WrongResponse", code: 0)
                completionHandler(wrongResponseError, nil)
                return
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                
                guard let image = UIImage(data: data) else {
                    let wrongImageFormatError = NSError(domain: "WrongImageFormat", code: 0)
                    completionHandler(wrongImageFormatError, nil)
                    return
                }
                
                completionHandler(nil, image)
            }
        }
        
        dataTask.resume()
    }
}
