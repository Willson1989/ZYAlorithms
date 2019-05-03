//
//  Solution_05.swift
//  Play-with-Alorithms
//
//  Created by 郑毅 on 2019/2/14.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import Foundation


extension Solution {

    // MARK: -------------- 岛屿的个数 leetCode #200
    /*
     https://leetcode-cn.com/problems/number-of-islands/
     给定一个由 '1'（陆地）和 '0'（水）组成的的二维网格，计算岛屿的数量。一个岛被水包围，
     并且它是通过水平方向或垂直方向上相邻的陆地连接而成的。你可以假设网格的四个边均被水包围。
     
     示例 1, 输入:
     1 1 1 1 0
     1 1 0 1 0
     1 1 0 0 0
     0 0 0 0 0    输出: 1
     
     示例 2, 输入:
     1 1 0 0 0
     1 1 0 0 0
     0 0 1 0 0
     0 0 0 1 1    输出: 3
     
     解法：
     遍历grid数组，如果遇到1，则说明遇到了一个岛屿，那么通过深度优先搜索dfs将与其相连的陆地都设置为0（像是扫雷一样）
     在遍历结束之前如果又遇到了1，则说明还有一个岛屿，重复上述操作。
     */
    func numIslands(_ grid: [[Character]]) -> Int {
        
        var grid = grid
        if grid.isEmpty || grid[0].isEmpty {
            return 0
        }
        var visited : [[Bool]] = Array(repeating: Array(repeating: false, count: grid[0].count), count: grid.count)
        func dfs(row : Int, colum : Int) {
            
            if grid.isEmpty || grid[0].isEmpty {
                return
            }
            
            if row < 0 || row >= grid.count || colum < 0 || colum >= grid[0].count {
                return
            }
            
            if visited[row][colum] {
                return
            }
            
            if grid[row][colum] == "0" {
                visited[row][colum] = true
                return
            }
            
            if grid[row][colum] == "1" {
                //将 grid[row][colum] 上下左右的位置都设置为 0
                grid[row][colum] = "0"
                visited[row][colum] = true
                dfs(row: row+1, colum: colum)
                dfs(row: row-1, colum: colum)
                dfs(row: row  , colum: colum+1)
                dfs(row: row  , colum: colum-1)
            }
        }
        
        var count = 0
        for i in 0 ..< grid.count {
            for j in 0 ..< grid[0].count {
                // 如果遇到1，则说明遇到了一个岛屿
                if grid[i][j] == "1" {
                    // 深度优先遍历将与 grid[i][j] 相连的陆地都设置为0
                    // 得到了一个岛屿，统计之后将其除掉，方便下次遍历
                    dfs(row: i, colum: j)
                    count += 1
                }
            }
        }
        return count
    }
    
