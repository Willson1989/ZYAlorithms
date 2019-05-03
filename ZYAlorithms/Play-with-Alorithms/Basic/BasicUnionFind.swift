//
//  BasicUnionFind.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2019/3/11.
//  Copyright © 2019年 ZhengYi. All rights reserved.
//

import Foundation


struct BasicUnionFind {
    
    var idArray = [Int]()
    var parent = [Int]()
    var rank = [Int]()
    
    init(_ capacity : Int) {
        for i in 0 ..< capacity {
            idArray.append(i)
            parent.append(i)
            rank.append(1)
        }
    }
    
    private func isValid(_ p : Int) -> Bool {
        return p >= 0 && p < idArray.count
    }
    
    mutating func find(_ p : Int) -> Int {
        
        return self._find_compressPath_1(p)
    }
    
    mutating func union(_ p : Int, _ q : Int) {
        guard isValid(p), isValid(q) else {
            return
        }
        let pRoot = find(p)
        let qRoot = find(q)
        //层数少的连接到多的，这样不会增加层数
        if rank[pRoot] > rank[qRoot] {
            parent[qRoot] = pRoot
            
        } else {
            parent[pRoot] = qRoot
            if rank[pRoot] == rank[qRoot] {
                rank[qRoot] =  rank[qRoot] + 1
            }
        }
    }
    
    mutating func isConnected(_ p : Int, _ q : Int) -> Bool {
        guard isValid(p), isValid(q) else {
            return false
        }
        return find(p) == find(q)
    }
    
    private mutating func _find_compressPath_1(_ p : Int) -> Int {
        if !isValid(p) {
            return -1
        }
        /*
         路径压缩方式1:
         如果当前节点的父节点不是自己（初始时，每个节点的父节点都是自己），
         那么让当前节点的父节点为自己的爷爷节点
         */
        var vp = p
        while vp != parent[vp] {
            parent[vp] = parent[parent[vp]]
            vp = parent[vp]
        }
        return vp
    }
    
    private mutating func _find_compressPath_2(_ p : Int) -> Int {
        if !isValid(p) {
            return -1
        }
        if p == parent[p] {
            return p
        }
        parent[p] = find(parent[p])
        return parent[p]
    }
    
    
}
