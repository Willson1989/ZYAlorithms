//
//  Solution_06.swift
//  Play-with-Alorithms
//
//  Created by 郑毅 on 2019/2/19.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import Foundation

/*
 二叉树的遍历
 参考：https://www.cnblogs.com/llguanli/p/7363657.html
 */
extension Solution {
    
    typealias NodeType = TreeNode<Int>
    // MARK: -------------- 二叉树的前序遍历 leetCode #144
    /*
     https://leetcode-cn.com/problems/binary-tree-preorder-traversal/
     */
    func preorderTraversal(_ root: NodeType?) -> [Int] {
        return _preorderTraversal_iteratoration(root)
    }
    
    // MARK: 前序遍历 非递归解法
    func _preorderTraversal_iteratoration(_ root: NodeType?) -> [Int] {
        var res = [Int]()
        let stk = BasicStack<NodeType>()
        var pNode : NodeType? = root
        while pNode != nil || !stk.isEmpty() {
            if let p = pNode {
                res.append(p.val)
                stk.push(p)
                pNode = p.left
                
            } else {
                let topNode = stk.top()!
                stk.pop()
                pNode = topNode.right
            }
        }
        return res
    }
    
    // MARK: 前序遍历 递归解法
    func _preorderTraversal_recursion(_ root: NodeType?) -> [Int] {
        var res = [Int]()
        __preorderTraversal_recursion(root, res: &res)
        return res
    }
    
    private func __preorderTraversal_recursion(_ node : NodeType?, res : inout [Int]) {
        if node == nil {
            return
        }
        res.append(node!.val)
        __preorderTraversal_recursion(node?.left, res: &res)
        __preorderTraversal_recursion(node?.right, res: &res)
    }
    
    // MARK: -------------- 二叉树的中序遍历 leetCode #94
    /*
     https://leetcode-cn.com/problems/binary-tree-inorder-traversal/
     */
    func inorderTraversal(_ root: NodeType?) -> [Int] {
        return _inorderTraversal_recursion(root)
    }
    
    // MARK: 中序遍历 非递归解法
    private func _inorderTraversal_iteratoration(_ root : NodeType?) -> [Int] {
        guard let root = root else { return [] }
        var pNode : NodeType? = root
        let stk = BasicStack<NodeType>()
        var res = [Int]()
        while pNode != nil || !stk.isEmpty() {
            if let p = pNode {
                stk.push(p)
                pNode = p.left
                
            } else { // pNode == nil
                let topNode = stk.top()!
                stk.pop()
                res.append(topNode.val)
                pNode = topNode.right
            }
        }        
        return res
    }
    
    // MARK: 中序遍历 递归解法
    private func _inorderTraversal_recursion(_ root : NodeType?) -> [Int] {
        var res = [Int]()
        __inorderTraversal_recursion(root, res: &res)
        return res
    }
    
    private func __inorderTraversal_recursion(_ node : NodeType?, res : inout [Int]) {
        if node == nil {
            return
        }
        __inorderTraversal_recursion(node!.left, res: &res)
        res.append(node!.val)
        __inorderTraversal_recursion(node!.right, res: &res)
    }
    
    
    // MARK: -------------- 二叉树的后序遍历 leetCode #145
    /*
     https://leetcode-cn.com/problems/binary-tree-postorder-traversal/
     */
    func postorderTraversal(_ root: NodeType?) -> [Int] {
        //return _postorderTraversal_recursion(root)
        return _postorderTraversal_iteratoration(root)
    }
    
