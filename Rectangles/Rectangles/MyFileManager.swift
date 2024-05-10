//
//  MyFileManager.swift
//  Rectangles
//
//  Created by Carolina Soares on 08/05/2024.
//

import AppKit
import UniformTypeIdentifiers

protocol MyFileManagerProtocol: AnyObject {
    
    func loadJSON(from url: URL)
}

class MyFileManager {
    
    let openPanel = NSOpenPanel()
    weak var delegate: MyFileManagerProtocol?
    
    @objc func openFile(_ sender: Any) {
        
        self.openPanel.title = "Select a JSON file"
        self.openPanel.allowedContentTypes = [UTType.json]
        
        self.openPanel.begin { (result) -> Void in
            
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                
                if let url = self.openPanel.urls.first {
                    
                    self.delegate?.loadJSON(from: url)
                }
            }
        }
    }
}