    // MARK: -------------- 打开转盘锁 leetCode #752
    /*
     https://leetcode-cn.com/problems/open-the-lock/comments/
     你有一个带有四个圆形拨轮的转盘锁。每个拨轮都有10个数字：
     '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' 。
     每个拨轮可以自由旋转：例如把 '9' 变为  '0'，'0' 变为 '9' 。每次旋转都只能旋转一个拨轮的一位数字。
     
     锁的初始数字为 '0000' ，一个代表四个拨轮的数字的字符串。
     列表 deadends 包含了一组死亡数字，一旦拨轮的数字和列表里的任何一个元素相同，这个锁将会被永久锁定，无法再被旋转。
     字符串 target 代表可以解锁的数字，你需要给出最小的旋转次数，如果无论如何不能解锁，返回 -1。
     
     示例 1:
     输入: deadends = ["0201","0101","0102","1212","2002"], target = "0202"  输出：6
     解释:
     可能的移动序列为 "0000" -> "1000" -> "1100" -> "1200" -> "1201" -> "1202" -> "0202"。
     注意 "0000" -> "0001" -> "0002" -> "0102" -> "0202" 这样的序列是不能解锁的，
     因为当拨动到 "0102" 时这个锁就会被锁定。
     
     示例 2:
     输入: deadends = ["8888"], target = "0009"  输出：1
     解释: 把最后一位反向旋转一次即可 "0000" -> "0009"。
     
     示例 3:
     输入: deadends = ["8887","8889","8878","8898","8788","8988","7888","9888"], target = "8888"
     输出：-1
     解释： 无法旋转到目标数字且不被锁定。
     
     示例 4:
     输入: deadends = ["0000"], target = "8888"
     输出：-1
     
     提示：
     死亡列表 deadends 的长度范围为 [1, 500]。
     目标数字 target 不会在 deadends 之中。
     每个 deadends 和 target 中的字符串的数字会在 10,000 个可能的情况 '0000' 到 '9999' 中产生。
     
     
     解法：队列 + 图的广度优先遍历获取最短路径
     由题中条件：每次旋转都只能旋转一个拨轮的一位数字，可知，对于一个数字组合，例如 0000，
     它有以下的集中可能的邻近节点：
     [1000, 0100, 0010, 0001, 9000, 0900, 0090, 0009]
     这样就构成了一个图，然后就可以通过广度优先搜索的方式来获取0000到taget的最短路径步数了
     */
    func openLock(_ deadends: [String], _ target: String) -> Int {
        
        func getNext(_ str : String) -> [String] {
            var res = [String]()
            for i in str.indices {
                if let n = Int(String(str[i])) {
                    let new1 = (n+1) % 10
                    let new2 = n-1 < 0 ? 9 : n-1
                    var newStr1 = String(str)
                    var newStr2 = String(str)
                    let end = String.Index(encodedOffset: i.encodedOffset+1)
                    newStr1.replaceSubrange(i ..< end, with: "\(new1)")
                    newStr2.replaceSubrange(i ..< end, with: "\(new2)")
                    res.append(newStr1)
                    res.append(newStr2)

                } else {
                    return []
                }
            }
            return res
        }
        if target.isEmpty {
            return -1
        }
        let start = "0000"
        let deadendsSet = Set<String>(deadends)
        if deadendsSet.contains(start) {
            return -1
        }
        var visitedSet  = Set<String>()
        let queue = BasicQueue<String>()
        queue.enqueue(start)
        
        var step = 0
        // 广度优先遍历
        while !queue.isEmpty() {
            
            let size = queue.size()
            for _ in 0 ..< size {
                guard let curr = queue.front() else {
                    return -1
                }
                if curr == target {
                    return step
                }
                let nextNums = getNext(curr)
                for num in nextNums {
                    if deadendsSet.contains(num) {
                        continue
                    }
                    if !visitedSet.contains(num) {
                        queue.enqueue(num)
                        visitedSet.insert(num)
                    }
                }
                queue.dequeue()
            }
            step += 1
        }
        return -1
    }
    
    // MARK: -------------- 完全平方数 leetCode #279
    /*
     https://leetcode-cn.com/problems/perfect-squares/
     给定正整数 n，找到若干个完全平方数（比如 1, 4, 9, 16, ...）使得它们的和等于 n。你需要让组成和的完全平方数的个数最少。
     
     示例 1:
     输入: n = 12  输出: 3
     解释: 12 = 4 + 4 + 4.
     
     示例 2:
     输入: n = 13  输出: 2
     解释: 13 = 4 + 9.
     
     
     解法：
     三种方法：
     1. 抽象成图的最短路径的问题，并利用广度优先搜索的方式求解
     2. 动态规划
     3. 数学定理：四平方和定理。
     */
    
    /*
     解法1：
     从n到0的每一个数作为一个结点，如果两个数之间的差为一个完全平方数（1，4，9等等）则连接一条路径
     这样的话该问题就抽象成了求n到0的最短路径步数的问题。
     在获取某一结点k的邻接结点时，只需要从1到k遍历并求值a=k-i*i,如果a>0,则a是k的邻接结点将其加入队列，如果a==0，则求解结束，a<0则跳出循环
     参考：https://blog.csdn.net/hghggff/article/details/83756088
     */
    func numSquares_bfs(_ n: Int) -> Int {
        /* 抽象成图的最短路径的问题，并利用广度优先搜索的方式求解 */
        let queue = BasicQueue<Int>()
        var visited = Set<Int>()
        queue.enqueue(n)
        var step = 0
        while !queue.isEmpty() {
            let size = queue.size()
            for _ in 0 ..< size {
                let curr = queue.front()!
                queue.dequeue()
                if curr == 0 {
                    return step+1
                }
                for i in 1 ... curr {
                    let a = curr - i * i
                    if a > 0 {
                        if visited.contains(a) {
                            continue
                        }
                        queue.enqueue(a)
                        visited.insert(a)
                        
                    } else if a < 0 {
                        break
                        
                    } else { // a == 0
                        return step + 1
                    }
                }
            }
            step += 1
        }
        return step
    }
    
