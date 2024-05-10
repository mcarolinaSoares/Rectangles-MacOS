//
//  MainWindow.swift
//  Rectangles
//
//  Created by Carolina Soares on 07/05/2024.
//

import AppKit

class MainWindow: NSWindow {
    
    let mainViewController: MainViewController
    let mainLogicController: MainLogicController
    let dataSource: RectanglesDataSource
    let myFileManager: MyFileManager
    
    init() {
        
        self.myFileManager = MyFileManager()
        self.dataSource = RectanglesDataSource(myFileManager: self.myFileManager)
        self.mainLogicController = MainLogicController(dataSource: self.dataSource)
        self.mainViewController = MainViewController(logicController: self.mainLogicController)
        
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 970, height: 640),
            styleMask: [
                .titled,
                .closable,
                .miniaturizable,
                .resizable,
                .fullSizeContentView,
            ],
            backing: .buffered,
            defer: false
        )
        
        if let screenFrame = NSScreen.main?.frame {
            
            setFrame(screenFrame, display: true)
        }
        
        self.setupToolbar()
        
        self.contentView = self.mainViewController.view
        self.contentViewController = self.mainViewController
    }
    
    func setupToolbar() {
        let toolbar = NSToolbar(identifier: "toolbar")
        toolbar.delegate = self
        toolbar.displayMode = .iconAndLabel
        toolbar.allowsUserCustomization = true
        toolbar.autosavesConfiguration = true
        self.toolbar = toolbar
    }
}

extension MainWindow: NSToolbarDelegate {
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.openFile] // Add your toolbar item identifiers here
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.openFile] // Define the default order of toolbar items
    }
    
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        if itemIdentifier == .openFile {
            let openItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            openItem.label = "Open"
            openItem.action = #selector(MyFileManager.openFile(_:))
            openItem.target = self.myFileManager
            openItem.image = NSImage(named: NSImage.folderName)
            return openItem
        }
        return nil
    }
}

extension NSToolbarItem.Identifier {
    
    static let openFile = NSToolbarItem.Identifier("openFile")
}



