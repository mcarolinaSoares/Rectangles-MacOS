//
//  MainViewController.swift
//  Rectangles
//
//  Created by Carolina Soares on 07/05/2024.
//

import AppKit

class MainViewController: NSViewController {
    
    let textInputView: NSTextView = {
        let textView = NSTextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let textOutputView: NSTextView = {
        let textView = NSTextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let logicController: MainLogicController
    
    var initialRectangles: [(Int, RectangleModel)] = []
    var intersecRectDic: [RectangleModel : [Int]] = [:]
    
    init(logicController: MainLogicController) {
        
        self.logicController = logicController
        
        super.init(nibName: nil, bundle: nil)
        
        self.logicController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        self.view = NSView()
        
        self.view.addSubview(self.textInputView)
        self.view.addSubview(self.textOutputView)
        
        self.defineConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func defineConstraints() {
        
        NSLayoutConstraint.activate([
            self.textInputView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 55),
            self.textInputView.bottomAnchor.constraint(equalTo: self.textOutputView.topAnchor),
            self.textInputView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.textInputView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.textInputView.heightAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            self.textOutputView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.textOutputView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.textOutputView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func configureInputText() {
        
        var text = "Input:\n"
        
        for (nRect, rect) in self.initialRectangles {
            
            text.append("\(nRect): Rectangle at (\(rect.x),\(rect.y)), w=\(rect.w), h=\(rect.h).\n")
        }
        
        self.textInputView.string = text
    }
    
    func configureOutputText() {
        
        var text = "Intersections:\n"
        let sortedDic = self.intersecRectDic.sorted { $0.value.first! < $1.value.first! }
        
        for (key, values) in sortedDic {
            
            var valuesText = ""
            
            for (index, val) in values.enumerated() {
                
                if index == values.count - 1 {
                    
                    valuesText.append(" \(val)")
                    
                } else if index == values.count - 2 {
                    
                    valuesText.append(" \(val) and")
                    
                } else {
                    
                    valuesText.append(" \(val),")
                }
            }
            
            text.append("Between rectangle\(valuesText) at (\(key.x),\(key.y)), w=\(key.w), h=\(key.h).\n")
        }
        
        self.textOutputView.string = text
    }
    
    func configureTextViews() {
        
        self.configureInputText()
        self.configureOutputText()
    }
}


// MARK: MainLogicControllerProtocol

extension MainViewController: MainLogicControllerProtocol {
    
    func getIntersectionRectangles(rectanglesDic: [RectangleModel : [Int]]) {
        
        self.intersecRectDic = rectanglesDic
        self.configureTextViews()
    }
    
    func getInitialRectangles(rectanglesDic: [(Int, RectangleModel)]) {
        
        self.initialRectangles = rectanglesDic
    }
}
