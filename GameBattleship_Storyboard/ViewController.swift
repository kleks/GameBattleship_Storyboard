//
//  ViewController.swift
//  GameBattleship_Storyboard
//
//  Created by Sebastian on 26/11/2019.
//  Copyright © 2019 Sebastian. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var View_Board_Player: View_Board!
    @IBOutlet var View_Board_Opponent: View_Board!
    @IBOutlet var LabelInfo: NSTextField!
    
    private let rows = 5
    private let cols = 10
    private let shipsSize = [4]//[4,3,3,2,2,2,1,1,1,1]

    private var myGame: GameBattleship!
    private var whoseTurn: GameBattleship.Who = .player

    override func viewDidLoad() {
        super.viewDidLoad()
        myGame = GameBattleship(rows: rows, columns: cols, shipsSize: shipsSize)
        myGame.shipsAutoSetup(who: GameBattleship.Who.player)
        myGame.shipsAutoSetup(who: GameBattleship.Who.opponent)
//
        myGame.setView_Board(who: .player, viewBoard: View_Board_Player)
        myGame.setView_Board(who: .opponent, viewBoard: View_Board_Opponent)
        
        View_Board_Player.needsDisplay = true
        View_Board_Opponent.needsDisplay = true
        myGame.printBoards()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

