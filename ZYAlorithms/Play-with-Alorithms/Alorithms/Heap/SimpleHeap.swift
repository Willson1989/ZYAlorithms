//
//  SimpleHeap.swift
//  Play-with-Alorithms
//
//  Created by ZhengYi on 2017/6/22.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import Foundation

public class SimpleHeap<T : Comparable & Equatable> : CommonHeap<T> {
    
    
    public override init(capacity: Int, type: HeapType) {
        super.init(capacity: capacity, type: type)
    }
    
    public override init(arr: [T], type: HeapType) {
        super.init(arr: arr, type: type)
        self.data = Array(repeating: nil, count: self.capacity + 1)
        for i in 0 ..< arr.count {
            self.data[i+1] = arr[i]
        }
        //heapify
        for i in stride(from: count / 2, to: 0, by: -1) {
            self.fixDown(i)
        }
    }
    
    override func fixDown(_ idx: Int) {
        if count <= 0 { return }
        if data[idx] == nil { return }
        if idx < 1 || idx > count { return }
        
        var i = idx
        let tmp = data[i]!
        while left(i) <= count {
            var j = left(i) //data[j + 1]! > data[j]!
            if j + 1 <= count && compare(data[j + 1]!, data[j]!) {
                j = j + 1
            }
            if compare(tmp, data[j]!) {
                break
            }
            data[i] = data[j]
            i = j
        }
        data[i] = tmp
    }
    
    override func fixUp(_ idx: Int) {
        
        if count <= 0 { return }
        if data[idx] == nil { return }
        if idx < 1 || idx > count { return }
        
        var i = idx
        let tmp = data[i]!
        while parent(i) >= 1 && compare(tmp, data[parent(i)]!) {
            data[i] = data[parent(i)]
            i = parent(i)
        }
        data[i] = tmp
    }
    
    override func insert(item: T) {
        if count + 1 > capacity {
            return
        }
        count += 1
        data[count] = item
        fixUp(count)
    }
    
    override func extract() -> T? {
        if isEmpty() {
            return nil
        }
        let ret = self.data[1]
        swapElement_T_Optional(&data, count, 1)
        count -= 1
        fixDown(1)
        return ret
    }
}
