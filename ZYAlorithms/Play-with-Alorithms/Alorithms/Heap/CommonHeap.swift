
//
//  CommonHeap.swift
//  Play-with-Alorithms
//
//  Created by ZhengYi on 2017/6/22.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import Foundation

public func parent(_ i : Int) -> Int {
    return i / 2
}

public func left(_ i : Int) -> Int {
    return 2 * i
}

public func right(_ i : Int) -> Int {
    return 2 * i + 1
}

public enum HeapType {
    case min
    case max
}

public let HEAP_NG : Int = 0

//索引从 1 开始
public class CommonHeap< T : Comparable & Equatable > {
    
    internal var data : [T?] = []
    internal var count : Int = 0
    internal var capacity : Int = 0
    
    internal var type : HeapType = .min
    
    public init(capacity : Int, type : HeapType) {
        self.type = type
        self.capacity = capacity
        self.count = 0
        self.data = Array(repeating: nil, count: capacity + 1)
    }
    
    public init(arr : [T], type : HeapType) {
        self.type = type
        self.capacity = arr.count
        self.count = arr.count
    }
    
    internal func fixUp(_ idx : Int) { }
    
    internal func fixDown(_ idx : Int) { }
    
    internal func insert(item : T) { }
    
    internal func insert(item : T, at idx : Int) { }
    
    internal func change(with item : T, atDataIndex idx : Int) { }
    
    internal func change(with item : T, atHeapIndex idx : Int) { }
    
    internal func getItem(at idx : Int) -> T { return -32767 as! T }

    internal func extract() -> T? { return nil }
    
    internal func extractIndex() -> Int { return HEAP_NG }
    
    internal func isEmpty() -> Bool {
        return self.count == 0
    }
    
    internal func size() -> Int {
        return self.count
    }
    
    internal func contain(_ idx : Int) -> Bool {
        let i = idx + 1
        if i >= 1 && i <= count {
            return self.data[i] != nil
        }
        return false
    }
    
    internal func showHeap() {
        if count <= 0 {
            print("heap is empty")
            return
        }
        print("Heap Info : ")
        for i in 1 ... count {
            print(data[i]!, separator: "", terminator: " ")
        }
        print()
    }
    
    public static func fixDown(arr   : inout [T],
                               index : Int,
                               len   : Int,
                               type  : HeapType) {
        
        func compare (a : T, b : T) -> Bool{
            return type == .min ? a < b : a > b
        }
        //因为是对数组进行原地堆排序，所以这里的索引都是从0开始的
        var i = index
        let tmp = arr[i]
        while  (2 * i + 1) < len  {
            var j = 2 * i + 1
            if (j + 1) < len && compare(a: arr[j+1], b: arr[j]) {
                j = j + 1
            }
            if tmp >= arr[j] {
                break
            }
            arr[i] = arr[j]
            i = j
        }
        arr[i] = tmp
    }
    
    internal func compare(_ a : T, _ b : T) -> Bool {
        return type == .min ? a < b : a > b
    }
}