    //MARK: 后序遍历 非递归解法：
    /*
     对于后序遍历，需要注意的一点是：
     对于一个结点p，要保证它的左子树和右子树都被访问过之后才能访问结点它自己，并且左子树是要先于右子树被访问的。
     对于先左后右的顺序，这里可以使用栈的数据结构来解决。还有对于当前的结点p，会有有以下几种处理情况：
        1. 结点p的左子树和右子树都没访问过，那么以右子树，左子树的顺序入栈
        2. 结点p是叶子结点，那么直接输出结点p
        3. 结点p的子树都被访问过了，输出结点p
     如何确定结点p的左右子树都被访问过呢？
     这里可以使用一个last变量来保存最后访问过的结点，
     那么如果 p.right == nil && last == p.left 或者 last == p.right 那么这个结点p的左右子树就都一定被访问过了。
     这里对上面的判断条件进行一下说明（假设p结点的左右子树都已经被访问过，并且last是最后被访问过的结点）：
        如果p的右子树不为nil，那么p的右子树一定是last（last == p.right）。
        如果p的右子树为nil，那么最后被访问过的结点就一定是左子树。
     参考：
     https://www.cnblogs.com/rain-lei/p/3705680.html
     */
    private func _postorderTraversal_iteratoration(_ root: NodeType?) -> [Int] {
        guard let root = root else {
            return []
        }
        var res = [Int]()
        let stk = BasicStack<NodeType>()
        var pNode = root
        var last = root
        stk.push(pNode)
        while !stk.isEmpty() {
            pNode = stk.top()!
            if ( pNode.left == nil && pNode.right == nil ) || // p是叶子结点
               ( pNode.right == nil && pNode.left === last ) || pNode.right === last  // p的左右子树都被访问过了
            {
                res.append(pNode.val)
                last = pNode
                stk.pop()
                
            } else {
                // p 不是叶子结点，并且p的左右子树都没有被访问过，**那么以右子树，左子树的顺序入栈**
                if let right = pNode.right {
                    stk.push(right)
                }
                if let left = pNode.left {
                    stk.push(left)
                }
            }
        }
        return res
    }
    
    // MARK: 后序遍历 递归解法：
    private func _postorderTraversal_recursion(_ root: NodeType?) -> [Int] {
        var res = [Int]()
        __postorderTraversal_recursion(root, res: &res)
        return res
    }
    
    private func __postorderTraversal_recursion(_ node : NodeType?, res : inout [Int]) {
        guard let node = node else {
            return
        }
        __postorderTraversal_recursion(node.left, res: &res)
        __postorderTraversal_recursion(node.right, res: &res)
        res.append(node.val)
    }
    
    
    
    func searchBST(_ root: TreeNode<Int>?, _ val: Int) -> TreeNode<Int>? {
        
        guard let root = root else {
            return nil
        }
        
        if val == root.val {
            return root
        }
        else if val < root.val {
            return searchBST(root.left, val)
        }
        else {
            return searchBST(root.right, val)
        }
    }
    
    // MARK: -------------- 验证二叉搜索树 leetCode #98
    /*
     https://leetcode-cn.com/problems/validate-binary-search-tree/
     给定一个二叉树，判断其是否是一个有效的二叉搜索树。 假设一个二叉搜索树具有如下特征：
     1. 节点的左子树只包含小于当前节点的数。
     2. 节点的右子树只包含大于当前节点的数。
     3. 所有左子树和右子树自身必须也是二叉搜索树。
     
     示例 1:
     输入:
       2
      / \
     1   3
     输出: true
     
     示例 2:
     输入:
       5
      / \
     1   4
        / \
       3   6
     输出: false
     解释: 输入为: [5,1,4,null,null,3,6]。
     根节点的值为 5 ，但是其右子节点值为 4 。
     */
    func isValidBST(_ root: TreeNode<Int>?) -> Bool {
        
        // 二叉搜索树的中序遍历是严格递增的
        func inOrder(_ root : TreeNode<Int>?, res : inout [Int]) {
            guard let root = root else {
                return
            }
            inOrder(root.left, res: &res)
            res.append(root.val)
            inOrder(root.right, res: &res)
        }
        guard let root = root else {
            return true
        }
        var tmp = [Int]()
        inOrder(root, res: &tmp)
        for i in 0 ..< tmp.count-1 {
            if tmp[i] >= tmp[i+1] {
                return false
            }
        }
        return true
    }
    
    
    func isValidBST_1(_ root: TreeNode<Int>?) -> Bool {
        guard let r = root else {
            return true
        }
        if r.left == nil && r.right == nil {
            return true
        }
        else {
            var leftValid = true
            var rightValid = true
            if r.left != nil {
                leftValid = r.val > r.left!.val && isValidBST(r.left)
            }
            if r.right != nil {
                rightValid = r.val < r.right!.val && isValidBST(r.right)
            }
            return leftValid && rightValid
        }
    }

