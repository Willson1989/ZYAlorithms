//
//  Solution.swift
//  LeetCodeSolution
//
//  Created by WillHelen on 2018/8/16.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

class Solution {
    
    // MARK: -------------- 求两个数的最大公约数
    func getGCD(_ a : Int, _ b : Int) -> Int {
        if b == 0 {
            return a
        }
        return getGCD(b , a % b)
    }

    
    
    // MARK: -------------- 数组中的重复 leetCode  #26
    /*
     https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array/description/
     给定一个排序数组，你需要在原地删除重复出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。
     不要使用额外的数组空间，你必须在原地修改输入数组并在使用 O(1) 额外空间的条件下完成。
     
     示例 1:
     给定数组 nums = [1,1,2],
     函数应该返回新的长度 2, 并且原数组 nums 的前两个元素被修改为 1, 2。
     你不需要考虑数组中超出新长度后面的元素。
     
     示例 2:
     给定 nums = [0,0,1,1,1,2,2,3,3,4],
     函数应该返回新的长度 5, 并且原数组 nums 的前五个元素被修改为 0, 1, 2, 3, 4。
     你不需要考虑数组中超出新长度后面的元素。
     */
    func removeDuplicates( _ nums : inout [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        var i = 0
        for j in 1 ..< nums.count {
            if nums[i] != nums[j] {
                //找到第一个与nums[i]不相等的元素，将这个元素赋值到当前i的下一个位置。
                i += 1
                nums[i] = nums[j]
            }
        }
        // 一轮赋值之后，i就位于了去重之后的数组的末尾，返回i+1即为去重之后数组的元素个数。
        return i + 1
    }
    
    func reverseInt(_ value : Int) -> Int {
        
        var x = value
        
        var res = 0
        
        while x != 0 {
            
            let temp = x % 10
            
            //防止整型溢出
            if res > Int.max / 10 || (res == Int.max / 10 && temp > 7) {
                return 0
            }
            
            if res < Int.min / 10 || (res == Int.min / 10 && temp < -8) {
                return 0
            }
            
            res = res * 10 + temp
            
            x /= 10
        }
        return res
    }
    
    // MARK: -------------- 回文数 leetCode #9
    /*
     https://leetcode-cn.com/problems/palindrome-number/description/
     判断一个整数是否是回文数。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。
     示例 1:
     输入: 121  ,  输出: true
     
     示例 2:
     输入: -121 ,  输出: false
     解释: 从左向右读, 为 -121 。 从右向左读, 为 121- 。因此它不是一个回文数。
     
     示例 3:
     输入: 10   ,  输出: false
     解释: 从右向左读, 为 01 。因此它不是一个回文数。
     
     进阶:
     你能不将整数转为字符串来解决这个问题吗？
     */
    func isPalindromeNumber(_ x : Int) -> Bool {
        if x < 0 || (x != 0 && x % 10 == 0) {
            return false
        }
        var res = 0, v = x
        while v != 0  {
            let temp = v % 10
            //防止整型溢出, 溢出则返回false
            if res > Int.max / 10 || (res == Int.max / 10 && temp > 7) {
                return false
            }
            
            if res < Int.min / 10 || (res == Int.min / 10 && temp < -8) {
                return false
            }
            res = res * 10 + temp
            v /= 10
        }
        return res == x
    }
    
    // MARK: -------------- 罗马数字转整数 leetCode #13
    /*
     https://leetcode-cn.com/problems/roman-to-integer/description/
     罗马数字包含以下七种字符：I， V， X， L，C，D 和 M。
     字符          数值
     I             1
     V             5
     X             10
     L             50
     C             100
     D             500
     M             1000
     例如， 罗马数字 2 写做 II ，即为两个并列的 1。12 写做 XII ，即为 X + II 。 27 写做  XXVII, 即为 XX + V + II 。
     通常情况下，罗马数字中小的数字在大的数字的右边。但也存在特例，例如 4 不写做 IIII，而是 IV。数字 1 在数字 5 的左边，
     所表示的数等于大数 5 减小数 1 得到的数值 4 。同样地，数字 9 表示为 IX。这个特殊的规则只适用于以下六种情况：
     I 可以放在 V (5) 和 X (10) 的左边，来表示 4 和 9。
     X 可以放在 L (50) 和 C (100) 的左边，来表示 40 和 90。
     C 可以放在 D (500) 和 M (1000) 的左边，来表示 400 和 900。
     
     示例 1:
     输入: "LVIII"    输出: 58
     解释: C = 100, L = 50, XXX = 30, III = 3.
     
     示例 2:
     输入: "MCMXCIV"  输出: 1994
     解释: M = 1000, CM = 900, XC = 90, IV = 4.
     */
    func romanToInt(_ s: String) -> Int {
        
        func charToInt(_ c : Character) -> Int {
            switch c {
            case "I": return 1
            case "V": return 5
            case "X": return 10
            case "L": return 50
            case "C": return 100
            case "D": return 500
            case "M": return 1000
            default: return 0
            }
        }
        
        func isSpecialCouple(_ l : Character, _ r : Character) -> Bool {
            if (l == "I" && (r == "V" || r == "X")) ||
                (l == "X" && (r == "L" || r == "C")) ||
                (l == "C" && (r == "D" || r == "M")) {
                return true
            }
            return false
        }
        
        var chars = [Character]()
        for c in s {
            chars.append(c)
        }
        
        var t = charToInt(chars[0])
        
        for i in 1 ..< chars.count {
            let c_prev = chars[i-1]
            let c_curr = chars[i]
            let prev = charToInt(chars[i-1])
            let curr = charToInt(chars[i])
            
            if isSpecialCouple(c_prev, c_curr) {
                t -= prev
                t += curr - prev
            } else {
                t += curr
            }
        }
        
        return t
    }

    // MARK: -------------- 最长公共前缀 leetCode #14
    /*
     https://leetcode-cn.com/problems/longest-common-prefix/description/
     编写一个函数来查找字符串数组中的最长公共前缀。 如果不存在公共前缀，返回空字符串 ""。
     
     示例 1:
     输入: ["flower","flow","flight"]     输出: "fl"
     示例 2:
     
     输入: ["dog","racecar","car"]  输出: ""
     解释: 输入不存在公共前缀。
     
     说明:
     所有输入只包含小写字母 a-z 。
     */
    func longestCommonPrefix(_ arr : [String]) -> String {
        if arr.isEmpty {
            return ""
        }
        if arr.count == 1 {
            return arr[0]
        }
        var index = 0
        let s = arr[0]
        for i in 0 ..< s.count {
            let c = s[s.index(s.startIndex, offsetBy: i)]
            for str in arr {
                if i == str.count || str[str.index(str.startIndex, offsetBy: i)] != c {
                    let endIndex = str.index(str.startIndex, offsetBy: index)
                    let startIndex = str.startIndex
                    return String(str[startIndex ..< endIndex])
                }
            }
            index += 1
        }
        let endIndex = s.index(s.startIndex, offsetBy: index)
        let startIndex = s.startIndex
        return String(s[startIndex ..< endIndex])
    }
    
    // MARK: -------------- 1比特与2比特字符 leetCode #717
    /*
     https://leetcode-cn.com/problems/1-bit-and-2-bit-characters/description/
     有两种特殊字符。第一种字符可以用一比特0来表示。第二种字符可以用两比特(10 或 11)来表示。
     现给一个由若干比特组成的字符串。问最后一个字符是否必定为一个一比特字符。给定的字符串总是由0结束。
     
     示例 1:
     输入:
     bits = [1, 0, 0]
     输出: True
     解释:
     唯一的编码方式是一个两比特字符和一个一比特字符。所以最后一个字符是一比特字符。
     
     示例 2:
     输入:
     bits = [1, 1, 1, 0]
     输出: False
     解释:
     唯一的编码方式是两比特字符和两比特字符。所以最后一个字符不是一比特字符。
     */
    func isOneBitCharacter(_ bits: [Int]) -> Bool {
        
        func offset(_ curr : Int) -> Int {
            if curr != 0 && curr != 1 {
                return 0
            }
            if curr == 0 {
                return 1
            }
            return 2
        }
        
        if bits.isEmpty || bits.last! != 0{
            return false
        }
        var k = 0
        var lastOffset = 0
        while k < bits.count {
            lastOffset = offset(bits[k])
            k += lastOffset
        }
        return lastOffset == 1
    }
    
    // MARK: --------------  二进制求和 leetCode #67
    /*
     https://leetcode-cn.com/problems/add-binary/description/
     给定两个二进制字符串，返回他们的和（用二进制表示）。输入为非空字符串且只包含数字 1 和 0。
     
     示例 1:
     输入: a = "11", b = "1"
     输出: "100"
     
     示例 2:
     输入: a = "1010", b = "1011"
     输出: "10101"
     */
    func addBinary(_ a: String, _ b: String) -> String {
        
        func charToInt(_ c : Character) -> Int {
            return c == "1" ? 1 : 0
        }
        
        var index_a = a.count - 1
        var index_b = b.count - 1
        var add = 0
        var res = ""
        while index_a >= 0 || index_b >= 0 {
            
            let c_a = index_a >= 0 ? a[a.index(a.startIndex, offsetBy: index_a)] : "0"
            let c_b = index_b >= 0 ? b[b.index(b.startIndex, offsetBy: index_b)] : "0"
            let num_a = charToInt(c_a), num_b = charToInt(c_b)
            
            let temp = num_a + num_b + add
            let res_num = temp % 2
            add = temp / 2
            index_a -= 1
            index_b -= 1
            res = "\(res_num)" + res
        }
        if add == 1 {
            res = "1" + res
        }
        return res
    }
    
    // MARK: -------------- 字符串相加 leetCode #415
    /*
     https://leetcode-cn.com/problems/add-strings/description/
     给定两个字符串形式的非负整数 num1 和num2 ，计算它们的和。
     注意：
     num1 和num2 的长度都小于 5100.
     num1 和num2 都只包含数字 0-9.
     num1 和num2 都不包含任何前导零。
     你不能使用任何內建 BigInteger 库， 也不能直接将输入的字符串转换为整数形式。
     */
    func addStrings(_ num1: String, _ num2: String) -> String {
        
        func charToInt(_ c : Character) -> Int {
            switch c {
            case "0": return 0
            case "1": return 1
            case "2": return 2
            case "3": return 3
            case "4": return 4
            case "5": return 5
            case "6": return 6
            case "7": return 7
            case "8": return 8
            case "9": return 9
            default : return 0
            }
        }
        let num1 = num1.count == 0 ? "0" : num1
        let num2 = num2.count == 0 ? "0" : num2
        
        var idx_1 = num1.count - 1
        var idx_2 = num2.count - 1
        var add = 0
        var res = ""
        while idx_1 >= 0 || idx_2 >= 0 {
            let n1 = idx_1 >= 0 ? charToInt(num1[num1.index(num1.startIndex, offsetBy: idx_1)]) : 0
            let n2 = idx_2 >= 0 ? charToInt(num2[num2.index(num2.startIndex, offsetBy: idx_2)]) : 0
            let temp = n1 + n2 + add
            res = "\(temp % 10)" + res
            add = temp / 10
            idx_1 -= 1
            idx_2 -= 1
        }
        if add == 1 {
            res = "1" + res
        }
        return res
    }
    
    // MARK: -------------- 各位相加 leetCode #258
    /*
     https://leetcode-cn.com/problems/add-digits/description/
     给定一个非负整数 num，反复将各个位上的数字相加，直到结果为一位数。
     
     示例:
     输入: 38 , 输出: 2
     解释: 各位相加的过程为：3 + 8 = 11, 1 + 1 = 2。 由于 2 是一位数，所以返回 2。
     
     进阶:
     你可以不使用循环或者递归，且在 O(1) 时间复杂度内解决这个问题吗？
     */
    func addDigits(_ num: Int) -> Int {
        
        if num < 10 {
            return num
        }
        var num = num
        var a = [Int]()
        var sum = 0
        while num != 0 {
            let k = num % 10
            a.append(k)
            num /= 10
            sum += k
        }
        return addDigits(sum)
    }
    
    // MARK: -------------- 排列硬币 leetCode #441
    /*
     https://leetcode-cn.com/problems/arranging-coins/description/
     你总共有 n 枚硬币，你需要将它们摆成一个阶梯形状，第 k 行就必须正好有 k 枚硬币。
     给定一个数字 n，找出可形成完整阶梯行的总行数。 n 是一个非负整数，并且在32位有符号整型的范围内。
     示例 1:
     n = 5 硬币可排列成以下几行: (因为第三行不完整，所以返回2.)
     ¤
     ¤ ¤
     ¤ ¤
     
     示例 2:
     n = 8 硬币可排列成以下几行: (因为第四行不完整，所以返回3.)
     ¤
     ¤ ¤
     ¤ ¤ ¤
     ¤ ¤
     
     */
    func arrangeCoins(_ n: Int) -> Int {
        
        if n <= 0 { return 0 }
        var row = 1
        var remaining = n
        while remaining >= row {
            remaining = remaining - row
            row += 1
        }
        return row == 1 ? 1 : row - 1
    }
    
    // MARK: -------------- 数组拆分I leetCode #561
    /*
     https://leetcode-cn.com/problems/array-partition-i/description/
     给定长度为 2n 的数组, 你的任务是将这些数分成 n 对, 例如 (a1, b1), (a2, b2), ..., (an, bn) ，
     使得从1 到 n 的 min(ai, bi) 总和最大。
     
     示例 1:
     输入: [1,4,3,2]  输出: 4
     解释: n 等于 2, 最大总和为 4 = min(1, 2) + min(3, 4).
     
     提示:
     n 是正整数,范围在 [1, 10000].
     数组中的元素范围在 [-10000, 10000].
     */
    func arrayPairSum(_ nums: [Int]) -> Int {
        var nums = nums
        //将数组排序之后，每两个一组，那么整个数组中两两一组的min的和是最大的
        //MergeSort.sort(&nums)
        Sort.mergeSort(arr: &nums)
        
        var sum = 0
        for i in stride(from: 0, to: nums.count, by: 2) {
            sum += min(nums[i], nums[i+1])
        }
        return sum
    }
    
    // MARK: -------------- 二叉树的层平均值 leetCode #637
    /*
     https://leetcode-cn.com/problems/average-of-levels-in-binary-tree/description/
     给定一个非空二叉树, 返回一个由每层节点平均值组成的数组.
     
     示例 1:
     输入:
         3
        / \
       9  20
      /  \
     15   7
     输出: [3, 14.5, 11]
     解释:
     第0层的平均值是 3,  第1层是 14.5, 第2层是 11. 因此返回 [3, 14.5, 11].
     */
    func averageOfLevels(_ root: TreeNode<Int>?) -> [Double] {
        
        typealias Node = TreeNode<Int>
        var queue = [Node]()
        var res = [Double]()
        
        if let root = root {
            queue.append(root)
            while queue.isEmpty == false {
                var sum = 0
                let count = queue.count
                for _ in 0 ..< count {
                    let temp = queue.first
                    queue.removeFirst()
                    sum += temp!.val
                    if let left = temp?.left {
                        queue.append(left)
                    }
                    
                    if let right = temp?.right {
                        queue.append(right)
                    }
                }
                res.append(Double(sum) / Double(count))
            }
            return res
        }
        return [0]
    }
    
    // MARK: -------------- 二叉树的层次遍历 II leetCode #107
    /*
     https://leetcode-cn.com/problems/binary-tree-level-order-traversal-ii/description/
     给定一个二叉树，返回其节点值自底向上的层次遍历。 （即按从叶子节点所在层到根节点所在的层，逐层从左向右遍历）
     
     例如：
     给定二叉树 [3,9,20,null,null,15,7],
         3
        / \
       9  20
      / \
     15   7
     返回其自底向上的层次遍历为：
     [ [15,7], [9,20], [3] ]
     */
    func levelOrderBottom(_ root: TreeNode<Int>?) -> [[Int]] {
        typealias N = TreeNode<Int>
        var res = [[Int]]()
        if let root = root {
            var queue = [N]()
            queue.append(root)
            while !queue.isEmpty {
                
                let count = queue.count
                var subRes = [Int]()
                for _ in 0 ..< count {
                    let tmp = queue.first
                    subRes.append(tmp!.val)
                    queue.removeFirst()
                    if let l = tmp?.left {
                        queue.append(l)
                    }
                    if let r = tmp?.right {
                        queue.append(r)
                    }
                }
                res.append(subRes)
            }
        }
        return res.reversed()
    }
    
    // MARK: -------------- 两数相加（链表）leetCode #2
    /*
     https://leetcode-cn.com/problems/add-two-numbers/
     给定两个非空链表来表示两个非负整数。位数按照逆序方式存储，它们的每个节点只存储单个数字。将两数相加返回一个新的链表。
     你可以假设除了数字 0 之外，这两个数字都不会以零开头。
     
     示例：
     输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)  ,  输出：7 -> 0 -> 8
     原因：342 + 465 = 807
     */
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var n1 = l1, n2 = l2
        var add = 0
        let res = ListNode(Int.min)
        var currNode = res
        while n1 != nil || n2 != nil {
            let val1 = n1 == nil ? 0 : n1!.val
            let val2 = n2 == nil ? 0 : n2!.val
            let temp = val1 + val2 + add
            add = temp / 10
            currNode.next = ListNode(temp % 10)
            currNode = currNode.next!
            n1 = n1 == nil ? nil : n1!.next
            n2 = n2 == nil ? nil : n2!.next
        }
        
        if add == 1 {
            currNode.next = ListNode(1)
        }
        return res.next
        
    }
    
