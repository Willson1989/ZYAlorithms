//
//  FibonacciSequence.swift
//  DesignPattern
//
//  Created by WillHelen on 2018/3/7.
//  Copyright © 2018年 WillHelen. All rights reserved.
//

import Foundation

/*
 斐波那契数列(兔子队列) 0 1 1 2 3 5 8 13 21 34 55
 */
//参考 ： https://www.cnblogs.com/AlgrithmsRookie/p/5919164.html
class FibonacciSequence {
    
    public class func getElement_Simple(at index : Int) -> UInt64 {
        if index == 0 {
            return 0
        }
        if index == 1 {
            return 1
        }
        return self.getElement_Simple(at:index - 1) + self.getElement_Simple(at:index - 2)
    }
    
    
    public class func create_Simple(limit : Int) -> [UInt64] {
        
        var arr = [UInt64]()
        
        for i in 0 ..< limit {
            arr.append(self.getElement_Simple(at: i))
        }
        
        return arr
    }
}


/*
 buffer 动态规划
 使用一个数组来记录各个子问题的解，当再一次遇到这一问题的时候直接查找数组来获得解避免多次计算子问题。
 */
extension FibonacciSequence {
    
    public class func create_Buffert(limit : Int) -> [UInt64] {
    
        var buffer = Array<UInt64>(repeating: 0, count: limit + 1)
        _=_getElement_Buffer(buffer: &buffer, index: limit)
        return buffer
    }
    
    public class func getElement_Buffer(at index : Int) -> UInt64 {
        
        var buffer = Array<UInt64>(repeating: 0, count: index + 1)
        return _getElement_Buffer(buffer: &buffer, index: index)
    }
    
    fileprivate class func _getElement_Buffer(buffer : inout [UInt64], index : Int) -> UInt64 {
        
        if index == 0 {
            buffer[0] = 0
            return 0
        }
        
        if index == 1 {
            buffer[1] = 1
            return 1
        }
        
        if buffer[index] > 0 {
            return buffer[index]
        }
        
        buffer[index] = _getElement_Buffer(buffer: &buffer, index: index - 1) + _getElement_Buffer(buffer: &buffer, index: index - 2)
        return buffer[index]
    }
    
    
}

//自底向上的解决方案
//先求解子问题再根据子问题的解来求解父问题
extension FibonacciSequence {
    
    public class func getElement_Base(at index : Int) -> UInt64 {
        return self.create_Base(limit: index)[index]
    }
    
    public class func create_Base(limit : Int) -> [UInt64] {
        var arr = Array<UInt64>(repeating: 0, count: limit + 1)
        arr[0] = 0
        arr[1] = 1
        for i in 2 ... limit {
            arr[i] = arr[i - 1] + arr[i - 2]
        }
        return arr
    }
    
}



