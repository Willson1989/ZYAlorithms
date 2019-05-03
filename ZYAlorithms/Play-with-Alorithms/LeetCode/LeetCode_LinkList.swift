//
//  LeetCode_LinkList.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2019/3/15.
//  Copyright © 2019年 ZhengYi. All rights reserved.
//

import Foundation


// MARK: - 单向链表
class MyLinkedList {
    
    class Node {
        var val : Int
        var next : MyLinkedList.Node?
        init(_ val : Int) {
            self.val = val
        }
    }
    
    var head : Node?
    var tail : Node?
    var size : Int = 0
    
    /** Initialize your data structure here. */
    init() { }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    func get(_ index: Int) -> Int {
        if index < 0 || index >= self.size {
            return -1
        }
        var i = 0
        var p = self.head
        while p != nil && i < size {
            if i == index {
                return p!.val
            }
            p = p?.next
            i+=1
        }
        return -1
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        let node = Node(val)
        guard let head = self.head else {
            self.head = node
            self.tail = node
            self.size += 1
            return
        }
        node.next = head
        self.head = node
        self.size += 1
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        let node = Node(val)
        guard let tail = self.tail else {
            self.head = node
            self.tail = node
            self.size += 1
            return
        }
        tail.next = node
        self.tail = node
        self.size += 1
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    func addAtIndex(_ index: Int, _ val: Int) {
        guard index >= 0, index <= self.size else {
            return
        }
        if self.size == 0 {
            self.addAtTail(val)
            return
        }
        var p = self.head
        var i = 0
        while i <= self.size {
            if i == index-1 {
                let node = Node(val)
                let currNext = p?.next
                p?.next = node
                node.next = currNext
                if index == self.size {
                    self.tail = node
                }
                self.size += 1
                return
            }
            p = p?.next
            i+=1
        }
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
    func deleteAtIndex(_ index: Int) {
        if index < 0 || index >= self.size {
            return
        }
        if index == 0 {
            let newHead = head?.next
            self.head = newHead
            return
        }
        var i = 0
        var p = head
        while i < self.size {
            if i == index - 1 {
                if index == self.size - 1{
                    self.tail = p
                }
                let nodeToDel = p?.next
                let newNext = p?.next?.next
                p?.next = newNext
                nodeToDel?.next = nil
                self.size -= 1
                return
            }
            i+=1
            p = p?.next
        }
    }
    
    func printList() {
        guard let head = self.head else {
            print("list is empty")
            return
        }
        var p : Node? = head
        while p != nil {
            print("\(p!.val)", separator: "", terminator: p === self.tail ? "" : " - ")
            p = p?.next
        }
        print()
    }
}

// MARK: - 双向链表
class MyLinkedList_Double {
    
    class Node {
        var val : Int
        var prev : Node?
        var next : Node?
        init(_ val : Int) {
            self.val = val
        }
    }
    
    var head : Node?
    var tail : Node?
    var size : Int = 0
    
    /** Initialize your data structure here. */
    init() { }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    func get_1(_ index: Int) -> Int {
        if index < 0 || index >= self.size {
            return -1
        }
        var i = 0
        var p = self.head
        while p != nil && i < size {
            if i == index {
                return p!.val
            }
            p = p?.next
            i+=1
        }
        return -1
    }
    
    func get(_ index: Int) -> Int {
        if index < 0 || index >= self.size {
            return -1
        }
        var p : Node?
        if index > self.size / 2 {
            // 从后往前搜索
            p = self.tail
            for _ in stride(from: size-1, to: index, by: -1) {
                p = p?.prev
            }
            
        } else {
            // 从前往后搜索
            p = self.head
            for _ in 0 ..< index {
                p = p?.next
            }
        }
        return p!.val
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        guard let head = self.head else {
            let node = Node(val)
            self.head = node
            self.tail = node
            self.size += 1
            return
        }
        
        let node = Node(val)
        node.next = head
        head.prev = node
        self.head = node
        self.size += 1
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        guard let tail = self.tail else {
            let node = Node(val)
            self.head = node
            self.tail = node
            self.size += 1
            return
        }
        let node = Node(val)
        tail.next = node
        node.prev = tail
        self.tail = node
        self.size += 1
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
//    func addAtIndex(_ index: Int, _ val: Int) {
//        if index < 0 || index > self.size {
//            return
//        }
//        if self.size == 0 {
//            self.addAtTail(val)
//            return
//        }
//        var p = self.head
//        var i = 0
//        while i < self.size {
//            if i == index - 1 {
//                let node = Node(val)
//                let next = p?.next
//                p?.next = node
//                node.prev = p
//                node.next = next
//                next?.prev = node
//                if index == self.size {
//                    self.tail = node
//                }
//                self.size += 1
//                return
//            }
//            p = p?.next
//            i += 1
//        }
//    }
    
    func addAtIndex(_ index: Int, _ val: Int) {
        if index < 0 || index > self.size {
            return
        }
        if index == self.size {
            self.addAtTail(val)
            return
        } else if index == 0 {
            self.addAtHead(val)
            return
        }
        
        var p : Node?
        if index > self.size / 2 {
            p = self.tail
            for _ in stride(from: size-1, to: index, by: -1) {
                p = p?.prev
            }
        } else {
            p = self.head
            for _ in 0 ..< index {
                p = p?.next
            }
        }
        let node = Node(val)
        p?.prev?.next = node
        node.prev = p?.prev
        node.next = p
        p?.prev = node
        self.size += 1
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
//    func deleteAtIndex(_ index: Int) {
//        if index < 0 || index >= self.size {
//            return
//        }
//        var i = 0
//        var p = self.head
//        while i < self.size {
//            if i == index {
//                let prev = p?.prev
//                let next = p?.next
//                if index == 0 {
//                    self.head = next
//                }
//                if index == self.size - 1 {
//                    self.tail = prev
//                }
//                prev?.next = next
//                next?.prev = prev
//                p?.prev = nil
//                p?.next = nil
//                self.size -= 1
//                return
//            }
//            p = p?.next
//            i += 1
//        }
//    }
    
    func deleteAtIndex(_ index: Int) {
        if index < 0 || index >= self.size {
            return
        }
        var p : Node?
        if index > self.size / 2 {
            p = self.tail
            for _ in stride(from: self.size - 1, to: index, by: -1) {
                p = p?.prev
            }
        } else {
            p = self.head
            for _ in 0 ..< index {
                p = p?.next
            }
        }
        p?.prev?.next = p?.next
        p?.next?.prev = p?.prev
        if index == self.size - 1{
            self.tail = p?.prev
        }
        if index == 0 {
            self.head = p?.next
        }
        self.size -= 1
    }
    
    func printList() {
        guard let head = self.head else {
            print("list is empty")
            return
        }
        var p : Node? = head
        while p != nil {
            print("\(p!.val)", separator: "", terminator: p === self.tail ? "" : " - ")
            p = p?.next
        }
        print()
    }
}