    // MARK: -------------- 对称二叉树 leetCode #101
    /*
     https://leetcode-cn.com/problems/symmetric-tree/description/
     给定一个二叉树，检查它是否是镜像对称的。
     
     例如，二叉树 [1,2,2,3,4,4,3] 是对称的。
         1
        / \
       2   2
      / \ / \
     3  4 4  3
     但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:
     
         1
        / \
       2   2
        \   \
        3    3
     
     说明:
     如果你可以运用递归和迭代两种方法解决这个问题，会很加分。
     */
    func isSymmetric(_ root: TreeNode<Int>?) -> Bool {
        
        typealias TNode = TreeNode<Int>
        
        func _isSymmetric(_ node1 : TNode?, _ node2 : TNode?) -> Bool {
            if node1 == nil && node2 == nil {
                return true
            }
            if node1 == nil {
                return false
            }
            if node2 == nil {
                return false
            }
            return node1!.val == node2!.val &&
                _isSymmetric(node1!.left, node2!.right) &&
                _isSymmetric(node1!.right, node2!.left)
        }
        
        if root == nil {
            return true
        }
        return _isSymmetric(root!.left, root!.right)
    }
    
    
    // MARK: -------------- 两整数之和 leetCode #371
    /*
     https://leetcode-cn.com/problems/sum-of-two-integers/
     不使用运算符 + 和-，计算两整数a 、b之和。
     示例：
     若 a = 1 ，b = 2，返回 3。
     
     对于二进制的加法运算，若不考虑进位，则1+1=0,1+0=1,0+1=1,0+0=0,通过对比异或，
     不难发现，此方法与异或运算类似。因而排出进位，加法可用异或来实现。
     然后考虑进位，0+0进位为0,1+0进位为1,0+1进位为0，1+1进位为1，该操作与位运算的&操作相似。
     那么加法运算可以这样实现：
     1）先不考虑进位，按位计算各位累加（用异或实现），得到值a；
     2）然后在考虑进位，并将进位的值左移，得值b，若b为0，则a就是加法运算的结果，若b不为0，则a+b即得结果（递归调用该函数）。
     */
    func getSum_Binary(_ a: Int, _ b: Int) -> Int {
        
        if b == 0 {
            return a
        }
        let sum = a ^ b
        let carry = (a & b) << 1
        return self .getSum_Binary(sum, carry)
    }
}
