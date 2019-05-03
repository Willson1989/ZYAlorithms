//
//  FindingPath.swift
//  Play-with-Alorithms
//
//  Created by ZhengYi on 2017/6/23.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import Foundation


//MARK: - 无权图-寻路
public class GraphPath{
    
    internal var visited : [Bool] = []
    internal var from : [Int] = []
    internal var V : Int = INFINITY
    internal var num_Vertex : Int = 0
    internal var distance : [Int] = [] //广度优先遍历 和 最短路径时使用
    
    internal init(capacity : Int, v : Int) {
        self.V = v
        self.num_Vertex = capacity
        self.initVisitedArray()
        self.initFromArray()
    }
    
    public func hasPath(with w : Int) -> Bool {
        assert( w >= 0 && w < self.num_Vertex )
        return self.visited[w]
    }
    
    public func path(with w : Int) -> [Int] {
        assert( w >= 0 && w < self.num_Vertex )
        var path = [Int]()
        let s = BasicStack<Int>()
        var k = w
        while k != -1 {
            s.push(k)
            k = self.from[k]
        }
        while !s.isEmpty() {
            let top = s.top()!
            path.append(top)
            s.pop()
        }
        return path
    }
    
    public func showPath(with w : Int) {
        if w < 0 || w >= self.num_Vertex {
            return
        }
        let p = self.path(with: w)
        for i in 0 ..< p.count {
            print(p[i], separator: "", terminator: "")
            if i == p.count-1 {
                print()
            } else {
                print(" -> ", separator: "", terminator: "")
            }
        }
        print()
    }
    
    public func length(from w : Int) -> Int {
        return self.distance[w]
    }
    
    //深度优先遍历
    internal func dfsFromVertex(_ v : Int) { }
    
    //广度优先遍历
    internal func bfsFromVertex(_ v : Int) { }
    
    internal func initFromArray() {
        self.from = Array(repeating: -1, count: self.num_Vertex)
    }
    
    internal func initDistanceArray() {
        self.distance = Array(repeating: 0, count: self.num_Vertex)
    }
    
    internal func initVisitedArray() {
        self.visited = Array(repeating: false, count: self.num_Vertex)
    }
}
