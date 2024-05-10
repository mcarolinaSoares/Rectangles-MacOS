//
//  MainLogicController.swift
//  Rectangles
//
//  Created by Carolina Soares on 09/05/2024.
//

import AppKit

protocol MainLogicControllerProtocol: AnyObject {
    
    func getIntersectionRectangles(rectanglesDic: [RectangleModel : [Int]])
    func getInitialRectangles(rectanglesDic: [(Int, RectangleModel)])
}

class MainLogicController {
    
    var rectangles: [(Int, RectangleModel)] = []
    var intersecRectArray: [(Int, RectangleModel)] = []
    
    let dataSource: RectanglesDataSource
    
    weak var delegate: MainLogicControllerProtocol?
    
    init(dataSource: RectanglesDataSource) {
        
        self.dataSource = dataSource
        self.dataSource.delegate = self
    }
    
    func createRectangleIntersection(r0: RectangleModel, r1: RectangleModel, i0: Int, i1: Int) {
        
        let xi = max(r0.x, r1.x)
        let yi = max(r0.y, r1.y)
        let xf = min(r0.xf, r1.xf)
        let yf = min(r0.yf, r1.yf)
        
        let w = xf - xi
        let h = yf - yi
        
        if !(w < 0 || h < 0) {
            
            let intersectionRec = RectangleModel(x: xi, y: yi, w: w, h: h)
            
            self.intersecRectArray.append((i0, intersectionRec))
            self.intersecRectArray.append((i1, intersectionRec))
            
            self.rectangles.append((i0, intersectionRec))
            self.rectangles.append((i1, intersectionRec))
            
        }
    }
    
    func findIntersections() {
        
        for i in 0..<self.rectangles.count {
            
            for j in 0..<self.rectangles.count where j != i {
                
                self.createRectangleIntersection(r0: self.rectangles[i].1,
                                                 r1: self.rectangles[j].1,
                                                 i0: self.rectangles[i].0,
                                                 i1: self.rectangles[j].0)
            }
        }
    }
    
    func transformRectanglesArrayIntoDic() {
        
        let tempDic = Dictionary(grouping: self.intersecRectArray) { $0.1 }
        var finalDic: [RectangleModel : [Int]] = [:]
        
        for (key, value) in tempDic {
            
            let intValues = value.map { $0.0 }
            let uniqueIntValues = Set(intValues)
            
            finalDic[key] = Array(uniqueIntValues.sorted())
        }
        
        self.delegate?.getIntersectionRectangles(rectanglesDic: finalDic)
    }
    
    func transformRectanglesIntoTuples(rectangles: [RectangleModel]) {
        
        //make tuples to identify rectangles
        var index = 1
        
        for rectangle in rectangles {
            
            self.rectangles.append((index, rectangle))
            index = index + 1
        }
        
        self.delegate?.getInitialRectangles(rectanglesDic: self.rectangles)
    }
}


// MARK: RectanglesDataSourceProtocol

extension MainLogicController: RectanglesDataSourceProtocol {
    
    func getRectangles(rectangles: [RectangleModel]) {
        
        self.transformRectanglesIntoTuples(rectangles: rectangles)
        self.findIntersections()
        self.transformRectanglesArrayIntoDic()
    }
}
