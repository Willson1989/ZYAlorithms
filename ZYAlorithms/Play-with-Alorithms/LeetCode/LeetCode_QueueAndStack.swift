//
//  LeetCode_MyCircularQueue.swift
//  Play-with-Alorithms
//
//  Created by 郑毅 on 2019/2/14.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import Foundation

// MARK: -------------- 设计循环队列 leetCode #622
/*
 https://leetcode-cn.com/problems/design-circular-queue/
 设计你的循环队列实现。 循环队列是一种线性数据结构，其操作表现基于 FIFO（先进先出）原则并且队尾被连接在队首之后以形成一个循环。
 它也被称为“环形缓冲器”。
 
 循环队列的一个好处是我们可以利用这个队列之前用过的空间。在一个普通队列里，一旦一个队列满了，我们就不能插入下一个元素，即使在队列前面仍有空间。
 但是使用循环队列，我们能使用这些空间去存储新的值。
 
 你的实现应该支持如下操作：
    MyCircularQueue(k): 构造器，设置队列长度为 k 。
    Front: 从队首获取元素。如果队列为空，返回 -1 。
    Rear: 获取队尾元素。如果队列为空，返回 -1 。
    enQueue(value): 向循环队列插入一个元素。如果成功插入则返回真。
    deQueue(): 从循环队列中删除一个元素。如果成功删除则返回真。
    isEmpty(): 检查循环队列是否为空。
    isFull(): 检查循环队列是否已满。
 
    MyCircularQueue circularQueue = new MycircularQueue(3); // 设置长度为 3
    circularQueue.enQueue(1);  // 返回 true
    circularQueue.enQueue(2);  // 返回 true
    circularQueue.enQueue(3);  // 返回 true
    circularQueue.enQueue(4);  // 返回 false，队列已满
    circularQueue.Rear();      // 返回 3
    circularQueue.isFull();    // 返回 true
    circularQueue.deQueue();   // 返回 true
    circularQueue.enQueue(4);  // 返回 true
    circularQueue.Rear();      // 返回 4
 
 演示 ： https://leetcode-cn.com/explore/learn/card/queue-stack/216/queue-first-in-first-out-data-structure/864/
 */

class MyCircularQueue {
    
    fileprivate var EmptyElem : Int = -1
    fileprivate var data   : [Int]
    fileprivate var p_head : Int = -1
    fileprivate var p_tail : Int = -1
    fileprivate var count  : Int = 0
    
    /** Initialize your data structure here. Set the size of the queue to be k. */
    init(_ k: Int) {
        data = Array(repeating: EmptyElem, count: k)
        count = 0
        p_head = -1
        p_tail = -1
    }
    
    /** Insert an element into the circular queue. Return true if the operation is successful. */
    func enQueue(_ value: Int) -> Bool {
        if isFull() {
            print("en queue : \(value), queue is full")
            return false
        }
        if isEmpty() {
            p_head = 0
            p_tail = 0
        } else {
            p_tail += 1
            if p_tail >= data.count {
                p_tail = 0
            }
        }
        data[p_tail] = value
        count += 1
        return true
    }
    
    /** Delete an element from the circular queue. Return true if the operation is successful. */
    func deQueue() -> Bool {
        if isEmpty() {
            print("dequeue , queue is already empty")
            return false
        }
        data[p_head] = EmptyElem
        count -= 1
        if count == 0 {
            print("dequeue to empty")

            p_head = -1
            p_tail = -1
        } else {
            p_head += 1
            if p_head >= data.count {
                p_head = 0
            }
        }
        return true
    }
    
    /** Get the front item from the queue. */
    func Front() -> Int {
        if isEmpty() {
            return -1
        }
        return data[p_head]
    }
    
    /** Get the last item from the queue. */
    func Rear() -> Int {
        if isEmpty() {
            return -1
        }
        return data[p_tail]
    }
    
    /** Checks whether the circular queue is empty or not. */
    func isEmpty() -> Bool {
        return count == 0
    }
    
    /** Checks whether the circular queue is full or not. */
    func isFull() -> Bool {
        return count == data.count
    }
}

class MyCircularQueue_LeetCodeSolution {
    
    fileprivate var EmptyElem : Int = -1
    fileprivate var data  : [Int]
    fileprivate var head  : Int = -1
    fileprivate var tail  : Int = -1
    fileprivate var count : Int = 0
    fileprivate var size  : Int = 0
    
    /** Initialize your data structure here. Set the size of the queue to be k. */
    init(_ k: Int) {
        data  = Array(repeating: EmptyElem, count: k)
        count = 0
        size  = k
        head  = -1
        tail  = -1
    }
    
    /** Insert an element into the circular queue. Return true if the operation is successful. */
    func enQueue(_ value: Int) -> Bool {
        if isFull() {
            print("en queue : \(value), queue is full")
            return false
        }
        if isEmpty() {
            head = 0
        }
        tail = (tail + 1) % size
        data[tail] = value
        count += 1
        return true
    }
    
    /** Delete an element from the circular queue. Return true if the operation is successful. */
    func deQueue() -> Bool {
        if isEmpty() {
            print("dequeue , queue is already empty")
            return false
        }
        if head == tail {
            head = -1
            tail = -1
            return true
        }
        head = (head + 1) % size
        count = max(0 , count - 1)
        return true
    }
    
    /** Get the front item from the queue. */
    func Front() -> Int {
        if isEmpty() {
            return -1
        }
        return data[head]
    }
    
