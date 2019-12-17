//
//  BrandModel.swift
//  iOS_Flickr
//
//  Created by Stanislav Teslenko on 13.12.2019.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import Foundation

struct Cameras: Codable {
    
    let cameras: BrandModel?
    
    init?(json: Any?) {
        
        guard let json = json as? [String : Any?] else {return nil}
        
        let cameras =  BrandModel(json: json["cameras"] as Any?)
        
        self.cameras = cameras
    }
    
    
}

struct BrandModel: Codable {
    
    let brand: String?
    let camera: [Camera]?
    
    init?(json: Any?) {
        
        guard let json = json as? [String : Any?] else {return nil}
        
        let brand = json["brand"] as? String
        let camera = Camera.getArray(from: json["camera"] as Any?)
        
        self.brand = brand
        self.camera = camera
        
    }
    
}

struct Camera: Codable {
    
    let id: String?
    let name: String?
    let details: Details?
    let images: Images?
    
    init?(json: [String : Any]) {
        
        let id = json["id"] as? String
        let name = json["name"] as? [String : String]
        let details = Details(json: json["details"])
        let images = Images(json: json["images"])
        
        self.id = id
        self.name = name?["_content"]
        self.details = details
        self.images = images
    }
    
    
    static func getArray(from jsonArray: Any?) -> [Camera]? {
        
        guard let jsonArray = jsonArray as? Array<[String : Any]> else {return nil}
        
        var array: [Camera] = []
        
        for jsonObject in jsonArray {
            if let camera = Camera(json: jsonObject) {
                array.append(camera)
            }
        }
        return array
    }
    
    
}

struct Details: Codable {
    
    let megapixels: String?
    let screenSize: String?
    let memoryType: String?
    
    init?(json: Any?) {
        
        guard let json = json as? [String : Any] else {return nil}
        
        let megapixels = json["megapixels"] as? [String : String]
        let screenSize = json["lcd_screen_size"] as? [String : String]
        let memoryType = json["memory_type"] as? [String : String]
        
        self.megapixels = megapixels?["_content"]
        self.screenSize = screenSize?["_content"]
        self.memoryType = memoryType?["_content"]
    }
    
}

struct Images: Codable {
    
    let small: String?
    let large: String?
    
    init?(json: Any?) {
        
        guard let json = json as? [String : Any] else {return nil}
        
        let small = json["small"] as? [String : String]
        let large = json["large"] as? [String : String]
        
        self.small = small?["_content"]
        self.large = large?["_content"]
        
    }
    
}


