//
//  BSTree.swift
//  TempProj
//
//  Created by WillHelen on 2018/8/11.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

//class TreeNode<T> : NSObject{
//    
//    var val : T
//    var left : TreeNode?
//    var right : TreeNode?
//    
//    init( _ val : T) {
//        self.val = val
//    }
//}

class BSTree_Int {
    
    typealias NodeType = TreeNode<Int>
    
    class Queue {
        var left = [NodeType]()
        var right = [NodeType]()
        var isEmpty : Bool {
            return self.left.isEmpty && self.right.isEmpty
        }
        
        func enqueue(_ e : NodeType?) {
            if let e = e {
                right.append(e)
            }
        }
        
        func dequeue() -> NodeType? {
            if left.isEmpty {
                left = right.reversed()
                right.removeAll()
            }
            return left.popLast()
        }
        
        func front() -> NodeType? {
            if self.isEmpty {
                return nil
            }
            return left.last
        }
    }
    
    var root : NodeType?
    
    init() {
        self.root = nil
    }
    
    convenience init (arrangeWithArray a : [Int?]) {
        self.init()
        if a.isEmpty {
            return
        }
        var a = a
        self.root = TreeNode(a[0]!)
        a.remove(at: 0)
        let q = Queue()
        q.enqueue(self.root)
        while !q.isEmpty {
            let node = q.dequeue()!
            if node.left == nil {
                if a.isEmpty {
                    return
                }
                let num = a[0]
                node.left = num == nil ? nil : TreeNode(num!)
                q.enqueue(node.left)
                a.remove(at: 0)
            }
            if node.right == nil {
                if a.isEmpty {
                    return
                }
                let num = a[0]
                node.right = num == nil ? nil : TreeNode(num!)
                q.enqueue(node.right)
                a.remove(at: 0)
            }
        }
    }
    
    convenience init (array : [Int]) {
        self.init()
        for i in 0 ..< array.count {
            let node = TreeNode(array[i])
            insert(node)
        }
    }
    
    func deep(_ root : NodeType?) -> Int {
//        if root == nil {
//            return 0
//        }
//        return max(deep(root?.left), deep(root?.right)) + 1
        return BSTree_Int.deep(withNode: self.root)
    }
    
    class func deep(withNode node : NodeType?) -> Int {
        if node == nil {
            return 0
        }
        return max(deep(withNode: node?.left), deep(withNode: node?.right)) + 1
    }
    
    func insert(_ node : NodeType?) {
        if let node = node {
            self.root = _insert(root: self.root, node: node)            
        }
    }
    
    private func _insert(root : NodeType?, node : NodeType) -> NodeType?{
        
        if root == nil {
            return node
        }
        
        let r = root!
        
        if node.val < r.val {
            r.left = _insert(root: r.left, node: node)
        } else {
            r.right = _insert(root: r.right, node: node)
        }
        
        return r
    }
    
    func prevEnumTree(_ node : NodeType?) {
        if let node = node {
            print(node.val, separator: "", terminator: ", ")
            prevEnumTree(node.left)
            prevEnumTree(node.right)
        }
    }
    
    func middleEnumTree(_ node : NodeType?) {
        if let node = node {
            middleEnumTree(node.left)
            print(node.val, separator: "", terminator: ", ")
            middleEnumTree(node.right)
        }
    }
    
    func postEnumTree(_ node : NodeType?) {
        if let node = node {
            postEnumTree(node.left)
            postEnumTree(node.right)
            print(node.val, separator: "", terminator: ", ")
        }
    }
    
    func bfs(_ node : NodeType?, enumHandler:(NodeType) -> ()) {
        if let node = node {
            let q = Queue()
            q.enqueue(node)
            while q.isEmpty == false {
                
                let tmp = q.dequeue()!
                enumHandler(tmp)
                
                if let left = tmp.left {
                    q.enqueue(left)
                }
                if let right = tmp.left {
                    q.enqueue(right)
                }
                
            }
        }
    }
}




