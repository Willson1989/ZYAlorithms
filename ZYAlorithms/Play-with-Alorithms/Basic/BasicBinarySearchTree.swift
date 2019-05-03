//
//  BasicBinarySearchTree.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2019/3/11.
//  Copyright © 2019年 ZhengYi. All rights reserved.
//

import Foundation

class TreeNode<V> : NSObject{
    
    var val : V
    var left : TreeNode?
    var right : TreeNode?
    
    init( _ val : V) {
        self.val = val
    }
}


class TNode<K : Comparable & Equatable, V> {
    var key : K
    var val : V
    var left : TNode<K,V>?
    var right : TNode<K,V>?

    init(key : K, value : V) {
        self.val = value
        self.key = key
    }
}

struct BasicBinarySearchTree<K : Comparable & Equatable, V> {
    
    typealias Node = TNode<K,V>
    typealias SearchHandler = (_ node : Node?) -> ()
    
    private(set) var root : Node?
    
    public mutating func insert(key : K, value : V) {
        self.root = _insert(node: root, key: key, value: value)
    }
    
    public mutating func delete(key : K) {
        root = _delete(root, key: key)
    }
    
    private mutating func _delete(_ node : Node?, key : K) -> Node? {

        guard let node = node else {
            return nil
        }
        
        if key < node.key {
            node.left = _delete(node.left, key: key)
            return node
            
        } else if key > node.key {
            node.right = _delete(node.right, key: key)
            return node
            
        } else {
            if node.left == nil {
                let right = node.right
                return right
            }
            
            if node.right == nil {
                let left = node.left
                return left
            }
            
            let tmp = _getMinKeyNode(node.right)!
            let newNode = Node(key: tmp.key, value: tmp.val)
            newNode.left = node.left
            newNode.right = _deleteMinNode(node.right)
            return newNode
        }
    }
    
    
    public mutating func deleteMax() {
        root = _deleteMaxNode(root)
    }
    
    private mutating func _deleteMaxNode(_ node : Node?) -> Node? {
        if node == nil {
            return nil
        }
        
        if node?.right == nil {
            let left = node?.left
            return left
        }
        node?.right = _deleteMaxNode(node?.right)
        return node
    }
    
    public mutating func deleteMin() {
        root = _deleteMinNode(root)
    }
    
    private mutating func _deleteMinNode(_ node : Node?) -> Node? {
        if node == nil {
            return nil
        }
        if node?.left == nil {
            let right = node?.right
            return right
        }
        node?.left = _deleteMinNode(node?.left)
        return node
    }
    
    
    
    public func search(key : K) -> Node? {
        return _search(root, key)
    }
    
    private func _search(_ node : Node?, _ key : K) -> Node? {
        guard let node = node else {
            return nil
        }
        if node.key == key {
            return node
        }
        else if node.key > key {
            return _search(node.left, key)
        }
        else {
            return _search(node.right, key)
        }
    }
    
    public func contain(_ key : K) -> Bool {
        return self.search(key: key) != nil
    }
    
    public func minKeyNode() -> Node? {
        return _getMinKeyNode(root)
    }
    
    private func _getMinKeyNode(_ node : Node?) -> Node? {
        if node?.left == nil {
            return node
        }
        return _getMinKeyNode(node?.left)
    }
    
    public func maxKeyNode() -> Node? {
        return _getMaxKeyNode(root)
    }
    
    private func _getMaxKeyNode(_ node : Node?) -> Node? {
        if node?.right == nil {
            return node
        }
        return _getMaxKeyNode(node?.right)
    }
    
    public func floor(_ key : K) -> Node? {
        return _floor(root, key)
    }
    
    private func _floor(_ node : Node?, _ key : K) -> Node? {
        
        guard let node = node else {
            return nil
        }
        
        if key == node.key {
            return node
        }
        else if key < node.key {
            return _floor(node.left, key)
        }
        else {
            let right = _floor(node.right, key)
            if right != nil {
                return right!
            } else {
                return node
            }
        }
    }
    
    public func ceil(_ key : K) -> Node? {
        return _ceil(root, key)
    }
    
    private func _ceil(_ node : Node?, _ key : K) -> Node? {
        
        guard let node = node else {
            return nil
        }
        
        if node.key == key {
            return node
        }
        else if node.key < key {
            return _ceil(node.right, key)
        }
        else {
            let left = _ceil(node.left, key)
            if left != nil {
                return left
            } else {
                return node
            }
        }
    }
    
    private mutating func _insert(node : Node?, key : K, value : V) -> Node {
        guard let node = node else {
            let n = Node(key: key, value: value)
            return n
        }
        
        if key == node.key {
            node.val = value
            return node
        }
        else if key < node.key {
            node.left = _insert(node: node.left, key: key, value: value)
        } else {
            node.right = _insert(node: node.right, key: key, value: value)
        }
        return node
    }
    
    
    public func preOrder(_ block : SearchHandler) {
        guard let root = self.root else {
            block(nil)
            return
        }
        var p : Node? = root
        let s = BasicStack<Node>()

        while p != nil || !s.isEmpty() {
            if p != nil {
                block(p)
                s.push(p!)
                p = p!.left
                
            } else {
                let top = s.top()!
                s.pop()
                p = top.right
            }
        }
    }
    
    
    public func inOrder(_ block : SearchHandler) {
        guard let root = self.root else {
            block(nil)
            return
        }
        var p : Node? = root
        let s = BasicStack<Node>()
        while p != nil || !s.isEmpty() {
            if p != nil {
                s.push(p!)
                p = p?.left
            } else {
                let top = s.top()!
                s.pop()
                block(top)
                p = top.right
            }
        }
    }
    
    public func postOrder(_ block : SearchHandler) {
        guard let root = self.root else {
            block(nil)
            return
        }
        var last : Node? = root
        let s = BasicStack<Node>()
        s.push(root)
        
        while !s.isEmpty() {
            let t = s.top()!
            if (t.left == nil && t.right == nil) || ( (t.right == nil && last === t.left) || (last === t.right)) {
                last = t
                block(t)
                s.pop()
            } else {
                if t.right != nil {
                    s.push(t.right!)
                }
                if t.left != nil {
                    s.push(t.left!)
                }
            }
        }
    }
    
}