    // MARK: -------------- 修剪二叉搜索树 leetCode #669
    /*
     https://leetcode-cn.com/problems/trim-a-binary-search-tree/
     给定一个二叉搜索树，同时给定最小边界L 和最大边界 R。通过修剪二叉搜索树，使得所有节点的值在[L, R]中 (R>=L) 。
     你可能需要改变树的根节点，所以结果应当返回修剪好的二叉搜索树的新的根节点。
     
     示例 1:
     输入:
       1
      / \
     0   2
     L = 1
     R = 2
     输出:
       1
        \
         2
     
     示例 2:
     输入:
       3
      / \
     0   4
      \
       2
      /
     1
     L = 1
     R = 3
     
     输出:
        3
       /
      2
     /
    1
     */
    /*
     最开始的思路是：
     从当前根节点开始判断，如果在L和R范围内则修剪左右子树。
     如果当前节点小于L或者大约R，则循环删除当前节点知道满足条件。
     */
    func trimBST_Mine(_ root: TreeNode<Int>?, _ L: Int, _ R: Int) -> TreeNode<Int>? {
        typealias Node = TreeNode<Int>
        func _deleteNode(_ root : Node?, _ key : Int) -> Node? {
            guard let root = root else {
                return nil
            }
            if key < root.val {
                root.left = _deleteNode(root.left, key)
                return root
            }
            else if key > root.val {
                root.right = _deleteNode(root.right, key)
                return root
            }
            else {
                if root.left == nil {
                    let rightNode = root.right
                    return rightNode
                }
                if root.right == nil {
                    let leftNode = root.right
                    return leftNode
                }
                let tmp = _getMinNode(root.right)
                let newNode = Node(tmp!.val)
                newNode.left = root.left
                newNode.right = _deleteMinNode(root.right)
                return newNode
            }
        }
        
        func _getMinNode(_ root : Node?) -> Node? {
            
            if root?.left == nil {
                return root
            }
            return _getMinNode(root?.left)
        }
        
        func _deleteMinNode(_ root : Node?) -> Node? {
            if root == nil {
                return nil
            }
            if root?.left == nil {
                return root?.right
            }
            root?.left = _deleteMinNode(root?.left)
            return root
        }
        
        guard let root = root else {
            return nil
        }
        var r : Node? = root
        while r != nil && (r!.val < L || r!.val > R) {
            r = _deleteNode(r, r!.val)
        }
        r?.left = trimBST_Mine(r?.left, L, R)
        r?.right = trimBST_Mine(r?.right, L, R)
        return r
    }
    
    /*
     如果当前节点node.val小于L，那么node的左子树一定都小于L，那么舍弃左子树和当前节点，转而修剪右子树，最后返回右子树。
     如果当前节点node.val大于R，那么node的右子树一定都大于R，那么舍弃右子树和当前节点，转而修剪左子树，最后返回左子树。
     如果当前节点 L <= node.val <= R ,那么既修剪左子树又修剪右子树。
     */
    func trimBST(_ root: TreeNode<Int>?, _ L: Int, _ R: Int) -> TreeNode<Int>? {
        
        guard let root = root else {
            return nil
        }
        if root.val < L {
            return trimBST(root.right,L,R)
        }
        if root.val > R {
            return trimBST(root.left,L,R)
        }
        
        if root.val >= L && root.val <= R {
            root.left = trimBST(root.left, L, R)
            root.right = trimBST(root.right, L, R)
        }
        return root
    }
    
    
    // MARK: -------------- 翻转二叉树 leetCode #226
    /*
     https://leetcode-cn.com/problems/invert-binary-tree/
     翻转一棵二叉树。
     
     示例：
     输入：
          4
        /   \
       2     7
      / \   / \
     1   3 6   9
     输出：
          4
        /   \
       7     2
      / \   / \
     9   6 3   1
     */
    func invertTree(_ root: TreeNode<Int>?) -> TreeNode<Int>? {
        guard let root = root else {
            return nil
        }
        let tmp = root.left
        root.left = root.right
        root.right = tmp
        root.left = invertTree(root.left)
        root.right = invertTree(root.right)
        return root
    }
    