    /*
     解法2：
     动态规划，推到出状态转换方程之后解决。
     创建dp数组用来存储每个数的最小的完全平方数如ap[i] = k, 那么数字i的最小的完全平方数就是k。
     每一个数字（除了零以外）都可以由该数字大小数目的1相加而成，所以dp的数组中元素的初始值可以设置为i，即dp[i]=i（0则特殊，值为1）
     
     通过计算有如下现象：
     1 = 1 * 1
     2 = 1 + 1
     3 = 2 + 1
     4 = 2 * 2
     5 = 4 + 1
     6 = 5 + 1, 2 + 4
     7 = 6 + 1, 3 + 4
     8 = 7 + 1, 4 + 4
     9 = 8 + 1, 5 + 4、 9（9 + 0）
     10 = 9 + 1 , 6 + 4
     11 = 10 + 1, 7 + 4, 9 + 2
     12 = 11 + 1, 8 + 4, 9 + 3
     13 = 12 + 1, 9 + 4
     
     则
     dp[1]  = 1
     dp[2]  = dp[1] + 1 = 2
     dp[3]  = dp[2] + 1 = 2 + 1 = 3
     dp[4]  = 1
     dp[5]  = dp[4] + 1 = 1 + 1 = 2
     dp[6]  = min( dp[5] + 1, dp[2] + 1 )
     dp[7]  = min( dp[6] + 1, dp[3] + 1 )
     dp[8]  = min( dp[7] + 1, dp[4] + 1 )
     dp[9]  = 1
     dp[10] = min( dp[9] + 1 , dp[6] + 1 )
     dp[11] = min( dp[10] + 1, dp[7] + 1, dp[2] + 1 )
     dp[12] = min( dp[11] + 1, dp[8] + 1, dp[3] + 1 )
     dp[13] = min( dp[12] + 1, dp[9] + 1 )
     
     所以可以推到出：
     dp[n] = min ( dp[n - i * i] + 1, dp[n] )
     其中i为从1开始每次循环累加1，并且i*i <= n
     
     参考：
     https://segmentfault.com/a/1190000013363355
     https://blog.csdn.net/happyaaaaaaaaaaa/article/details/51584790
     https://www.cnblogs.com/rainxbow/p/9700908.html
     */
    func numSquares_dp(_ n: Int) -> Int {
        var dp = Array(repeating: 1, count: n+1)
        for i in 0 ... n {
            dp[i] = i > 1 ? i : 1
            var j = 1
            while j * j <= i {
                if j * j == i {
                    dp[i] = 1
                } else {
                    dp[i] = min(dp[i], dp[i-j*j] + 1)
                }
                j += 1
            }
        }
        return dp[n]
    }
    
    
    // MARK: -------------- 每日温度 leetCode #739
    /*
     https://leetcode-cn.com/problems/daily-temperatures/
     根据每日 气温 列表，请重新生成一个列表，对应位置的输入是你需要再等待多久温度才会升高的天数。
     如果之后都不会升高，请输入 0 来代替。
     
     例如，给定一个列表 temperatures = [73, 74, 75, 71, 69, 72, 76, 73]，你的输出应该是 [1, 1, 4, 2, 1, 1, 0, 0]。
     提示：气温 列表长度的范围是 [1, 30000]。每个气温的值的都是 [30, 100] 范围内的整数。
     */
    // 暴力解法：双重循环会超出时间限制
    func dailyTemperatures(_ T: [Int]) -> [Int] {
        guard T.isEmpty == false else { return [] }
        var res = Array(repeating: 0, count: T.count)
        for i in 0 ..< T.count-1 {
            for k in i+1 ..< T.count {
                if T[k] > T[i] {
                    res[i] = k - i
                    break
                }
            }
        }
        return res
    }
    
    /*
     使用 递减栈 解决：
     栈里只有递减元素，思路是这样的，我们遍历数组，如果栈不空，且当前数字大于栈顶元素，
     那么如果直接入栈的话就不是递减栈了。所以我们取出栈顶元素，那么由于当前数字大于栈顶元素的数字，
     而且一定是第一个大于栈顶元素的数，那么我们直接求出下标差就是二者的距离了，
     然后继续看新的栈顶元素，直到当前数字小于等于栈顶元素停止，然后将数字入栈，
     这样就可以一直保持递减栈，且每个数字和第一个大于它的数的距离也可以算出来了
     参考：https://blog.csdn.net/jackzhang_123/article/details/78894769
     */
    func dailyTemperatures_stack(_ T: [Int]) -> [Int] {
        guard T.isEmpty == false else { return [] }
        var res = Array(repeating: 0, count: T.count)
        let s = BasicStack<Int>()
        for i in 0 ..< T.count {
            while !s.isEmpty() && T[i] > T[s.top()!] {
                // 总是保持栈中栈底元素到栈顶元素是递减的
                // 如果当前元素大于栈顶元素，则pop之后将大的元素入栈
                let top = s.top()!
                s.pop()
                res[top] = i - top
            }
            s.push(i)
        }
        return res
    }
    
