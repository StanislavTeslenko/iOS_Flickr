//
//  NetworkManager.swift
//  iOS_Flickr
//
//  Created by Stanislav Teslenko on 13.12.2019.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import Foundation
import Alamofire

//https://www.flickr.com/services/rest/?method=flickr.cameras.getBrandModels&api_key=91d7d815196033ab702f81c91a56aa5d&brand=sony&format=json&nojsoncallback=1

private let baseUrl = "https://www.flickr.com/services/rest/"

class NetworkManager {
    
    static func sendRequest(for brand: String, completion: @escaping (_ cameras: Cameras?) -> ()) {
        
        let parameters = [
            "method" : "flickr.cameras.getBrandModels",
            "api_key" : "91d7d815196033ab702f81c91a56aa5d",
            "brand" : brand,
            "format" : "json",
            "nojsoncallback" : "1"
        ]
        
        guard let url = URL(string: baseUrl)?.withQueries(parameters) else {
                        print (#line, #function, "Error creating URL from \(baseUrl) with \(parameters)")
                        return}
        
        AF.request(url).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .failure(let error):
                print(#line, #function, error)
                
            case .success(let json):
                
                guard let cameras = Cameras(json: json) else {
                    completion (nil)
                    return
                }
                
                completion (cameras)
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
    
    
}
