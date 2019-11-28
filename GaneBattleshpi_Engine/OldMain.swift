//
//  main.swift
//  GameBattleship_Terminal
//
//  Created by Sebastian on 10/10/2019.
//  Copyright © 2019 Sebastian. All rights reserved.
//
/*
import Foundation
let rows = 5
let cols = 5
let shipsSize = [4]//[4,3,3,2,2,2,1,1,1,1]

let myGame = GameBattleship(rows: rows, columns: cols, shipsSize: shipsSize)
var whoseTurn: GameBattleship.Who = .player

//funkcje robocza ułatwiająca testowanie
func tryAddShip(_ myGame: GameBattleship,_ rowName: String, _ colName: String, _ size: Int, _ orientation: Board.Orientation) {
    if  myGame.placeShip(rowName: rowName, colName: colName, size: size, orientation: orientation) {
        print("Dodane pomyślnie    pozycja: \(rowName)\(colName)  wielkość: \(size)  orientacja: \(orientation)")
    }
    else
    {
        print("Nie można dodać     pozycja: \(rowName)\(colName)  wielkość: \(size)  orientacja: \(orientation)")
    }
}
func randomRowName(rowsCount: Int)->String {
    let rows=["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    return rows[Int.random(in: 0..<rowsCount)]
}
func randomColName(colsCount: Int)->String {
    let cols=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O"]
    return cols[Int.random(in: 0..<colsCount)]
}

tryAddShip(myGame, "1", "A", 4, Board.Orientation.horizontal)
tryAddShip(myGame, "3", "A", 3, Board.Orientation.horizontal)
tryAddShip(myGame, "5", "A", 3, Board.Orientation.horizontal)
tryAddShip(myGame, "7", "A", 2, Board.Orientation.horizontal)
tryAddShip(myGame, "9", "A", 2, Board.Orientation.horizontal)

myGame.shipsAutoSetup(who: GameBattleship.Who.player)
myGame.shipsAutoSetup(who: GameBattleship.Who.opponent)
let autoPlay = !true
while(true){
    let rowName :String
    let colName :String
    if autoPlay || whoseTurn == .opponent {
        rowName = randomRowName(rowsCount: rows)
        colName = randomColName(colsCount: cols)
    }
    else {
        print("Row:")
        rowName = readLine()!
        print("Column:")
        colName = readLine()!
    }
    print("Turn: \(whoseTurn) \(rowName)\(colName)")
    if whoseTurn == .player {
        if !myGame.shot(who: whoseTurn, rowName: rowName, colName: colName) {
            whoseTurn = .opponent
        }
    }
    else {
        if !myGame.shot(who: whoseTurn, rowName: rowName, colName: colName) {
            whoseTurn = .player
        }
    }
    myGame.printBoards()
    
    if let who = myGame.checkWhoWins() {
        print("The winner is \(who)")
        break
    }
}
*/

