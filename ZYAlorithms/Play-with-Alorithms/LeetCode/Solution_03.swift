//
//  Solution_03.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2018/8/28.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation


extension Solution {
    
    // MARK: -------------- 唯一摩尔斯密码词 leetCode #804
    /*
     https://leetcode-cn.com/problems/unique-morse-code-words/description/
     国际摩尔斯密码定义一种标准编码方式，将每个字母对应于一个由一系列点和短线组成的字符串，
     比如: "a" 对应 ".-", "b" 对应 "-...", "c" 对应 "-.-.", 等等。
     为了方便，所有26个英文字母对应摩尔斯密码表如下：[".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
     给定一个单词列表，每个单词可以写成每个字母对应摩尔斯密码的组合。
     例如，"cab" 可以写成 "-.-.-....-"，(即 "-.-." + "-..." + ".-"字符串的结合)。我们将这样一个连接过程称作单词翻译。
     返回我们可以获得所有词不同单词翻译的数量。
     
     例如:
     输入: words = ["gin", "zen", "gig", "msg"]   输出: 2
     解释:
     各单词翻译如下:
     "gin" -> "--...-."
     "zen" -> "--...-."
     "gig" -> "--...--."
     "msg" -> "--...--."
     
     共有 2 种不同翻译, "--...-." 和 "--...--.".
     */
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        
        let morse : [String] = [".-","-...","-.-.","-..",".","..-.","--.","....",
                                "..",".---","-.-",".-..","--","-.","---",".--.","--.-",
                                ".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
        let letters : [Character] = ["A","B","C","D","E","F","G","H","I","J","K","L","M",
                                     "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        var total = [String : Int]()
        for i in 0 ..< words.count {
            var res : String = ""
            let s = words[i].uppercased()
            for c in s {
                let index = letters.index(of: c) ?? -1
                if index < 0 {
                    return -1
                }
                res = res + morse[index]
            }
            total[res] = 1
        }
        return total.keys.count
    }

    // MARK: -------------- 实现strStr() leetCode #28
    /*
     https://leetcode-cn.com/problems/implement-strstr/description/
     实现 strStr() 函数。
     给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回  -1。
     
     示例 1:
     输入: haystack = "hello", needle = "ll"  输出: 2
     
     示例 2:
     输入: haystack = "aaaaa", needle = "bba" 输出: -1
     
     说明:
     当 needle 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。
     对于本题而言，当 needle 是空字符串时我们应当返回 0 。这与C语言的 strstr() 以及 Java的 indexOf() 定义相符。
     */
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        let m = haystack.count, n = needle.count
        if n == 0 { return 0 }
        if m < n  { return -1 }
        func char(at i : Int ,in s : String) -> Character {
            return s[s.index(s.startIndex, offsetBy: i)]
        }
        for i in 0 ... m - n {
            var j = 0
            while j < n {
                if char(at: i+j, in: haystack) != char(at: j, in: needle) {
                    break
                }
                j += 1
            }
            if j == n { return i }
        }
        return -1
    }
    
