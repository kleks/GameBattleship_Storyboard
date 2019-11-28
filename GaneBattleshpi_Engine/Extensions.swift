//
//  Extensions.swift
//  GameBattleship_Terminal
//
//  Created by Sebastian on 18/10/2019.
//  Copyright © 2019 Sebastian. All rights reserved.
//

import Foundation

extension String
{
    func leftPadding(toLength: Int, withChar: Character = " ")->String {
        guard self.count < toLength else { return self }
        
        return  String(repeating: withChar, count: toLength-self.count) + self
    }
}

extension Int
{
    func determineNumberOfDigits()->Int {
        var tmpValue = 10
        var digits = 1
        
        while self >= tmpValue {
            digits += 1
            tmpValue *= 10
        }
        return digits
    }
}
