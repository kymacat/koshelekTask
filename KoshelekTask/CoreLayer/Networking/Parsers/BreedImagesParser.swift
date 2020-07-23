//
//  BreedImagesParser.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

struct BreedImagesResponse : Codable {
    let message: [String]

    enum CodingKeys: String, CodingKey {
        case message
    }
}


class BreedImagesParser: IParser {
    
    typealias Model = [String]
    
    func parse(data: Data) -> [String]? {
        
        let breedImagesResponse = try? JSONDecoder().decode(BreedImagesResponse.self, from: data)
        let images = breedImagesResponse?.message
    
        return images
    }
    
}