    // MARK: -------------- 逆波兰表达式求值 leetCode #150
    /*
     https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/
     根据逆波兰表示法（https://baike.baidu.com/item/逆波兰式/128437），求表达式的值。
     
     有效的运算符包括 +, -, *, / 。每个运算对象可以是整数，也可以是另一个逆波兰表达式。
     
     说明：
     整数除法只保留整数部分。
     给定逆波兰表达式总是有效的。换句话说，表达式总会得出有效数值且不存在除数为 0 的情况。
     示例 1：
     
     输入: ["2", "1", "+", "3", "*"]    输出: 9
     解释: ((2 + 1) * 3) = 9
     示例 2：
     
     输入: ["4", "13", "5", "/", "+"]   输出: 6
     解释: (4 + (13 / 5)) = 6
     示例 3：
     
     输入: ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]  输出: 22
     解释:
     ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
     = ((10 * (6 / (12 * -11))) + 17) + 5
     = ((10 * (6 / -132)) + 17) + 5
     = ((10 * 0) + 17) + 5
     = (0 + 17) + 5
     = 17 + 5
     = 22
     */
    func evalRPN(_ tokens: [String]) -> Int {
        
        func makeOP(_ a : Int, _ op : String, _ b : Int) -> Int {
            switch op {
            case "+": return a+b
            case "-": return a-b
            case "*": return a*b
            default:  return a/b
            }
        }
        
        let opSet : Set<String> = ["+", "-", "*", "/"]
        if tokens.count == 1 && !opSet.contains(tokens[0]) {
            return Int(tokens[0]) ?? 0
        }
        let numStack = BasicStack<Int>()
        for c in tokens {
            let isNum = !opSet.contains(c)
            if isNum {
                numStack.push(Int(c) ?? 0)
            } else {
                let num1 = numStack.top() ?? 0
                numStack.pop()
                let num2 = numStack.top() ?? 0
                numStack.pop()
                numStack.push(makeOP(num2, c, num1))
            }
        }
        return numStack.top() ?? 0
    }
    
    // MARK: -------------- 克隆图 leetCode #133
    /*
     https://leetcode-cn.com/problems/clone-graph/
     克隆一张无向图，图中的每个节点包含一个 label （标签）和一个 neighbors （邻接点）列表 。
     
     OJ的无向图序列化：
     节点被唯一标记。 我们用 # 作为每个节点的分隔符，用 , 作为节点标签和邻接点的分隔符。
     
     例如，序列化无向图 {0,1,2#1,2#2,2}。 该图总共有三个节点, 被两个分隔符  # 分为三部分。
     第一个节点的标签为 0，存在从节点 0 到节点 1 和节点 2 的两条边。
     第二个节点的标签为 1，存在从节点 1 到节点 2 的一条边。
     第三个节点的标签为 2，存在从节点 2 到节点 2 (本身) 的一条边，从而形成自环。
     我们将图形可视化如下：
        1
       / \
      /   \
     0 --- 2
          / \
          \_/
     */
    /*
     dfs深度优先搜索+递归解法
     使用字典map来标识那些结点已经创建过了。以结点的label属性为key
     参考： https://blog.csdn.net/qq508618087/article/details/50806972
     */
    func cloneGraph_dfs(_ node : UndirectedGraphNode?) -> UndirectedGraphNode? {
        guard let node = node else { return nil }
        var map : [Int : UndirectedGraphNode] = [:]
        return _cloneGraph_dfs(node, map: &map)
    }
    
    private func _cloneGraph_dfs(_ node : UndirectedGraphNode?, map : inout [Int : UndirectedGraphNode]) -> UndirectedGraphNode? {
        guard let node = node else {
            return nil
        }
        if map[node.label] == nil {
            let newNode = UndirectedGraphNode(node.label)
            map[node.label] = newNode
            for subNode in node.neighbors {
                if let newSubNode = _cloneGraph_dfs(subNode, map: &map) {
                    newNode.neighbors.append(newSubNode)
                }
            }
        }
        return map[node.label]
    }
    
    /*
     bfs广度优先搜索+队列解法
     使用字典map来标识那些结点已经创建过了。以结点的label属性为key
     */
    func cloneGraph_bfs(_ node : UndirectedGraphNode?) -> UndirectedGraphNode? {
        guard let node = node else {
            return nil
        }
        var map : [Int : UndirectedGraphNode] = [:]
        let queue = BasicQueue<UndirectedGraphNode>()
        queue.enqueue(node)
        let newRoot = UndirectedGraphNode(node.label)
        map[node.label] = newRoot
        while !queue.isEmpty() {
            let currNode = queue.front()!
            let currRoot = map[currNode.label]!
            for subNode in currNode.neighbors {
                if let mappedSubNode = map[subNode.label] {
                    currRoot.neighbors.append(mappedSubNode)
                } else {
                    let newNode = UndirectedGraphNode(subNode.label)
                    map[subNode.label] = newNode
                    currRoot.neighbors.append(newNode)
                    queue.enqueue(subNode)
                }
            }
            queue.dequeue()
        }
        return map[node.label]
    }
    
