//
//  SourceShortestPath.swift
//  Play-with-Alorithms
//
//  Created by ZhengYi on 2017/6/23.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import Foundation


public let INFINITY_WEIGHT : Float = 65536.0

//MARK: - Dijkstra 单源最短路径
public class ShortestPath_Dijkstra {
    
    internal var s : Int = -1
    internal var capacity : Int = 0
    internal var pq : IndexHeap<Float>!
    internal var distTo : [Float] = []
    internal var marked : [Bool]  = []
    internal var from   : [Edge?] = []
    
    public init(source : Int, capacity : Int) {
        self.s = source
        self.capacity = capacity
        marked = Array(repeating: false, count: capacity)
        distTo = Array(repeating: INFINITY_WEIGHT,   count: capacity)
        from = Array(repeating: nil, count: capacity)
        pq = IndexHeap(capacity: capacity, type: .min)
    }
    
    internal func dijkstraPath() { }
    
    public func pathWeight(to w : Int) -> Float {
        if w < 0 || w >= capacity {
            return 0.0
        }
        return self.distTo[w]
    }
    
    public func path(to w : Int) -> [Edge]? {
        if w < 0 || w >= capacity {
            return nil
        }
        
        let stack = BasicStack<Edge>()
        var path = [Edge]()
        let edge = from[w]
        if edge == nil {
            return nil
        }
        var e = edge!
        while e.V() != s {
            stack.push(e)
            e = from[e.V()]!
        }
        stack.push(e)
        while !stack.isEmpty() {
            let e = stack.top()!
            path.append(e)
            stack.pop()
        }
        return path
    }
    
    public func showPath(to w : Int) {
        if let path = self.path(to: w) {
            print("Shortest Path from \(s) to \(w) : ")
            for i in 0 ..< path.count {
                let e = path[i]
                print(e.V(), separator: "", terminator: "")
                if i == path.count - 1 {
                    print(" -> \(w)", separator: "", terminator: "\n")
                } else {
                    print(" -> ", separator: "", terminator: "")
                }
            }
            print("Total weight : \(pathWeight(to: w))")
        } else {
            print("No path to \(w)")
        }
    
    }
    
    
    
}
