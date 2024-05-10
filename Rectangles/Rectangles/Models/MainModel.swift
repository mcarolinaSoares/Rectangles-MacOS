//
//  MainModel.swift
//  Rectangles
//
//  Created by Carolina Soares on 08/05/2024.
//

struct MainModel: Decodable {

    let rectangles: [RectangleModel]

    enum CodingKeys: String, CodingKey {
        
        case rectangles = "rects"
    }
}
