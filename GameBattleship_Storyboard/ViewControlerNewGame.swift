//
//  ViewControlerNewGame.swift
//  GameBattleship_Storyboard
//
//  Created by Sebastian on 18/12/2019.
//  Copyright © 2019 Sebastian. All rights reserved.
//

import Cocoa

class ViewControlerNewGame: NSViewController {
    
    @IBOutlet var TextFieldRows: NSTextField!
    @IBOutlet var TextFieldColumns: NSTextField!
    @IBOutlet var TextFieldShips: NSTextField!
    @IBOutlet var ButtonStart: NSButton!
    
    var viewControllerGame : ViewControllerGame?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //        let sMask = self.view.window
        //        self.view.window?.styleMask.remove(.resizable)
        //        self.view.window?.styleMask.remove(.closable)
        
        //        self.view.window?.styleMask.remove(.)
        
        
        TextFieldRows.delegate = self
        TextFieldColumns.delegate = self
        TextFieldShips.delegate = self
        
        viewControllerGame = (NSApplication.shared.mainWindow?.contentViewController as! ViewControllerGame)
        
        TextFieldRows.stringValue = String(viewControllerGame!.rows)
        TextFieldColumns.stringValue = String(viewControllerGame!.cols)
        TextFieldShips.stringValue = String(viewControllerGame!.shipsSize.map({String($0)}).joined(separator: ","))
    }
    
    @IBAction func ButtonStart_Click(_ sender: Any) {
        self.view.window?.performClose(nil)
        viewControllerGame!.prepareNewGame()
    }
}
extension ViewControlerNewGame:NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        //        let field = obj.object as! NSTextField
        //
        //        let value = Int(field.stringValue)
        //
        //        guard value != nil && value! >= 5 && value! <= 15 else {
        //            field.backgroundColor = NSColor.red
        //            ButtonStart.isEnabled = false
        //            return
        //        }
        
        let rows = Int(TextFieldRows.stringValue)
        let cols = Int(TextFieldColumns.stringValue)
        let shipsCompactMap = TextFieldShips.stringValue.split(separator: ",").compactMap({UInt($0)})
        let shipsMap = TextFieldShips.stringValue.split(separator: ",").map({UInt($0)})
        
        ButtonStart.isEnabled = true
        
        if rows != nil && rows! >= 5 && rows! <= 15 {
            TextFieldRows.backgroundColor = NSColor.textBackgroundColor
            viewControllerGame!.rows = rows!
        }
        else {
            TextFieldRows.backgroundColor = NSColor.red
            ButtonStart.isEnabled = false
        }
        
        if cols != nil && cols! >= 5 && cols! <= 15 {
            TextFieldColumns.backgroundColor = NSColor.textBackgroundColor
            viewControllerGame!.cols = cols!
        }
        else {
            TextFieldColumns.backgroundColor = NSColor.red
            ButtonStart.isEnabled = false
        }
        
        if shipsCompactMap.count>=3 && shipsMap.count == shipsCompactMap.count {
            TextFieldShips.backgroundColor = NSColor.textBackgroundColor
            viewControllerGame!.shipsSize = shipsCompactMap.map({Int($0)})
        }
        else
        {
            TextFieldShips.backgroundColor = NSColor.red
            ButtonStart.isEnabled = false
        }

    }
}
