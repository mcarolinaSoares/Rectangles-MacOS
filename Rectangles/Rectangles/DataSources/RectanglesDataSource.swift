//
//  RectanglesDataSource.swift
//  Rectangles
//
//  Created by Carolina Soares on 08/05/2024.
//

import AppKit

protocol RectanglesDataSourceProtocol: AnyObject {
    
    func getRectangles(rectangles: [RectangleModel])
}

class RectanglesDataSource {
    
    private var myFileManager: MyFileManager
    weak var delegate: RectanglesDataSourceProtocol?
    
    init(myFileManager: MyFileManager) {
        
        self.myFileManager = myFileManager
        self.myFileManager.delegate = self
    }
}

extension RectanglesDataSource: MyFileManagerProtocol {
    
    func loadJSON(from url: URL) {
        
        do {
            
            let jsonData = try Data(contentsOf: url)
            let rectangles = try JSONDecoder().decode(MainModel.self, from: jsonData)
            
            self.delegate?.getRectangles(rectangles: rectangles.rectangles)
            
        } catch {
            
            print("Error loading JSON: \(error.localizedDescription)")
        }
    }
}
