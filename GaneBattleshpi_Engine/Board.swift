//
//  Board.swift
//  GameBattleship_Terminal
//
//  Created by Sebastian on 10/10/2019.
//  Copyright © 2019 Sebastian. All rights reserved.
//

import Foundation

class Board {
   private let columns: Int
   private let rows: Int
    var Rows: Int {
        get {
            return rows
        }
    }
    var Columns: Int {
           get {
               return columns
           }
       }
   private var board: [[CellContentType]]
    var Board: [[CellContentType]] {
        get {
            return board
        }
    }
   private var shipsSize: [Int]
   //private var boardDict = [String:[String:CellContentType]]()
   
   enum CellContentType {
      case empty, ship, hitEmpty, hitShip
   }
   enum Orientation {
      case horizontal, vertical
   }
   
   init (rows: Int, columns: Int, shipsSize: [Int]) {
      self.rows = rows
      self.columns = columns
      self.shipsSize = shipsSize
      
      //create board
      self.board = Array(repeating: Array(repeating: CellContentType.empty,
                                          count: self.columns),
                         count: self.rows)
      
      
      /*for h in 0..<self.height {
       boardDict[getRowName(rowNumber: h)] = Dictionary<String, CellContentType>()
       for w in 0..<self.width {
       boardDict[getRowName(rowNumber: h)]?[getColName(colNumber: w)] = CellContentType.empty
       }
       }
       */
      
      //self.board[1][1] = CellContentType.ship
      //self.board[2][2] = CellContentType.shot
      
   }
   
   func printBoard(covered: Bool=false) {
      let maxRowHeaderLenght = (rows+1).determineNumberOfDigits()
      let borderLine = "+\(String(repeating:"-", count: columns*2+3+maxRowHeaderLenght*2))+"
      
      var colHeader = ""
      for col in 0..<columns {
         colHeader += getColName(colNumber: col)+" "
      }
      colHeader = "|" + String(repeating: " ", count: 2+maxRowHeaderLenght) + colHeader + String(repeating: " ", count: 1+maxRowHeaderLenght) + "|"
      
      print(borderLine)
      print(colHeader)
      for row in 0..<rows {
         var line = ""
         for col in 0..<columns {
            switch (board[row][col],covered){
            case (.empty, _):
               line += "  "
            case (.ship, true):
               line += "  "
            case (.ship, false):
               line += "_ "
            case (.hitEmpty, _):
               line += ". "
            case (.hitShip, _):
               line += "X "
            }
         }
         print("| \(getRowName(rowNumber: row).leftPadding(toLength: maxRowHeaderLenght)) \(line)\(getRowName(rowNumber: row).leftPadding(toLength: maxRowHeaderLenght)) |")
      }
      
      print(colHeader)
      print(borderLine)
   }
   
   private func getRowName(rowNumber r:Int) -> String {
      return String(r+1)
   }
   
   private func getColName(colNumber c:Int) -> String {
      return String(UnicodeScalar(Int(UnicodeScalar("A").value) + c) ?? "A")
   }
   
   private func getRowNumber(rowNumber r:String) -> Int {
      return Int(r)! - 1
   }
   
   private func getColNumber(colNumber c:String) -> Int {
      return Int(UnicodeScalar(c)!.value) - Int(UnicodeScalar("A").value)
   }
   private func isCorrectField(rowNumber: Int, colNumber: Int) -> Bool {
      if rowNumber>=0 && rowNumber<rows && colNumber>=0 && colNumber<columns {
         return true
      }
      return false
   }
   private func isEmpty(rowNumber: Int, colNumber: Int) -> Bool {
      if(board[rowNumber][colNumber] == CellContentType.empty) {
         return true
      }
      return false
   }
   private func isEmptyForShip(rowNumber: Int, colNumber: Int) -> Bool {
      for row in rowNumber-1...rowNumber+1 {
         for col in colNumber-1...colNumber+1 {
            if row==rowNumber && col==colNumber && !isCorrectField(rowNumber: row,colNumber: col) {
               return false
            }
            else if isCorrectField(rowNumber: row,colNumber: col) && board[row][col] == CellContentType.ship {
               return false
            }
            
         }
      }
      
      return true
   }
   
   public func placeShip(rowName: String, colName: String, size: Int, orientation: Orientation)->Bool {
      let row = getRowNumber(rowNumber: rowName)
      let col = getColNumber(colNumber: colName)
      return placeShip(rowNumber: row, colNumber: col, size: size, orientation: orientation)
   }
   
   private func placeShip(rowNumber: Int, colNumber: Int, size: Int, orientation: Orientation)->Bool {
      guard shipsSize.contains(size) else {
         return false
      }
      
      var fields:[(Int, Int)] = Array()
      var row = rowNumber
      var col = colNumber
      for _ in 0..<size {
         if isEmptyForShip(rowNumber: row, colNumber: col) {
            fields.append((row,col))
            if orientation==Orientation.horizontal {
               col += 1
            }
            else if orientation == Orientation.vertical {
               row += 1
            }
            else {
               return false
            }
         }
         else {
            return false
         }
      }
      for (r,c) in fields {
         board[r][c] = CellContentType.ship
      }
      shipsSize.remove(at: shipsSize.firstIndex(of: size)!)
      //printBoard()
      return true
   }
   
   public func shipsAutoSetup() -> Bool {
      var maxTries = 1000
      while shipsSize.count > 0 {
         let size = shipsSize[0]
         var row: Int
         var col: Int
         var ori: Orientation
         while(true) {
            row = Int.random(in: 0..<rows)
            col = Int.random(in: 0..<columns)
            let intOri = Int.random(in: 1...2)
            
            if(intOri==1){
               ori = .horizontal
            }
            else {
               ori = .vertical
            }
            maxTries -= 1
            if maxTries < 0
            {
               print("Nie udało się wylosować!!!")
               print(shipsSize)
               printBoard()
               return false
            }
            //print(maxTries)
            //printBoard()
            if(self.placeShip(rowNumber: row, colNumber: col, size: size, orientation: ori))
            {
               break
            }
         }
      }
      print("Wylosowane za \(1000-maxTries) razem")
      return true
   }
   
   public func shot(rowName: String, colName: String)->Bool {
      let row = getRowNumber(rowNumber: rowName)
      let col = getColNumber(colNumber: colName)
      return shot(rowNumber: row, colNumber: col)
   }
   
   public func shot(rowNumber: Int, colNumber: Int)->Bool {
      switch board[rowNumber][colNumber] {
      case .empty:
         board[rowNumber][colNumber] = .hitEmpty
         break
      case .ship:
         board[rowNumber][colNumber] = .hitShip
         return true
         //break
      case .hitEmpty, .hitShip:
         break
      }
      return false
   }
   public func isWinnerBoard()->Bool {
      for row in 0..<rows {
         for col in 0..<columns {
            if board[row][col] == .ship {
               return false
            }
         }
      }
      return true
   }
}