    // MARK: -------------- 合并两个有序链表 leetCode #21
    /*
     https://leetcode-cn.com/problems/merge-two-sorted-lists/
     将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
     输入：1->2->4, 1->3->4
     输出：1->1->2->3->4->4
     */
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1, l2 = l2
        var dummy : ListNode? = ListNode(0)
        let newHeader = dummy
        while l1 != nil && l2 != nil {
            if l1!.val > l2!.val {
                dummy?.next = l2
                l2 = l2!.next
            } else {
                dummy?.next = l1
                l1 = l1!.next
            }
            dummy = dummy?.next
        }
        while l2 != nil {
            dummy?.next = l2
            dummy = dummy?.next
            l2 = l2!.next
        }
        while l1 != nil {
            dummy?.next = l1
            dummy = dummy?.next
            l1 = l1!.next
        }
        return newHeader?.next
    }
    
    // MARK: -------------- 字母大小写全排列 leetCode #784
    /*
     https://leetcode-cn.com/problems/letter-case-permutation/
     给定一个字符串S，通过将字符串S中的每个字母转变大小写，我们可以获得一个新的字符串。返回所有可能得到的字符串集合。
     示例:
     输入: S = "a1b2"
     输出: ["a1b2", "a1B2", "A1b2", "A1B2"]
     
     输入: S = "3z4"
     输出: ["3z4", "3Z4"]
     
     输入: S = "12345"
     输出: ["12345"]
     
     注意：
     S 的长度不超过12。
     S 仅由数字和字母组成。
     */
    func letterCasePermutation_1(_ S: String) -> [String] {
        func isNum( _ s : String) -> Bool {
            let scan = Scanner(string: s)
            var val : Int = 0
            return scan.scanInt(&val) && scan.isAtEnd
        }
        func char(at i : Int, _ s : String) -> String {
            return String(s[s.index(s.startIndex, offsetBy: i)])
        }
        var source : [String] = []
        for i in 0 ..< S.count {
            source.append(char(at: i, S))
        }
        var res = [String]()
        let n = S.count
        func backTrace(t : Int, src : [String], s :  String) {
            if t >= n {
                res.append(s)
            } else {
                if isNum(source[t]) {
                    backTrace(t: t+1, src: source, s: s+source[t])
                    return
                }
                for i in 0 ... 1 {
                    if i == 0 { //小写
                        backTrace(t: t+1, src: source, s: s+source[t].lowercased())
                        
                    } else { // i == 1 大写
                        backTrace(t: t+1, src: source, s: s+source[t].uppercased())
                    }
                }
            }
        }
        backTrace(t: 0, src: source, s: "")
        return res
    }
    
    func letterCasePermutation_2(_ S: String) -> [String] {
        
        func isChar(_ c : String) -> Bool {
            return (c >= "a" && c <= "z") || (c >= "A" && c <= "Z")
        }
        func char(at i : Int, _ s : String) -> String {
            return String(s[s.index(s.startIndex, offsetBy: i)])
        }
        func rmChar(at i : Int, s : String) -> String {
            var s = s
            if i < 0 || i >= s.count { return s }
            let range = s.index(s.startIndex, offsetBy: i) ... s.index(s.startIndex, offsetBy: i)
            s.replaceSubrange(range, with: "")
            return s
        }
        
        var source : [String] = []
        for i in 0 ..< S.count {
            source.append(char(at: i, S))
        }
        
        var res = [String]()
        let n = source.count
        func backTrace(t : Int, s : String , src : [String]) {
            var s = s
            if t >= n {
                res.append(s)
                return
            }
            if isChar(src[t]) {
                //解空间左子树
                s += src[t].uppercased()
                backTrace(t: t+1, s: s, src: src)
                s = rmChar(at: s.count-1, s: s)  //回溯
                
                //解空间右子树
                s += src[t].lowercased()
                backTrace(t: t+1, s: s, src: src)
                s = rmChar(at: s.count-1, s: s)  //回溯
                
            } else {
                //不是字母则直接添加
                s += src[t]
                backTrace(t: t+1, s: s, src: src)
            }
        }
        backTrace(t: 0, s: "", src: source)
        return res
    }
    
    // MARK: -------------- 二进制手表 leetCode #401
    /*
     https://leetcode-cn.com/problems/binary-watch/
     二进制手表顶部有 4 个 LED 代表小时（0-11），底部的 6 个 LED 代表分钟（0-59）。
     (hour : 1, 2, 4, 8    min : 1, 2, 4, 8, 16, 32)
     每个 LED 代表一个 0 或 1，最低位在右侧。
     给定一个非负整数 n 代表当前 LED 亮着的数量，返回所有可能的时间。
     
     案例:
     输入: n = 1
     返回: ["1:00", "2:00", "4:00", "8:00", "0:01", "0:02", "0:04", "0:08", "0:16", "0:32"]

     注意事项:
     输出的顺序没有要求。
     小时不会以零开头，比如 “01:00” 是不允许的，应为 “1:00”。
     分钟必须由两位数组成，可能会以零开头，比如 “10:2” 是无效的，应为 “10:02”。
     
     参考：
     https://blog.csdn.net/camellhf/article/details/52738031
     https://blog.csdn.net/whl_program/article/details/71155498
     */
    //回溯法
    func readBinaryWatch(_ num: Int) -> [String] {
        typealias Time = (totalHours : Int, totalMins : Int)
        var res : [String] = []
        let hours : [Int] = [1,2,4,8]
        let mins  : [Int] = [1,2,4,8,16,32]
        let count = hours.count + mins.count
        let t : Time = (0, 0)
        
        //回溯函数
        func helper(time : Time, num : Int, startIndex : Int) {
            var time = time
            if num == 0 {
                if time.totalMins < 10 {
                    res.append("\(time.totalHours):0\(time.totalMins)")
                } else {
                    res.append("\(time.totalHours):\(time.totalMins)")
                }
                return
            }
            
            for i in startIndex ..< count {
                if i < hours.count {
                    time.totalHours += hours[i]
                    if time.totalHours < 12 {
                        helper(time: time, num: num - 1, startIndex : i + 1)
                    }
                    time.totalHours -= hours[i]
                
                } else {
                    let idx = i - hours.count
                    time.totalMins += mins[idx]
                    if time.totalMins < 60 {
                        helper(time: time, num: num - 1, startIndex : i + 1)
                    }
                    time.totalMins -= mins[idx]
                }
            }
        }
        //入口
        helper(time: (0,0), num: num, startIndex : 0)
        
        return res
    }
    
    
    // MARK: -------------- 赎金信 leetCode #383
    /*
     https://leetcode-cn.com/problems/ransom-note/
     给定一个赎金信 (ransom) 字符串和一个杂志(magazine)字符串，
     判断第一个字符串ransom能不能由第二个字符串magazines里面的字符构成。
     如果可以构成，返回 true ；否则返回 false。
     
     (题目说明：为了不暴露赎金信字迹，要从杂志上搜索各个需要的字母，组成单词来表达意思。杂志上面的字母个数要够用，用一个少一个)
     你可以假设两个字符串均只含有小写字母。
     canConstruct("a", "b") -> false
     canConstruct("aa", "ab") -> false
     canConstruct("aa", "aab") -> true
     
     参考：
     http://www.cnblogs.com/strengthen/p/9775114.html
     */
    func canConstruct1(_ ransomNote: String, _ magazine: String) -> Bool {
        func char(at i : Int, _ s : String) -> Character {
            return s[s.index(s.startIndex, offsetBy: i)]
        }
        
        func charIndex(_ c : Character) -> Int {
            if c >= "a" && c <= "z" {
                return getASCII(c) - getASCII("a")
            } else if c >= "A" && c <= "Z" {
                return getASCII(c) - getASCII("A") + 26
            } else {
                return -1
            }
        }
        
        func getASCII(_ c : Character) -> Int {
            var num = 0
            for scalar in String(c).unicodeScalars {
                num = Int(scalar.value)
            }
            return num
        }
        
        /*
         构建一个针对每一个字母出现个数的字符表，由于区分大小写，所以表里面有52个元素
         */
        func charCountTable(_ s : String) -> [Int] {
            var res : [Int] = Array(repeating: 0, count: 52)
            for i in 0 ..< s.count {
                let c = char(at: i, s)
                let index = charIndex(c)
                if index >= 0 && index < res.count {
                    res[index] += 1
                }
            }
            return res
        }
        
        /*
         针对杂志出现的字母构建字母个数表
         ransomNote出现一个字母，字母表改字母对应位置的元素中就减去1，如果该元素小于0
         则说明字母个数不够用，返回false
         */
        var magazineTable = charCountTable(magazine)
        for i in 0 ..< ransomNote.count {
            let c = char(at: i, ransomNote)
            let index = charIndex(c)
            if index < 0 {
                continue
            }
            magazineTable[index] -= 1
            if magazineTable[index] < 0 {
                return false
            }
        }
        return true
    }
    
    /*
     1.优化版，使用了for in 通过String的indices来遍历每一个字符
     2.由于只存在小写字符，所以直接减去97即可不需要再通过api获取a的ASCII码
     */
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var tb = Array(repeating: 0, count: 26)
        for index in magazine.indices {
            let char : Character = magazine[index]
            for asc in char.unicodeScalars {
                let num = Int(asc.value - 97)
                tb[num] += 1
            }
        }
        for index in ransomNote.indices {
            let char : Character = ransomNote[index]
            for asc in char.unicodeScalars {
                let num = Int(asc.value - 97)
                tb[num] -= 1
                if tb[num] < 0 {
                    return false
                }
            }
        }
        return true
    }
    
    // MARK: -------------- 有效的字母异位词 leetCode #242
    /*
     https://leetcode-cn.com/problems/valid-anagram/
     给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的一个字母异位词。
     
     示例 1:
     输入: s = "anagram", t = "nagaram" 输出: true
     
     示例 2:
     输入: s = "rat", t = "car" 输出: false
     
     说明:  你可以假设字符串只包含小写字母。
     进阶:  如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？
     */
    //使用字典（可以包含所有字符：字母，数字，中文，特殊符号等）
    func isAnagram(_ s: String, _ t: String) -> Bool {
        var dic : [Character : Int] = [:]
        for index in t.indices {
            let c = t[index]
            if let count = dic[c] {
                dic[c] = count + 1
            } else {
                dic[c] = 1
            }
        }
        for index in s.indices {
            let c = s[index]
            if let count = dic[c] {
                if count <= 0 {
                    return false
                } else {
                    dic[c] = count - 1
                }
            } else {
                return false
            }
        }
        for (_, value) in dic {
            if value != 0 {
                return false
            }
        }
        return true
    }
    
    //只包含小写字母，使用字母表（同#383赎金信），速度会快一些
    func isAnagram1(_ s: String, _ t: String) -> Bool {
        var tb_s = Array(repeating: 0, count: 26)
        for index in s.indices {
            let char : Character = s[index]
            for asc in char.unicodeScalars {
                let num = Int(asc.value - 97)
                tb_s[num] += 1
            }
        }
        
        var tb_t = Array(repeating: 0, count: 26)
        for index in t.indices {
            let char : Character = t[index]
            for asc in char.unicodeScalars {
                let num = Int(asc.value - 97)
                tb_t[num] += 1
            }
        }
        for i in 0 ..< 26 {
            if tb_s[i] != tb_t[i] {
                return false
            }
        }
        return true
    }
    
    // MARK: -------------- 构造矩形 leetCode #492
    /*
     https://leetcode-cn.com/problems/construct-the-rectangle/
     现给定一个具体的矩形页面面积，你的任务是设计一个长度为 L 和宽度为 W 且满足以下要求的矩形的页面。要求：
     1. 你设计的矩形页面必须等于给定的目标面积。
     2. 宽度 W 不应大于长度 L，换言之，要求 L >= W 。
     3. 长度 L 和宽度 W 之间的差距应当尽可能小。
     
     你需要按顺序输出你设计的页面的长度 L 和宽度 W。
     示例：
     输入: 4   输出: [2, 2]
     解释: 目标面积是 4， 所有可能的构造方案有 [1,4], [2,2], [4,1]。
     但是根据要求2，[1,4] 不符合要求; 根据要求3，[2,2] 比 [4,1] 更能符合要求.
     所以输出长度 L 为 2， 宽度 W 为 2。
     
     说明:
     给定的面积不大于 10,000,000 且为正整数。
     你设计的页面的长度和宽度必须都是正整数。
     参考：
     */
    func constructRectangle1(_ area: Int) -> [Int] {
        if area <= 0 {
            return [0, 0]
        }
        if area < 3 {
            return [area, 1]
        }
        if area == 4 {
            return [2, 2]
        }
        var res = [Int]()
        var minSub = area
        for i in 1 ... area/3 {
            let a = area % i
            let b = area / i
            if a == 0 && abs(i-b) < minSub{
                minSub = abs(i-b)
                if i < b {
                    res = [b, i]
                } else {
                    res = [i, b]
                }
            }
        }
        return res
    }

    /*
     优化之后，执行效率大大提高，上一个方法大概1300ms，优化之后达到大概12ms
     只需要从area的平方根转为Int的值开始到0遍历即可
     离平方根越近的两个值之间的差最小
     */
    func constructRectangle(_ area: Int) -> [Int] {
        var res = [Int]()
        for i in stride(from: Int(sqrt(Double(area))), to: 0, by: -1) {
            if area % i == 0 {
                res = [area/i, i]
                break
            }
        }
        return res
    }
    
    
    // MARK: -------------- 最后一个单词的长度 leetCode #58
    /*
     https://leetcode-cn.com/problems/length-of-last-word/
     给定一个仅包含大小写字母和空格 ' ' 的字符串，返回其最后一个单词的长度。 如果不存在最后一个单词，请返回 0 。
     说明：一个单词是指由字母组成，但不包含任何空格的字符串。
     示例:
     输入: "Hello World"  输出: 5
     */
    
    func lengthOfLastWord1(_ s: String) -> Int {
        if s.isEmpty { return 0 }
        var index = s.count - 1
        for i in stride(from: s.count - 1, through: 0, by: -1) {
            let c = s[s.index(s.startIndex, offsetBy: i)]
            if c != " " {
                index = i
                break
            }
        }
        var count = 0
        for i in stride(from: index, through: 0, by: -1) {
            let c = s[s.index(s.startIndex, offsetBy: i)]
            if c == " " {
                break
            } else {
                count += 1
            }
        }
        return count
    }
    
    //优化
    //从后往前遍历字符，遇到第一个字母就开始计数，之前的空格都跳过
    func lengthOfLastWord(_ s: String) -> Int {
        if s.isEmpty { return 0 }
        var count = 0
        var getChar = false
        for i in stride(from: s.count - 1, through: 0, by: -1) {
            let c = s[s.index(s.startIndex, offsetBy: i)]
            if c == " " {
                if getChar {
                   break
                }
            } else {
                count += 1
                getChar = true
            }
        }
        return count
    }
    
    
    
    // MARK: -------------- 快乐数 leetCode #202
    /*
     https://leetcode-cn.com/problems/happy-number/
     编写一个算法来判断一个数是不是“快乐数”。
     一个“快乐数”定义为：对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和，
     然后重复这个过程直到这个数变为 1，也可能是无限循环但始终变不到 1。如果可以变为 1，那么这个数就是快乐数。
     示例:
     输入: 19   输出: true
     解释:
     1^2 + 9^2 = 82
     8^2 + 2^2 = 68
     6^2 + 8^2 = 100
     1^2 + 0^2 + 0^2 = 1
     
     参考： https://www.cnblogs.com/aprilcheny/p/4930174.html
     */
    /*
     解法1：
     可以发现，任意一个大于1的数执行上述循环过程若干次后，都会得到一个小于等于10的数。
     因此我们先算出[0,10]之间哪些是快乐数并保存下来，然后对输入数字不断进行上述过程循环，
     直至小于等于10，再判断即可。
     */
    func isHappy(_ n: Int) -> Bool {
        func sum(_ n : Int) -> Int {
            var sum = 0
            var arr = [Int](), n = n
            while n > 0 {
                arr.append(n % 10)
                n = n / 10
            }
            for i in 0 ..< arr.count {
                sum += (arr[i] * arr[i])
            }
            return sum
        }
        
        //算出[0,10]之间的快乐数
        let yes : [Bool] = [false, true, false, false, false, false, false, true, false, false, true]
        var n = n
        while n > 10 {
            n = sum(n)
        }
        return yes[n]
    }
    
    /*
     解法2：
     根据定义，一个数经过上述循环过程，要么得到1退出，要么无限循环下去。
     可以发现，无限循环下去的情况会是在若干次循环过程中，某两次得到了不为1的相同数字。
     因此可以将循环过程中得到的数字存下来，再下一次循环后得到的数字与前面的进行比较，若出现过则终止循环并与1进行比较。
     */
    func isHappy_1(_ n: Int) -> Bool {
        func sum(_ n : Int) -> Int {
            var sum = 0
            var arr = [Int](), n = n
            while n > 0 {
                arr.append(n % 10)
                n = n / 10
            }
            for i in 0 ..< arr.count {
                sum += (arr[i] * arr[i])
            }
            return sum
        }
        var set = Set<Int>(), n = n
        while n != 1 {
            n = sum(n)
            print("res : \(n)")
            if set.contains(n) {
                break
            }
            set.insert(n)
        }
        return n == 1
    }
    
    // MARK: -------------- 存在重复元素 leetCode #217
    /*
     https://leetcode-cn.com/problems/contains-duplicate/
     给定一个整数数组，判断是否存在重复元素。
     如果任何值在数组中出现至少两次，函数返回 true。如果数组中每个元素都不相同，则返回 false。
     示例 1:
     输入: [1,2,3,1]  输出: true
     
     示例 2:
     输入: [1,2,3,4]  输出: false
     
     示例 3:
     输入: [1,1,1,3,3,4,3,2,4,2] 输出: true
     */
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var set = Set<Int>()
        for n in nums {
            if set.contains(n) {
                return true
            }
            set.insert(n)
        }
        return false
    }
    
    
    // MARK: -------------- 两个数组的交集 II leetCode #350
    /*
     https://leetcode-cn.com/problems/intersection-of-two-arrays-ii/
     给定两个数组，编写一个函数来计算它们的交集。
     示例 1:
     输入: nums1 = [1,2,2,1], nums2 = [2,2]    输出: [2,2]
     
     示例 2:
     输入: nums1 = [4,9,5], nums2 = [9,4,9,8,4] 输出: [4,9]
     
     说明：
     输出结果中每个元素出现的次数，应与元素在两个数组中出现的次数一致。
     我们可以不考虑输出结果的顺序。
     
     进阶:
     如果给定的数组已经排好序呢？你将如何优化你的算法？
     如果 nums1 的大小比 nums2 小很多，哪种方法更优？
     如果 nums2 的元素存储在磁盘上，磁盘内存是有限的，并且你不能一次加载所有的元素到内存中，你该怎么办？
     */
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var dic = [Int : Int]()
        for n in nums1 {
            if let count = dic[n] {
                dic[n] = count + 1
            } else {
                dic[n] = 1
            }
        }
        var res = [Int]()
        for n in nums2 {
            if let count = dic[n], count > 0 {
                res.append(n)
                dic[n] = count - 1
            }
        }
        return res
    }
    
    func intersect_1(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let arr1 = nums1.sorted { (a, b) -> Bool in
            return a < b
        }
        let arr2 = nums2.sorted { (a, b) -> Bool in
            return a < b
        }
        var res = [Int]()
        var idx1 = 0, idx2 = 0
        while idx1 < arr1.count && idx2 < arr2.count {
            let curr1 = arr1[idx1], curr2 = arr2[idx2]
            if curr1 == curr2 {
                idx1 += 1
                idx2 += 1
                res.append(curr1)
                
            } else if curr1 < curr2 {
                idx1 += 1
            } else {
                idx2 += 1
            }
        }
        return res
    }
}
