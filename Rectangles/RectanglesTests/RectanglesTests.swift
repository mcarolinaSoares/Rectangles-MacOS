//
//  RectanglesTests.swift
//  RectanglesTests
//
//  Created by Carolina Soares on 09/05/2024.
//

import XCTest

@testable import Rectangles

final class test_macTests: XCTestCase {
    
    var dataSource: RectanglesDataSource?
    var logicController: MainLogicController?
    var viewControllew: MainViewController?
    
    let rect1 = RectangleModel(x: 100, y: 100, w: 250, h: 80)
    let rect2 = RectangleModel(x: 120, y: 200, w: 250, h: 150)

    override func setUpWithError() throws {
        
        self.dataSource = RectanglesDataSource(myFileManager: MyFileManager())
        self.logicController = MainLogicController(dataSource: self.dataSource!)
        self.viewControllew = MainViewController(logicController: self.logicController!)
    }

    override func tearDownWithError() throws {
        
        self.dataSource = nil
        self.logicController = nil
        self.viewControllew = nil
    }

    func testRectanglesTuples() throws {
        
        self.logicController?.transformRectanglesIntoTuples(rectangles: self.mockedRectangles())
        
        XCTAssertEqual(self.logicController?.rectangles.first?.0, self.mockedRectanglesTuples().first?.0)
        XCTAssertEqual(self.logicController?.rectangles.first?.1, self.mockedRectanglesTuples().first?.1)
        XCTAssertEqual(self.logicController?.rectangles.last?.0, self.mockedRectanglesTuples().last?.0)
        XCTAssertEqual(self.logicController?.rectangles.last?.1, self.mockedRectanglesTuples().last?.1)
    }
    
    func testCreateIntersect() throws {
        
        self.logicController?.createRectangleIntersection(r0: self.rect1, r1: self.rect2, i0: 1, i1: 2)
        
        let isEmpty = self.logicController?.intersecRectArray.isEmpty
        XCTAssertTrue(isEmpty!)
    }

    func testFindIntersections() throws {
        
        self.logicController?.rectangles = self.mockedRectanglesTuples()
        self.logicController?.findIntersections()
        self.logicController?.transformRectanglesArrayIntoDic()
        
        let numberIntersect = self.viewControllew?.intersecRectDic.count
        
        XCTAssertEqual(numberIntersect, 1)
    }

}

extension test_macTests {
    
    func mockedRectangles() -> [RectangleModel] {
        
        [RectangleModel(x: 100, y: 100, w: 250, h: 80),
         RectangleModel(x: 160, y: 140, w: 350, h: 190)]
        
    }
    
    func mockedRectanglesTuples() -> [(Int, RectangleModel)] {
        
        [(1, RectangleModel(x: 100, y: 100, w: 250, h: 80)),
         (2, RectangleModel(x: 160, y: 140, w: 350, h: 190))]
        
    }
}
