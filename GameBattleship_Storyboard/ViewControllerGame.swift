//
//  ViewController.swift
//  GameBattleship_Storyboard
//
//  Created by Sebastian on 26/11/2019.
//  Copyright © 2019 Sebastian. All rights reserved.
//

import Cocoa

class ViewControllerGame: NSViewController {

    @IBOutlet var View_Board_Player: View_Board!
    @IBOutlet var View_Board_Opponent: View_Board!
    
    var rows = 10
    var cols = 10
    var shipsSize = [4,3,3,2,2,2,1,1,1,1]

    private var myGame: GameBattleship!
    private var whoseTurn: GameBattleship.Who = .player

    override func viewDidLoad() {
        super.viewDidLoad()
        
        View_Board_Opponent.shotClick = playerClick
        
        //prepareNewGame()
    }
    
    func prepareNewGame() {
        let newGame = GameBattleship(rows: rows, columns: cols, shipsSize: shipsSize)
        
        guard newGame.shipsAutoSetup(who: GameBattleship.Who.player) &&
              newGame.shipsAutoSetup(who: GameBattleship.Who.opponent) else {
                let alert = NSAlert()
                alert.messageText = "Autosetup failed. Change parameters in \"New game\" window."
                alert.runModal()
                return
        }
        
        myGame = newGame
        myGame.setView_Board(who: .player, viewBoard: View_Board_Player)
        myGame.setView_Board(who: .opponent, viewBoard: View_Board_Opponent)
        
        myGame.printBoards()
        
        View_Board_Player.needsDisplay = true
        View_Board_Opponent.needsDisplay = true
        
        View_Board_Opponent.canClick = true
    }
    
    func playerClick(_ x: Int, _ y: Int) {
        if !myGame.shot(who: .player, rowNumber: y, colNumber: x) {
            whoseTurn = .opponent
        }
        else
        {
            View_Board_Opponent.canClick = true
        }
        while  whoseTurn == .opponent {
            let rowNumber = Int.random(in: 0..<rows)
            let colNumber = Int.random(in: 0..<cols)
            
            if !myGame.shot(who: .opponent, rowNumber: rowNumber, colNumber: colNumber) {
                whoseTurn = .player
                View_Board_Opponent.canClick = true
            }
        }
//        myGame.printBoards()
        View_Board_Player.needsDisplay = true
        View_Board_Opponent.needsDisplay = true
        if let who = myGame.checkWhoWins() {
            print("The winner is \(who)")
            View_Board_Opponent.canClick = false
            
            let alert = NSAlert()
//            alert.addButton(withTitle: "TAK")
//            alert.addButton(withTitle: "NIE")
    
//            alert.buttons[0].highlight(true)
//            alert.buttons[1].highlight(true)
    
//            alert.showsSuppressionButton = true
//            alert.suppressionButton?.title = "Czy zapamiętać ustawienia?"
    
            alert.messageText = "The winner is \(who)"
            alert.runModal()
//            let response = alert.runModal()

//            //Sprawdzanie odpowiedzi - jeśli by była potrzeba
//            if response==NSApplication.ModalResponse.alertFirstButtonReturn {
////                print("1")
//            }
//            else if response==NSApplication.ModalResponse.alertSecondButtonReturn {
////                print("2")
//            }
//            else if response==NSApplication.ModalResponse.alertThirdButtonReturn {
////                print("3")
//            }
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