    // MARK: -------------- 二叉搜索树中的插入操作 leetCode #701
    /*
     https://leetcode-cn.com/problems/insert-into-a-binary-search-tree/
     翻转一棵二叉树。
     例如,
     
     给定二叉搜索树:
     
        4
       / \
      2   7
     / \
    1   3
     
     和 插入的值: 5
     你可以返回这个二叉搜索树:
     
          4
        /   \
       2     7
       / \   /
     1   3 5
     或者这个树也是有效的:
     
         5
       /   \
      2     7
     / \
    1   3
     \
      4

     */
    func insertIntoBST(_ root: TreeNode<Int>?, _ val: Int) -> TreeNode<Int>? {
        typealias Node = TreeNode<Int>
        guard let root = root  else {
            return Node(val)
        }
        
        if val < root.val {
            root.left = insertIntoBST(root.left, val)
        }
        if val > root.val {
            root.right = insertIntoBST(root.right, val)
        }
        return root
    }
    
    // MARK: --------------  二叉树的层次遍历 leetCode #102
    /*
     https://leetcode-cn.com/problems/binary-tree-level-order-traversal/comments/
     给定一个二叉树，返回其按层次遍历的节点值。 （即逐层地，从左到右访问所有节点）。
     
     例如:
     给定二叉树: [3,9,20,null,null,15,7],
     
         3
        / \
       9  20
      / \
     15  7
     返回其层次遍历结果：
     
     [
     [3],
     [9,20],
     [15,7]
     ]
     */
    func levelOrder(_ root: TreeNode<Int>?) -> [[Int]] {
        typealias Node = TreeNode<Int>
        guard let root = root else { return [] }
        let queue = BasicQueue<Node>()
        var res = [[Int]]()
        queue.enqueue(root)
        while queue.isEmpty() == false {
            var count = queue.size()
            var sub = [Int]()
            while count > 0 {
                let node = queue.front()!
                queue.dequeue()
                if let left = node.left {
                    queue.enqueue(left)
                }
                if let right = node.right {
                    queue.enqueue(right)
                }
                sub.append(node.val)
                count -= 1
            }
            res.append(sub)
        }
        return res;
    }
    
    func createBST(_ nums: [Int]) -> TreeNode<Int>? {
        guard nums.isEmpty == false else { return nil }
        typealias Node = TreeNode<Int>
        var nums = nums
        let queue = BasicQueue<Node>()
        let root = Node(nums.removeFirst())
        queue.enqueue(root)
        while nums.isEmpty == false {
            let node = queue.front()!
            queue.dequeue()
            node.left = Node(nums.removeFirst())
            node.right = Node(nums.removeFirst())
            queue.enqueue(node.left)
            queue.enqueue(node.right)
        }
        return root;
    }

    // MARK: --------------  将有序数组转换为二叉搜索树 leetCode #108
    /*
    https://leetcode-cn.com/problems/convert-sorted-array-to-binary-search-tree/
    将一个按照升序排列的有序数组，转换为一棵高度平衡二叉搜索树。
    本题中，一个高度平衡二叉树是指一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过 1。
    示例:
    给定有序数组: [-10,-3,0,5,9],
    一个可能的答案是：[0,-3,9,-10,null,5]，它可以表示下面这个高度平衡二叉搜索树：
         0
        / \
      -3   9
      /   /
    -10  5
    */
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode<Int>? {
        // 二叉搜索树中序遍历的逆向构建
        typealias Node = TreeNode<Int>
        guard !nums.isEmpty else { return nil }
        func _getRoot(_ nums : [Int], _ l : Int, _ r : Int) -> Node? {
            if l > r {
                return nil
            }
            let mid = (r - l) / 2 + l
            let node = Node(nums[mid])
            node.left = _getRoot(nums, l, mid-1)
            node.right = _getRoot(nums, mid+1, r)
            return node
        }
        return _getRoot(nums, 0, nums.count-1);
    }
}