    // MARK: -------------- 目标和 leetCode #494
    /*
     https://leetcode-cn.com/problems/target-sum/
     给定一个非负整数数组，a1, a2, ..., an, 和一个目标数，S。现在你有两个符号 + 和 -。
     对于数组中的任意一个整数，你都可以从 + 或 -中选择一个符号添加在前面。
     返回可以使最终数组和为目标数 S 的所有添加符号的方法数。
     
     示例 1:
     输入: nums: [1, 1, 1, 1, 1], S: 3    输出: 5
     解释:
     -1+1+1+1+1 = 3
     +1-1+1+1+1 = 3
     +1+1-1+1+1 = 3
     +1+1+1-1+1 = 3
     +1+1+1+1-1 = 3
     一共有5种方法让最终目标和为3。
     
     注意:
     数组的长度不会超过20，并且数组中的值全为正数。
     初始的数组的和不会超过1000。
     保证返回的最终结果为32位整数。
     */
    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        //初始从0开始，这个0不在nums数组中，只是作为一个临时的根节点，所以step初值为-1
        return _findTargetSumWays(node: 0, target: S, step: -1, nums: nums)
    }
    
    private func _findTargetSumWays(node : Int , target : Int, step : Int, nums : [Int]) -> Int {
        // 相当于二叉树的深度优先搜索（左子树为加法，右子树为减法。或者相反也可以）
        let step = step + 1
        let num = nums[step]
        if step >= nums.count-1 {
            let count1 = (node+num == target) ? 1 : 0
            let count2 = (node-num == target) ? 1 : 0
            return count1 + count2
        }
        let count1 = _findTargetSumWays(node: node-num, target: target, step: step, nums: nums)
        let count2 = _findTargetSumWays(node: node+num, target: target, step: step, nums: nums)
        return count1 + count2
    }
    
    
    //MARK: - UndirectedGraphNode for solution 133
    class UndirectedGraphNode {
        var label : Int = -1
        var neighbors : [UndirectedGraphNode] = []
        init(_ label : Int) {
            self.label = label
        }
    }
    
    
    // MARK: -------------- 字符串解码 leetCode #394
    /*
     https://leetcode-cn.com/problems/decode-string/
     给定一个经过编码的字符串，返回它解码后的字符串。
     编码规则为: k[encoded_string]，表示其中方括号内部的 encoded_string 正好重复 k 次。注意 k 保证为正整数。
     你可以认为输入字符串总是有效的；输入字符串中没有额外的空格，且输入的方括号总是符合格式要求的。
     此外，你可以认为原始数据不包含数字，所有的数字只表示重复的次数 k ，例如不会出现像 3a 或 2[4] 的输入。
     
     示例:
     s = "3[a]2[bc]", 返回 "aaabcbc".
     s = "3[a2[c]]",  返回 "accaccacc".
     s = "2[abc]3[cd]ef", 返回 "abcabccdcdcdef".
     */
    
    /*
     递归 1
     以 kk2[a2[rt]bc]3[cd]ef 为例，
     可以把整个字符串c查分成3部分 head body tail
     head为数字之前的部分(kk)，body为最外层[]里面的部分(a2[rt]bc])，tail为']' 后面的部分(3[cd]ef)
     1. 遍历字符串，数字之前的部分为head，获取用于生成结果
     2. 遍历到'['时，从该位置(index)开始遍历并找到与之配对的右括号']'，并记录该位置(rightBracketIndex)
     3. index 到 rightBracketIndex 之间的部分为body，rightBracketIndex之后的部分为tail
     4. 这时body和tail都为满足h格式的子字符串，递归调用解码方法，将解码完成的body和tail与head拼接成最终的解码字符串即为最终结果
     参考：https://www.cnblogs.com/dongling/p/5843795.html
     */
    func decodeString(_ s: String) -> String {
        
        if s.isEmpty {
            return ""
        }
        var index = 0
        var head : String = ""
        var body : String = ""
        // 遍历获取head部分
        while index < s.count && !s.charAt(index).isNum() {
            head.append(s.charAt(index))
            index += 1
        }
        
        if index < s.count {
            var repeatCount = 0
            // index 现在指向数字的第一个字符
            while s.charAt(index).isNum() {
                let num = Int(String(s.charAt(index)))!
                repeatCount = repeatCount * 10 + num
                index += 1
            }
            
            index += 1  // index 现在指向了 '[' 后面的第一个字符
            // 使用 leftBracketNum 和 rightBracketIndex 来找到repeatCount后面字符串的最外层的括号
            var leftBracketNum = 1
            var rightBracketIndex = index
            
            while leftBracketNum > 0 {
                let ch = s.charAt(rightBracketIndex)
                if ch == "[" {
                    leftBracketNum += 1
                } else if ch == "]" {
                    leftBracketNum -= 1
                }
                rightBracketIndex += 1
            }
            rightBracketIndex -= 1
            // 上面的循环结束后 rightBracketIndex 指向了最外层右括号的 ']'
            // 到现在为止，index 到 rightBracketIndex - 1 的子字符串需要在被递归解析一下(body)
            // rightBracketIndex + 1 到 s的末尾的子字符串需要被递归解析一下(tail)
            var bodyStr = ""
            if let subStringBody = s.substringInRange(index ..< rightBracketIndex) {
                bodyStr = decodeString(subStringBody)
            }
            var tailStr = ""
            if let subStringTail = s.substringInRange(rightBracketIndex+1 ..< s.count) {
                tailStr = decodeString(subStringTail)
            }
            
            for _ in 0 ..< repeatCount {
                body = body + bodyStr
            }
            body = body + tailStr
        }
        return head + body
    }
    /*
     递归2
     每一层递归函数都共享同一个字符索引位置k，每一个被[]包裹的字符串都是一个需要解码的子字符串，
     所以当遍历字符串时，如果遇到'['时，就需要递归解码k位置后面的子字符串，当k的位置移动到 ']'时，代表当前递归的字符串解码结束，返回即可。
     这样一层一层从里到外，完成了字符串的解码。
     参考：https://blog.csdn.net/qq508618087/article/details/52439114
     */
    func decodeString_1(_ s: String) -> String {
        func _decodeString(_ s : String, _ k : inout Int) -> String {
            var res = ""
            var repeatCount = 0
            while k < s.count {
                let ch = s.charAt(k)
                if ch.isNum() {
                    repeatCount = repeatCount * 10 + Int(String(ch))!
                    k += 1
                    
                } else if ch == "[" {
                    k += 1
                    let subDecodeStr = _decodeString(s, &k)
                    for _ in 0 ..< repeatCount {
                        res.append(subDecodeStr)
                    }
                    // 这里在根据repeatCount拼接解码后的子字符串之后，一定要将其重置为0
                    // 因为k的位置是各层递归共享的，代码走到这里时可以理解为k之前的都是解码完成的
                    // 如果后面还有需要解码的字符串的话，repeatCount 需要重新计算。
                    repeatCount = 0
                    
                } else if ch == "]" {
                    k += 1
                    return res
                    
                } else {
                    res.append(ch)
                    k += 1
                }
            }
            return res
        }
        var k = 0
        return _decodeString(s, &k)
    }
    
    // MARK: -------------- 图像渲染 leetCode #733
    /*
     https://leetcode-cn.com/problems/flood-fill/
     有一幅以二维整数数组表示的图画，每一个整数表示该图画的像素值大小，数值在 0 到 65535 之间。
     给你一个坐标 (sr, sc) 表示图像渲染开始的像素值（行 ，列）和一个新的颜色值 newColor，让你重新上色这幅图像。
     为了完成上色工作，从初始坐标开始，记录初始坐标的上下左右四个方向上像素值与初始坐标相同的相连像素点，
     接着再记录这四个方向上符合条件的像素点与他们对应四个方向上像素值与初始坐标相同的相连像素点，……，重复该过程。
     将所有有记录的像素点的颜色值改为新的颜色值。最后返回经过上色渲染后的图像。
     
     示例 1:
     输入:
     image = [[1,1,1],[1,1,0],[1,0,1]]
     1 1 1
     1 1 0
     1 0 1
     sr = 1, sc = 1, newColor = 2
     输出: [[2,2,2],[2,2,0],[2,0,1]]
     2 2 2
     2 2 0
     2 0 1
     
     解析:
     在图像的正中间，(坐标(sr,sc)=(1,1)),
     在路径上所有符合条件的像素点的颜色都被更改成2。
     注意，右下角的像素没有更改为2，
     因为它不是在上下左右四个方向上与初始点相连的像素点。
     */
    
    /*
     思路与LeetCode 200（岛屿的个数）思路类似，从(sr, sc)点出发深度优先搜索上下左右四个邻居结点，
     如果邻居结点的值与image[sr][sc]相等的话，将其值设置为newColor。
     */
    func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {
        func _dfs(_ r : Int, _ c : Int, _ image : inout [[Int]], _ targetValue : Int, _ visited : inout [[Int] : Bool], _ newColor : Int) {
            guard !image.isEmpty, r >= 0, c >= 0, r < image.count, c < image[0].count else {
                return
            }
            
            guard image[r][c] == targetValue else {
                return
            }
            
            if visited[[r, c]] != nil && visited[[r, c]]! == true {
                return
            }
            
            image[r][c] = newColor
            visited[[r, c]] = true
            _dfs(r+1, c, &image, targetValue, &visited, newColor)
            _dfs(r-1, c, &image, targetValue, &visited, newColor)
            _dfs(r, c+1, &image, targetValue, &visited, newColor)
            _dfs(r, c-1, &image, targetValue, &visited, newColor)
        }
        
        guard !image.isEmpty, sr < image.count, sc < image[0].count else {
            return image
        }
        
        var visited = [[Int] : Bool]()
        let targetValue = image[sr][sc]
        var resImage = image
        _dfs(sr, sc, &resImage, targetValue, &visited, newColor)
        return resImage
    }
    
    // MARK: -------------- 01矩阵 leetCode #542
    /*
     https://leetcode-cn.com/problems/01-matrix/
     给定一个由 0 和 1 组成的矩阵，找出每个元素到最近的 0 的距离。
     两个相邻元素间的距离为 1 。
     
     示例 1:
     输入:
     0 1 0
     1 1 1
     0 1 0
     
     输出:
     0 1 0
     1 2 1
     0 1 0
     
     
     示例 2:
     输入:
     1 1 1 1
     1 1 1 0
     1 0 1 1
     1 1 1 1
     
     输出:
     3 2 2 1
     2 1 1 0
     1 0 1 1
     2 1 2 2
     
     注意:
     给定矩阵的元素个数不超过 10000。
     给定矩阵中至少有一个元素是 0。
     矩阵中的元素只在四个方向上相邻: 上、下、左、右。
    */
    
    /*
     解法1：迷宫思路和bfs
     既然是求到0的最短路径步数，那么首先想到的就是用bfs，如果对矩阵的每一个元素进行bfs会超时。
     在参考了网上的帖子之后发现了一个不错的思路：以值0的结点为起点做bfs并更新周围结点的距离。
     1. 遍历数组将数组中不为0的元素都设置为比较大的值这里是Int.max（可以理解为0到0的最近距离为0），然后将每一个值0的元素加入到队列，
     2. 逐个处理队列中的结点，先看当前节点上下左右的邻居结点（因为是从上下左右四个方向走到当前结点的），然后将这个邻居结点加入队列用于之后处理。
        如果邻居结点的值大于当前结点值k加上1，则更新该邻居结点的值为k+1，如果小于等于k+1,则说明存在更短的从该邻居结点到0的路径，此时则不用更新。
     重复2
     参考：https://leetcode.com/problems/01-matrix/discuss/101039/java-33ms-solution-with-two-sweeps-in-on
     */
    func updateMatrix(_ matrix : [[Int]]) -> [[Int]] {
        typealias Point = (x : Int, y : Int)
        guard !matrix.isEmpty, !matrix[0].isEmpty else {
            return []
        }
        var matrix = matrix
        let queue = BasicQueue<Point>()
        for i in 0 ..< matrix.count {
            for j in 0 ..< matrix[0].count {
                if matrix[i][j] != 0 {
                    matrix[i][j] = Int.max
                } else {
                    queue.enqueue((i, j))
                }
            }
        }
        func updateDistance(_ neibPoint: Point, _ srcPoint : Point) {
            if matrix[neibPoint.x][neibPoint.y] > matrix[srcPoint.x][srcPoint.y]+1 {
                // 如果邻居结点的值大于等于当前结点值+1，则需要更新，此时才入队列
                // 如果小于当前结点值+1，则说明有另外一条道路，其起点为该邻居结点，终点为0结点，它的距离更短一些，此时则不需要加入队列。
                matrix[neibPoint.x][neibPoint.y] = matrix[srcPoint.x][srcPoint.y]+1
                queue.enqueue((neibPoint.x, neibPoint.y))
            }
        }
        
        while !queue.isEmpty() {
            let front = queue.front()!
            queue.dequeue()
            let x = front.x
            let y = front.y
            if x > 0 {
                updateDistance((x-1, y), front)
            }
            if y > 0 {
                updateDistance((x, y-1), front)
            }
            if x < matrix.count-1 {
                updateDistance((x+1, y), front)
            }
            if y < matrix[0].count-1 {
                updateDistance((x, y+1), front)
            }
        }
        return matrix
    }
    
    // MARK: -------------- 钥匙和房间 leetCode #841
    /*
     https://leetcode-cn.com/problems/keys-and-rooms/
     有 N 个房间，开始时你位于 0 号房间。每个房间有不同的号码：0，1，2，...，N-1，并且房间里可能有一些钥匙能使你进入下一个房间。
     在形式上，对于每个房间 i 都有一个钥匙列表 rooms[i]，每个钥匙 rooms[i][j] 由 [0,1，...，N-1] 中的一个整数表示，其中 N = rooms.length。 钥匙 rooms[i][j] = v 可以打开编号为 v 的房间。
     最初，除 0 号房间外的其余所有房间都被锁住。
     你可以自由地在房间之间来回走动。
     如果能进入每个房间返回 true，否则返回 false。
     
     示例 1：
     输入: [[1],[2],[3],[]]  输出: true
     解释:
     我们从 0 号房间开始，拿到钥匙 1。
     之后我们去 1 号房间，拿到钥匙 2。
     然后我们去 2 号房间，拿到钥匙 3。
     最后我们去了 3 号房间。
     由于我们能够进入每个房间，我们返回 true。
     
     示例 2：
     输入：[[1,3],[3,0,1],[2],[0]]
     输出：false
     解释：我们不能进入 2 号房间。
     */
    /*
     使用栈存储可以去到的房间号，用set记录每一个房间号。
     每去到一个房间，就将该房间的号码从set中删除掉，然后将该房间中的钥匙所对应的房间号入栈。
     每次去栈顶元素所对应的房间并且栈pop，如果最后栈空了但是set还不为空，则代表还有房间没有去过。
     那么这些房间自然就是不能访问到的
     */
    func canVisitAllRooms(_ rooms: [[Int]]) -> Bool {
        return self.canVisitAllRooms_dfs(rooms)
        if rooms.isEmpty {
            return true
        }
        if rooms[0].isEmpty {
            return false
        }
        var roomIdSet = Set<Int>()
        for i in 0 ..< rooms.count {
            roomIdSet.insert(i)
        }
        
        var visited = Array<Bool>(repeating: false, count: rooms.count)
        let stack = BasicStack<Int>()
        stack.push(0)
        while !stack.isEmpty() {
            let currRoom = stack.top()!
            visited[currRoom] = true
            stack.pop()
            roomIdSet.remove(currRoom)
            for roomKey in rooms[currRoom] {
                if roomKey != currRoom && visited[roomKey] == false {
                    stack.push(roomKey)
                }
            }
        }
        return roomIdSet.count == 0
    }
    
    /*
     dfs
     使用count变量记录访问过的房间数。
     从0号房间触发，当进入到房间i之后如果visited[i]==false,则代表没有访问过该房间，此时count+=1
     在房间i中的钥匙串中找到还没有进入到的房间（visited[i]==false）并进入到该房间（dfs）。以此类推。
     最后如果count == rooms.count 则代表所有房间都访问过了。
     */
    func canVisitAllRooms_dfs(_ rooms: [[Int]]) -> Bool {
        func dfs(roomId : Int, rooms : inout [[Int]], visited : inout [Bool], count : inout Int) {
            if !visited[roomId] {
                count += 1
            }
            visited[roomId] = true
            for keyToRoom in rooms[roomId] {
                if !visited[keyToRoom] {
                    // 没访问过
                    dfs(roomId: keyToRoom, rooms: &rooms, visited: &visited, count: &count)
                }
            }
        }
        var visited = Array<Bool>(repeating: false, count: rooms.count)
        var rooms = rooms
        var count = 0
        dfs(roomId: 0, rooms: &rooms, visited: &visited, count : &count) // 从0号房间出发
        return count == rooms.count
    }
    
    /*
     bfs
     依旧使用count来记录访问过的房间数目，使用队列进行广度优先搜索。
     当进入一个房间i（queue.front(), queue.dequeue()），
     如果该房间没有被访问过，则count+=1，并且visited[i]=true。
     重放上述步骤直到队列为空，则代表能访问过的房间都访问过了。此时比较count和rooms的个数。
     如果不相等，则说明一定有房间还没有被访问过。
     */
    func canVisitAllRooms_bfs(_ rooms: [[Int]]) -> Bool {
        var count = 0
        var visited = Array<Bool>(repeating: false, count: rooms.count)
        let queue = BasicQueue<Int>()
        queue.enqueue(0)
        
        while queue.isEmpty() == false {
            let currRoom = queue.front()!
            queue.dequeue()
            if visited[currRoom] == false {
                count += 1
            }
            visited[currRoom] = true
            for keyToRoom in rooms[currRoom] {
                if visited[keyToRoom] == false {
                    queue.enqueue(keyToRoom)
                }
            }
        }
        return count == rooms.count
    }
}


