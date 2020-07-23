//
//  BreadsParser.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

struct BreadsResponse : Codable {
    let message: [String: [String]]

    enum CodingKeys: String, CodingKey {
        case message
    }
}


class BreadsParser: IParser {
    
    typealias Model = [String: [String]]
    
    func parse(data: Data) -> [String: [String]]? {
        let breadsResponse = try? JSONDecoder().decode(BreadsResponse.self, from: data)
        let breads = breadsResponse?.message
    
        return breads
    }
    
}
