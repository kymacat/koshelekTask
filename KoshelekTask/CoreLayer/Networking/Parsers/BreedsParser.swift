//
//  BreadsParser.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

struct BreedsResponse : Codable {
    let message: [String: [String]]

    enum CodingKeys: String, CodingKey {
        case message
    }
}


class BreedsParser: IParser {
    
    typealias Model = [String: [String]]
    
    func parse(data: Data) -> [String: [String]]? {
        let breedsResponse = try? JSONDecoder().decode(BreedsResponse.self, from: data)
        let breeds = breedsResponse?.message
    
        return breeds
    }
    
}
