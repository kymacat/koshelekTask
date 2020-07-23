//
//  RequestFactory.swift
//  KoshelekTask
//
//  Created by Const. on 23.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

struct RequestsFactory {
    
    static func breedsConfig() -> RequestConfig<BreedsParser> {
        let request = BreedsRequest()
        return RequestConfig<BreedsParser>(request: request, parser: BreedsParser())
    }
    
    static func breedImagesConfig(breed: String, subbreed: String?) -> RequestConfig<BreedImagesParser> {
        let request = BreedImagesRequest(breed: breed, subbreed: subbreed)
        return RequestConfig<BreedImagesParser>(request: request, parser: BreedImagesParser())
    }
    
    static func imageConfig(imageUrl: String) -> RequestConfig<ImageParser> {
        let request = ImageRequest(imageUrl: imageUrl)
        return RequestConfig<ImageParser>(request: request, parser: ImageParser())
    }

        
}
