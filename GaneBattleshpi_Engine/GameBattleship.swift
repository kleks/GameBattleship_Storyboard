//
//  GameBattleship.swift
//  GameBattleship_Terminal
//
//  Created by Sebastian on 10/10/2019.
//  Copyright © 2019 Sebastian. All rights reserved.
//

import Foundation

class GameBattleship {
    enum Who {case player, opponent}
    
    private var boardPlayer: Board!
    private var boardOpponent: Board!
    
    private let shipsSize: [Int]
    private let rows: Int
    private let columns: Int
    
    init(rows: Int = 10, columns: Int = 10, shipsSize: [Int] = [4,3,3,2,2,2,1,1,1,1]) {
        self.shipsSize = shipsSize
        self.rows = rows
        self.columns = columns
        boardPlayer = Board(rows: rows, columns: columns, shipsSize: shipsSize)
        boardOpponent = Board(rows: rows, columns: columns, shipsSize: shipsSize)
    }
    
    func setView_Board(who: GameBattleship.Who, viewBoard: View_Board)
    {
        if who == .player {
            viewBoard.board = boardPlayer
            viewBoard.covered = false
        }
        else {
            viewBoard.board = boardOpponent
            viewBoard.covered = true
            //viewBoard.shotClick = boardOpponent.shot
        }
    }
    func printBoards() {
        print ("Player")
        boardPlayer.printBoard();
        print ("Opponent")
        boardOpponent.printBoard(covered: !true);
        print(String(repeating: "-", count: columns+10))
    }
    
    public func placeShip(rowName: String, colName: String, size: Int, orientation: Board.Orientation)->Bool {
        boardPlayer.placeShip(rowName: rowName, colName: colName, size: size, orientation: orientation)
    }
    
    public func shipsAutoSetup(who: Who)->Bool {
        var board = (who == Who.player) ? boardPlayer : boardOpponent
        
        var i=1
        while !(board!.shipsAutoSetup()) {
            board = Board(rows: self.rows, columns: self.columns, shipsSize: self.shipsSize)
            print ("powtówne losowanie \(Who.player) \(i)")
            i+=1
            guard i<10 else {
                return false
            }
        }
        return true
    }
    public func shot(who: Who, rowNumber: Int, colNumber: Int)->Bool {
        if(who == .player) {
            return boardOpponent.shot(rowNumber: rowNumber, colNumber: colNumber)
        }
        else {
            return boardPlayer.shot(rowNumber: rowNumber, colNumber: colNumber)
        }
    }
    public func shot(who: Who, rowName: String, colName: String)->Bool {
        if(who == .player) {
            return boardOpponent.shot(rowName: rowName, colName: colName)
        }
        else {
            return boardPlayer.shot(rowName: rowName, colName: colName)
        }
    }
    
    public func checkWhoWins()->Who? {
        if boardPlayer.isWinnerBoard() {
            return .opponent
        }
        else if boardOpponent.isWinnerBoard(){
            return .player
        }
        return nil
    }
}