    /** Get the last item from the queue. */
    func Rear() -> Int {
        if isEmpty() {
            return -1
        }
        return data[tail]
    }
    
    /** Checks whether the circular queue is empty or not. */
    func isEmpty() -> Bool {
        return head == -1
    }
    
    /** Checks whether the circular queue is full or not. */
    func isFull() -> Bool {
        return ((tail + 1) % size) == head
    }
}

// MARK: -------------- 用栈实现队列 leetCode #232
/*
 https://leetcode-cn.com/problems/implement-queue-using-stacks/
 使用栈实现队列的下列操作：
 
 push(x) -- 将一个元素放入队列的尾部。
 pop() -- 从队列首部移除元素。
 peek() -- 返回队列首部的元素。
 empty() -- 返回队列是否为空。
 
 示例:
 MyQueue queue = new MyQueue();
 queue.push(1);
 queue.push(2);
 queue.peek();  // 返回 1
 queue.pop();   // 返回 1
 queue.empty(); // 返回 false
 
 说明:
 你只能使用标准的栈操作 -- 也就是只有 push to top, peek/pop from top, size, 和 is empty 操作是合法的。
 你所使用的语言也许不支持栈。你可以使用 list 或者 deque（双端队列）来模拟一个栈，只要是标准的栈操作即可。
 假设所有操作都是有效的 （例如，一个空的队列不会调用 pop 或者 peek 操作）。
 
 注意:
 数组的长度不会超过20，并且数组中的值全为正数。
 初始的数组的和不会超过1000。
 保证返回的最终结果为32位整数。
 */
class MyQueue_UsingStack {
    /*
     使用两个栈实现：
     每次要添加一个新元素的时候，先将s2的元素逐个pop并添加到s1中，然后将新元素push到s2中，
     之后再将s1中的元素重新pop回s2中，这样就保证了元素的顺序，s2中的栈顶元素就是队列的首元素。
     */
    var s1 = BasicStack<Int>()
    var s2 = BasicStack<Int>()

    
    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        while !s2.isEmpty() {
            s1.push(s2.top()!)
            s2.pop()
        }
        s2.push(x)
        while !s1.isEmpty() {
            s2.push(s1.top()!)
            s1.pop()
        }
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        let top = s2.top()
        s2.pop()
        return top ?? -1
    }
    
    /** Get the front element. */
    func peek() -> Int {
        return s2.top() ?? -1
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return s2.isEmpty()
    }
}

// MARK: -------------- 用队列实现栈 leetCode #225
/*
 https://leetcode-cn.com/problems/implement-stack-using-queues/
 使用队列实现栈的下列操作：
 
 push(x) -- 元素 x 入栈
 pop() -- 移除栈顶元素
 top() -- 获取栈顶元素
 empty() -- 返回栈是否为空
 注意:
 
 你只能使用队列的基本操作-- 也就是 push to back, peek/pop from front, size, 和 is empty 这些操作是合法的。
 你所使用的语言也许不支持队列。 你可以使用 list 或者 deque（双端队列）来模拟一个队列 , 只要是标准的队列操作即可。
 你可以假设所有操作都是有效的（例如, 对一个空的栈不会调用 pop 或者 top 操作）。
 */
class MyStack_UsingQueue {
    
    var queue1 = BasicQueue<Int>()
    var queue2 = BasicQueue<Int>()
    
    /** Push element x onto stack. */
    func push(_ x: Int) {
        while !queue2.isEmpty() { //先腾出地方
            queue1.enqueue(queue2.front()!)
            queue2.dequeue()
        }
        queue2.enqueue(x)
        while !queue1.isEmpty() {
            queue2.enqueue(queue1.front()!)
            queue1.dequeue()
        }
    }
    
    /** Removes the element on top of the stack and returns that element. */
    func pop() -> Int {
        let front = queue2.front()
        queue2.dequeue()
        return front ?? -1
    }
    
    /** Get the top element. */
    func top() -> Int {
        return queue2.front() ?? -1
    }
    
    /** Returns whether the stack is empty. */
    func empty() -> Bool {
        return queue2.isEmpty()
    }
}


// MARK: -------------- 最小栈 leetCode #155
/*
 https://leetcode-cn.com/problems/implement-stack-using-queues/
 设计一个支持 push，pop，top 操作，并能在常数时间内检索到最小元素的栈。
 
 push(x) -- 将元素 x 推入栈中。
 pop() -- 删除栈顶的元素。
 top() -- 获取栈顶元素。
 getMin() -- 检索栈中的最小元素。
 示例:
 
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin();   --> 返回 -3.
 minStack.pop();
 minStack.top();      --> 返回 0.
 minStack.getMin();   --> 返回 -2.
 */
class MinStack {
    
    fileprivate var minItems = [Int]()
    fileprivate var data = [Int]()
    
    func push(_ x: Int) {
        if data.isEmpty {
            minItems.append(x)
            data.append(x)
        } else {
            data.append(x)
            if x <= minItems.last! {
                minItems.append(x)
            }
        }
    }
    
    func pop() {
        if data.isEmpty {
            return
        }
        let last = data.last!
        let min  = minItems.last!
        if last == min {
            minItems.removeLast()
        }
        data.removeLast()
    }
    
    func top() -> Int {
        if data.isEmpty {
            return -1
        }
        return data.last!
    }
    
    func getMin() -> Int {
        if minItems.isEmpty {
            return Int.min
        }
        return minItems.last!
    }
}
