//
//  RectangleModel.swift
//  Rectangles
//
//  Created by Carolina Soares on 08/05/2024.
//

struct RectangleModel: Decodable, Hashable {
    
    let x: Int
    let y: Int
    let w: Int
    let h: Int
}

extension RectangleModel {
    
    var xf: Int { return self.x + self.w }
    var yf: Int { return self.y + self.h }
}
