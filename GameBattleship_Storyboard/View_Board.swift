//
//  View_Board.swift
//  GameBattleship_Storyboard
//
//  Created by Sebastian on 26/11/2019.
//  Copyright © 2019 Sebastian. All rights reserved.
//

import Cocoa

//@IBDesignable
class View_Board: NSView {
    
    var realBoard: Board!
    var board: Board! {
        get {
            return realBoard
        }
        set {
            realBoard = newValue
            //potrzebne przy rozpoczęciu nowej gry
            //aby wyliczyły się nowe rozmiary pól, położenia, itp.
            previousDirtyRect = nil
        }
    }
    var covered: Bool = true
    var canClick: Bool = false
    
    var fieldSize: CGFloat!
    var boardWidth: CGFloat!
    var boardHeight: CGFloat!
    var rectBoard: NSRect!
    
    var previousDirtyRect: NSRect!
    
    var shotClick: ((Int, Int)->Void)!
    @IBInspectable var BackgroundColor: NSColor = NSColor.yellow
    
    //    var PointTest: [NSPoint] = []
    override func mouseDown(with event: NSEvent){
        if canClick {
            let pointInCustomView = convert(event.locationInWindow, from: nil)
            let pointInBoard = (x: (Int)((pointInCustomView.x-rectBoard.origin.x)/fieldSize),
                                y: (Int)((pointInCustomView.y-rectBoard.origin.y)/fieldSize))
            //            PointTest.append(pointInCustomView)
            needsDisplay = true
            //            print("MYSZ in window(x,y) = (\(event.locationInWindow.x),\(event.locationInWindow.y))")
            //            print("MYSZ in customView(x,y) = (\(pointInCustomView.x),\(pointInCustomView.y))")
            //            print("MYSZ in board(x,y) = (\(pointInBoard.x),\(pointInBoard.y))")
            
            canClick = false
            shotClick(pointInBoard.x,board.Rows-1-pointInBoard.y)
        }
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let background = NSBezierPath(rect: dirtyRect)
        BackgroundColor.setFill()
        background.fill()
        guard board != nil else {
            return
        }
        if dirtyRect != previousDirtyRect {
            fieldSize = min((CGFloat)(dirtyRect.width)/(CGFloat)(board.Columns),
                            (CGFloat)(dirtyRect.height)/(CGFloat)(board.Rows))
            boardWidth = (CGFloat)(board.Columns) * fieldSize
            boardHeight = (CGFloat)(board.Rows) * fieldSize
            rectBoard = dirtyRect.insetBy(dx: ((CGFloat)(dirtyRect.width)-boardWidth)/2.0,
                                          dy: ((CGFloat)(dirtyRect.height)-boardHeight)/2.0)
            previousDirtyRect = dirtyRect
        }
        
        
        let backgroundBoard = NSBezierPath(rect: rectBoard)
        NSColor.yellow.setFill()
        backgroundBoard.fill()
        guard board==nil else {
            
            //siatka
            //            let siatka = NSBezierPath()
            //            siatka.lineWidth=2
            //            for row in 0...board.Rows {
            //                siatka.move(to: NSPoint(x: rectBoard.minX, y: rectBoard.minY + (CGFloat)(row)*fieldSize))
            //                siatka.line(to: NSPoint(x: rectBoard.maxX, y: rectBoard.minY + (CGFloat)(row)*fieldSize))
            //            }
            //            for col in 0...board.Columns {
            //                siatka.move(to: NSPoint(x: rectBoard.minX + (CGFloat)(col) * fieldSize, y: rectBoard.minY))
            //                siatka.line(to: NSPoint(x: rectBoard.minX + (CGFloat)(col) * fieldSize, y: rectBoard.maxY))
            //            }
            //            siatka.stroke()
            
            for row in 0..<board.Rows {
                for col in 0..<board.Columns {
                    let fieldRect = NSRect(x: rectBoard.minX + (CGFloat)(col) * fieldSize,
                                           y: rectBoard.maxY - ((CGFloat)(row)+1) * fieldSize,
                                           width: fieldSize,
                                           height: fieldSize)
                    drawField(fieldRect: fieldRect, fieldType: board.Board[row][col])
                }
            }
            
            //            for p in PointTest {
            //                NSColor.red.setFill()
            //                NSBezierPath(ovalIn: NSRect(x: p.x-5, y: p.y-5, width: 10, height: 10)).fill()
            //            }
            return
        }
        
    }
    func drawField(fieldRect: NSRect, fieldType: Board.CellContentType) {
        let bezzier = NSBezierPath(rect: fieldRect)
        let colorBlue = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) //#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        let colorRed = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        let colorYellow = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        
        var sign: NSBezierPath? = nil
        
        switch (fieldType,covered){
        case (.empty, _):
            colorBlue.setFill()
        case (.ship, true):
            colorBlue.setFill()
        case (.ship, false):
            colorBlue.setFill()
            sign = NSBezierPath()
            sign!.move(to: NSPoint(x: fieldRect.minX, y: fieldRect.minY))
            sign!.line(to: NSPoint(x: fieldRect.maxX, y: fieldRect.maxY))
            sign!.move(to: NSPoint(x: fieldRect.minX, y: fieldRect.maxY))
            sign!.line(to: NSPoint(x: fieldRect.maxX, y: fieldRect.minY))
            sign!.lineWidth = fieldRect.width / 20
        case (.hitEmpty, _):
            colorYellow.setFill()
            sign = NSBezierPath(ovalIn: fieldRect.insetBy(dx: fieldRect.width/3, dy: fieldRect.height/3))
            sign!.lineWidth = fieldRect.width / 20
        case (.hitShip, _):
            colorRed.setFill()
            sign = NSBezierPath()
            sign!.move(to: NSPoint(x: fieldRect.minX, y: fieldRect.minY))
            sign!.line(to: NSPoint(x: fieldRect.maxX, y: fieldRect.maxY))
            sign!.move(to: NSPoint(x: fieldRect.minX, y: fieldRect.maxY))
            sign!.line(to: NSPoint(x: fieldRect.maxX, y: fieldRect.minY))
            sign!.lineWidth = fieldRect.width / 10
        }
        
        
        bezzier.fill()
        
        NSColor.black.setStroke()
        if sign != nil {
            
            sign!.stroke()
        }
        
        bezzier.lineWidth = fieldRect.width / 10
        bezzier.stroke()
    }
}
