//
//  Graph_Weighted.swift
//  Play-with-Alorithms
//
//  Created by ZhengYi on 2017/6/14.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

//import UIKit
import Foundation

// 链表实现邻接表时，顶点的数据结构
internal class Vertex {
    
    public var v : Int = -1
    public var firstArc : Edge? = nil
    
    init(vertex : Int) {
        self.v = vertex
        self.firstArc = nil
    }
}

// 有权图的边
public class Edge : Comparable , Equatable{
    
    internal var from : Int = INFINITY
    internal var to   : Int = INFINITY
    internal var weight :  Float = 0.0
    internal var next : Edge? = nil
    
    init(a : Int, b : Int, weight : Float) {
        self.from = a
        self.to = b
        self.weight = weight
    }
    
    init() {
        from = INFINITY
        to = INFINITY
        weight = 0.0
    }
    
    //指定一个顶点，返回与之连接的另一个顶点
    public func other(_ v : Int) -> Int {
        if v == from {
            return to
        } else {
            return from
        }
    }
    
    public func V() -> Int {
        return self.from
    }
    
    public func W() -> Int {
        return self.to
    }
    
    public func wt() -> Float {
        return self.weight
    }
    
    public static func < (l : Edge, r : Edge) -> Bool {
        return l.weight < r.weight
    }
    
    public static func <= (l : Edge, r : Edge) -> Bool {
        return l.weight <= r.weight
    }
    
    public static func > (l : Edge, r : Edge) -> Bool {
        return l.weight > r.weight
    }
    
    public static func >= (l : Edge, r : Edge) -> Bool {
        return l.weight >= r.weight
    }
    
    public static func == (l : Edge, r : Edge) -> Bool {
        return l.weight == r.weight
    }
}

public class Graph_Weighted : Graph {

    public func addEdge(_ v : Int, _ w : Int, weight : Float) { }
}


///*
// 最小生成树
//    一个图可以生成最小生成树的前提是这个图是连通的
// 
// 切分定理：
//    将一个图分成两个部分（一部分节点为蓝色，一部分节点为红色）
//    连接两个部分的节点的边被称为 横切边。（即这个边的两个节点一个是红色一个是蓝色）
//    在多个横切边中权值最小的边一定是这个图的最小生成树的一条边
// */
////MARK: - 最小生成树
//public class MST {
//    
//    internal var capacity : Int = 0
//    
//    //用来存储最小生成树的边
//    internal var mstArray : [Edge] = []
//    
//    // 最小生成树的边的权值的总和
//    internal var mstTotalWeight : Float = 0.0
//    
//    // 如果一个节点被访问（变成红色）那么指定索引的元素值为true
//    internal var marked : [Bool] = []
//    
//    public init(capacity : Int) {
//        self.capacity = capacity
//        self.marked = Array(repeating: false, count: capacity)
//    }
//    
//    // 返回最小生成树的总权值
//    public func result() -> Float {
//        return mstTotalWeight
//    }
//    
//    // 返回存储最小生成树中所有的边的数组
//    public func mstEdges() -> [Edge?] {
//        return mstArray
//    }
//    
//    // 打印最小生成树
//    public func showMST() {
//        if mstArray.isEmpty {
//            print("无最小生成树")
//            return
//        }
//        print("最小生成树 ： ", separator: "", terminator: "\n")
//        for i in 0 ..< mstArray.count {
//            let e = mstArray[i]
//            print("[ \(e.V()) , \(e.W()) ], weight : \(e.wt())")
//        }
//        print("总权值 ： \(result())")
//    }
//    
//    // Lazy Prim 和 Prim 算法中用来访问节点v（用不同存储结构实现的图中需要重写该方法）
//    internal func visit(_ v : Int) { }
//}
//
////MARK: - MST_LazyPrim
//public class MST_LazyPrim : MST{
//    
//    // Lazy Prim 算法，用来存储横切边
//    internal var pq : IndexMinHeap<Edge>!
//    
//    public override init(capacity : Int) {
//        super.init(capacity: capacity)
//        pq = IndexMinHeap(capacity: capacity)
//        marked = Array(repeating: false, count: capacity)
//    }
//    
//    //Lazy Prim
//    internal func GenericMST_lazyPrim() {
//        //从第一个节点开始访问
//        visit(0)
//        while pq.isEmpty() == false {
//            //取出最小权值的边
//            let e = pq.extractMin()!
//            //如果边的两个顶点都是红色，说明不是横切边,弃用
//            if marked[e.V()] == marked[e.W()] {
//                continue
//            }
//            mstArray.append(e)
//            if marked[e.V()] == true {
//                visit(e.W())
//            } else {
//                visit(e.V())
//            }
//        }
//        //计算总权值
//        for i in 0 ..< mstArray.count {
//            let e = mstArray[i]
//            mstTotalWeight += e.weight
//        }
//    }
//}
//
////MARK: - MST_Prim
//public class MST_Prim : MST {
//    
//    public class Weight : Comparable, Equatable {
//        
//        public var vertex : Int   = -1
//        public var weight : Float = 0.0
//        
//        public init(vertex : Int, weight : Float) {
//            self.vertex = vertex
//            self.weight = weight
//        }
//        
//        public static func < (l : MST_Prim.Weight, r : MST_Prim.Weight) -> Bool {
//            return l.weight < r.weight
//        }
//        
//        public static func <= (l : MST_Prim.Weight, r : MST_Prim.Weight) -> Bool {
//            return l.weight <= r.weight
//        }
//        
//        public static func > (l : MST_Prim.Weight, r : MST_Prim.Weight) -> Bool {
//            return l.weight > r.weight
//        }
//        
//        public static func >= (l : MST_Prim.Weight, r : MST_Prim.Weight) -> Bool {
//            return l.weight >= r.weight
//        }
//        
//        public static func == (l : MST_Prim.Weight, r : MST_Prim.Weight) -> Bool {
//            return l.weight == r.weight
//        }
//    }
//    
//    // Prim 算法 用来存储节点对应的最小权值的横切边的权值
//    internal var ipq : IndexMinHeap<Float>!
//    internal var h : IndexMinHeap<MST_Prim.Weight>!
//    
//    // Prim 算法 用来存储和节点相连的最小权值的横切边对象
//    internal var edgeTo : [Edge?] = []
//    
//    public override init(capacity : Int) {
//        super.init(capacity: capacity)
//        edgeTo = Array(repeating: nil, count: capacity)
//        ipq = IndexMinHeap(capacity: capacity)
//        h = IndexMinHeap(capacity: capacity)
//    }
//    
//    internal func GenericMST_Prim() {
//        visit(0)
//        while !h.isEmpty() {
//            if let minWeight = h.extractMin() {
//                if let minE = edgeTo[minWeight.vertex] {
//                    mstArray.append(minE)
//                    visit(minWeight.vertex)
//                }
//            }
//        }
//        for i in 0 ..< self.mstArray.count {
//            mstTotalWeight += mstArray[i].wt()
//        }
//    }
//}
//
////MARK: - MST_Kruskal
//public class MST_Kruskal : MST {
//    
//    internal func GenericMST_Kruskal() { }
//    
//}
//=======
//>>>>>>> d5aa68c09de37db8674d0350cb0aabeb37b0a882



