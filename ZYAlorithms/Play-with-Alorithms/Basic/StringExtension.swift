//
//  StringExtension.swift
//  Play-with-Alorithms
//
//  Created by 郑毅 on 2019/2/22.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import Foundation

extension String {

    //获取子字符串
    func substringInRange(_ r: Range<Int>) -> String? {
        if r.lowerBound < 0 || r.upperBound > self.count {
            return nil
        }
        let startIndex = self.index(self.startIndex, offsetBy:r.lowerBound)
        let endIndex   = self.index(self.startIndex, offsetBy:r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    
    
    func charAt(_ i : Int) -> Character {
        return self[String.Index(encodedOffset: i)]
    }
}

extension Character {
    func isChar() -> Bool {
        return (self >= "a" && self <= "z") || (self >= "A" && self <= "Z")
    }
    
    func isNum() -> Bool {
        let scanner = Scanner(string: String(self))
        var val : Int = 0
        return scanner.scanInt(&val) && scanner.isAtEnd
    }
    
    func isBracket() -> Bool {
        return self == "[" || self == "]"
    }
}
