//
//  IndexHeap.swift
//  Play-with-Alorithms
//
//  Created by ZhengYi on 2017/6/22.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import Foundation


public class IndexHeap<T : Comparable & Equatable> : CommonHeap<T> {
    
    internal var index : [Int] = []
    internal var map : [Int] = []
    
    public override init(capacity : Int, type : HeapType) {
        super.init(capacity: capacity, type: type)
        
        index = Array(repeating: HEAP_NG, count: capacity + 1)
        map = Array(repeating: HEAP_NG, count: capacity + 1)
    }
    
    public override init(arr : [T], type : HeapType) {
        super.init(arr: arr, type: type)
        
        data = Array(repeating: nil, count: capacity + 1)
        index = Array(repeating: HEAP_NG, count: capacity + 1)
        map = Array(repeating: HEAP_NG, count: capacity + 1)
        
        for i in 0 ..< arr.count {
            data[i + 1] = arr[i]
            index[i + 1] = i + 1
            map[index[i + 1]] = i + 1
        }
        
        /*
         对于一个二叉堆来说，其所有的叶子节点都可以看做是一个只有一个节点的二叉堆
         那么基于索引从后往前看的话(堆的大小，即节点总数为len)：
         1.如果堆的索引从0开始，那么第一个非叶子节点的索引为 len / 2 - 1
         2.如果堆的索引从1开始，那么第一个非叶子节点的索引为 len / 2
         （上面的除法都是整型除法，即11/2 = 5）
         这样的话就可以忽略所有的叶子节点（因为叶子节点已经是二叉堆或者最大堆了），
         从这个 “第一个” 非叶子节点开始向前遍历每一个节点，执行shiftDown操作，
         这样的话，每一个节点（除叶子节点）为根的树都满足了堆的性质，
         一次类推，当根节点执行完shiftdown操作之后，整个数组就heapify（堆化）了
         */
        for i in stride(from: count / 2, through: 1, by: -1) {
            fixDown(i)
        }
    }
    
    internal override func fixDown(_ idx: Int) {
        if count <= 0 { return }
        if data[index[idx]] == nil { return }
        if idx < 1 || idx > count { return }
        
        var i = idx
        let tmpIdx = index[i]
        let tmp = data[tmpIdx]!
        while left(i) <= count {
            var j = left(i)
            if j + 1 <= count && compare(data[index[j+1]]!, data[index[j]]!) {

                j = j + 1
            }
            if compare(tmp, data[index[j]]!){
                break
            }
            index[i] = index[j]
            map[index[i]] = i
            map[index[j]] = j
            i = j
        }
        index[i] = tmpIdx
    }

    internal override func fixUp(_ idx: Int) {
        if count <= 0 { return }
        if idx < 1 || idx > count { return }
        
        var i = idx
        let tmpIdx = index[i]
        let tmp = data[tmpIdx]!
        while parent(i) >= 1 && compare(tmp, data[index[parent(i)]]!) {
            index[i] = index[parent(i)]
            map[index[i]] = i
            map[index[parent(i)]] = parent(i)
            i = parent(i)
        }
        index[i] = tmpIdx
    }
    
    override func insert(item: T, at idx: Int) {
        let i = idx + 1
        if contain(idx) {
            return
        }
        if i < 1 || i > capacity {
            return
        }
        if count + 1 > capacity {
            return
        }
        data[i] = item
        count += 1
        index[count] = i
        map[i] = count
        fixUp(count)
    }
    
    override func change(with item: T, atDataIndex idx: Int) {
        let i = idx + 1
        if !contain(idx) {
            return
        }
        if i < 1 || i > count {
            return
        }
        data[i] = item
        let heapIdx = map[i]
        fixUp(heapIdx)
        fixDown(heapIdx)
    }
    
    override func change(with item: T, atHeapIndex idx: Int) {
        let i = idx + 1
        if !contain(idx) {
            return
        }
        if i < 1 || i > count {
            return
        }
        let arrIdx = index[i]
        data[arrIdx] = item
        fixUp(i)
        fixDown(i)
    }
    
    override func extract() -> T? {
        if isEmpty() {
            return nil
        }
        let ret = data[index[1]]
        swapElement(&index, count, 1)
        map[index[count]] = HEAP_NG
        map[index[1]] = 1
        count -= 1
        fixDown(1)
        return ret
    }
    
    override func extractIndex() -> Int {
        if isEmpty() {
            return HEAP_NG - 1
        }
        let ret = index[1] - 1
        swapElement(&index, count, 1)
        map[index[count]] = HEAP_NG
        map[index[1]] = 1
        count -= 1
        fixDown(1)
        return ret
    }
    
    override func contain(_ idx: Int) -> Bool {
        let i = idx + 1
        if i < 1 || i > count {
            return false
        }
        return map[i] != HEAP_NG
    }
    
    override func showHeap() {
        if count <= 0 {
            print("heap is empty")
            return
        }
        print("Heap Info : ")
        for i in 1 ... count {
            print(data[index[i]]!, separator: "", terminator: " ")
        }
        print()
    }

}
