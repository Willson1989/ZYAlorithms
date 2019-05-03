//
//  main.swift
//  Play-with-Alorithms
//
//  Created by WillHelen on 2018/8/17.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    
    var res = [Int]()
    let count = min(nums1.count, nums2.count)
    let arr = nums1.count > nums2.count ? nums2 : nums1
    for i in 0 ..< count {
        let n = arr[i]
        if nums1.contains(n) && nums2.contains(n) && !res.contains(n){
            res.append(n)
        }
    }
    return res
}

func intersection_1(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    return Array(Set<Int>(nums1).intersection(Set<Int>(nums2)))
}

let s = Solution()

let input = [2,1]
print("containsNearbyDuplicate : ",s.containsNearbyAlmostDuplicate(input, 1,1))


let island : [[Character]] =
    [
        []
]
//[
// ["1","1","1","1","0","1","1","1"],
// ["1","1","1","1","0","1","1","1"],
// ["1","1","0","0","0","0","0","0"],
// ["1","1","0","1","1","0","1","1"],
// ["1","1","0","1","1","0","0","1"],
// ["1","1","0","1","1","0","0","1"],
//]

//let ininin = ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]
//let ininin = ["4", "13", "5", "/", "+"]
//let ininin = ["2", "1", "+", "3", "*"]

typealias ATNode = TreeNode<Int>

let n1 = ATNode(1)
let n2 = ATNode(2)
let n3 = ATNode(3)
let n4 = ATNode(4)
let n5 = ATNode(5)
let n6 = ATNode(6)
let n7 = ATNode(7)
let n8 = ATNode(8)

n1.left = n2
n1.right = n3
n2.left = n4
n2.right = n5
n5.left = n8
n3.left = n6
n3.right = n7

print("inorderTraversal   : ",s.inorderTraversal(n1))
print("postorderTraversal : ",s.postorderTraversal(n1))
print("preorderTraversal  : ",s.preorderTraversal(n1))



let inputStr = "kk2[ab2[cd3[e]]2[fg]]hij"
print("input str : ",inputStr)
print("decodeString   : ",s.decodeString(inputStr))
print("decodeString_1 : ",s.decodeString_1(inputStr))

let inputImage = [
    [1, 1, 1, 1],
    [1, 1, 1, 0],
    [1, 0, 0, 1],
    [1, 0, 1, 1]
]
print("input image : ")
for i in 0 ..< inputImage.count {
    print(inputImage[i])
}
print("")
let t = [0,0]
let c = 3
let newImage = s.floodFill(inputImage, t[0], t[1], c)
//let newImage = s.updateMatrix(inputImage)

print("new colored image : ")
for i in 0 ..< newImage.count {
    print(newImage[i])
}

let inputRooms = [[1],[2],[3],[]]
//let inputRooms = [[1,3],[3,0,1],[2],[0]]
//let inputRooms = [[2],[],[1]]

print("canVisitAllRooms : ",s.canVisitAllRooms(inputRooms))


func reBoolaa(_ left : Bool, _ right : @autoclosure () -> Bool) -> Bool {
    if left {
        return true
    } else {
        return right()
    }
}


func tempFunc() -> Bool {
    print("tempFunc")
    return false
}


let res = reBoolaa((2==3), tempFunc())
print("res : ", res)


let singleNumberInput = [4,1,2,1,2]
print("singleNumber : ", s.singleNumber(singleNumberInput))

func mergeSort(_ arr : [Int]) -> [Int] {
    
    func _partition(_ left : Int, _ right : Int, res : inout [Int]) {
        if left >= right {
            return
        }
        let mid = (right - left) / 2 + left
        _partition(left, mid, res: &res)
        _partition(mid+1, right, res: &res)
        _merge(left, mid, right, res: &res)
    }
    
    func _merge(_ left : Int, _ mid : Int, _ right : Int, res : inout [Int]) {
        
        var mergedArr = [Int]()
        var i = left
        var j = mid + 1
        while i <= mid && j <= right {
            if res[i] < res[j] {
                mergedArr.append(res[i])
                i += 1
            } else {
                mergedArr.append(res[j])
                j += 1
            }
        }
        
        while i <= mid {
            mergedArr.append(res[i])
            i += 1
        }
        while j <= right {
            mergedArr.append(res[j])
            j += 1
        }
        
        for i in 0 ..< mergedArr.count {
            res[left + i] = mergedArr[i]
        }
    }
    
    var res = arr
    _partition(0, res.count-1, res: &res)
    return res
}

let mergeSortSrcArr = [3,2,5,4,6,8,1,9,12,10]
print("merge sort res : ", mergeSort(mergeSortSrcArr))


let kClosestInputArr = [[68,97],[34,-84],[60,100],[2,31],[-27,-38],[-73,-74],[-55,-39],[62,91],[62,92],[-57,-67]]

let kClosestInputK = 5
print("kClosest : ",s.kClosest(kClosestInputArr, kClosestInputK))

//let majorityElementIn = [2,3,3,3,3,3,2]
let majorityElementIn = [1]

print("majorityElement : ",s.majorityElement(majorityElementIn))

let searchMatrixIn = [
    [1,   4,  7, 11, 15],
    [2,   5,  8, 12, 19],
    [3,   6,  9, 16, 22],
    [10, 13, 14, 17, 24],
    [18, 21, 23, 26, 30]
]
print("searchMatrix : ",s.searchMatrix(searchMatrixIn, 5))

var merge_Input1 = [1,2,0,0,0,0,0], m = 2
let merge_Input2 = [1,1,2,3,6], n = 5
s.merge_3(&merge_Input1, m, merge_Input2, n)
print("merge_1 : ",merge_Input1)

//let isPalindromeIn = "A man, a plan, a canal: Panama"
let isPalindromeIn =
"A man, a plan, a canal: Panama"

print("isPalindrome : ",s.isPalindrome(isPalindromeIn))

let partitionIn = "aabb"
print("partition res : ",s.partition(partitionIn))

//let wordBreakIn = "leetcode"
//let wordBreakDic = ["leet", "code"]
//let wordBreakIn = "applepenapple"
//let wordBreakDic = ["apple", "pen"]
let wordBreakIn = "catssanddog"
let wordBreakDic = ["cats", "dog", "sand", "and", "cat"]
//let wordBreakIn = "abcd"
//let wordBreakDic = ["a","abc","b","cd"]

//let wordBreakIn = "goalspecial"
//let wordBreakDic = ["go","goal","goals","special"]
print("wordBreak : ",s.wordBreak(wordBreakIn, wordBreakDic))

var bstIn = [15, 26, 28, 27, 4, 18, 14, 2, 10, 17]
//for _ in 0 ..< 10 {
//    let n = Int(arc4random() % 30)
//    bstIn.append(n)
//}
print("bstin : ",bstIn)

var tree = BasicBinarySearchTree<Int, Int>()

for n in bstIn {
    tree.insert(key: n, value: n)
}
var preOres = [Int]()
tree.preOrder { (node) in
    guard let node = node else { return }
    preOres.append(node.val)
}
print("pre order : ",preOres)

var inOrder = [Int]()
tree.inOrder { (node) in
    guard let node = node else { return }
    inOrder.append(node.val)
}
print("in order : ",inOrder)

var postOrder = [Int]()
tree.postOrder() { (node) in
    guard let node = node else { return }
    postOrder.append(node.val)
}
print("post order : ",postOrder)

print("floor : ",tree.floor(20)?.val)
print("ceil  : ",tree.ceil(13)?.val)

let nnn1 = TreeNode<Int>(1)
let nnn2 = TreeNode<Int>(2)
let nnn3 = TreeNode<Int>(3)
let nnn4 = TreeNode<Int>(4)

nnn3.left = nnn1
nnn3.right = nnn4
nnn1.right = nnn2


let nnnres = s.trimBST(nnn1, 1, 2)
print(nnnres)

//// 1-2-4-4-5-4-7-4
//let ln1 = ListNode(4)
//let ln2 = ListNode(2)
//let ln3 = ListNode(4)
//let ln4 = ListNode(4)
//let ln5 = ListNode(5)
//let ln6 = ListNode(4)
//let ln7 = ListNode(7)
//let ln8 = ListNode(9)
//
//ln1.next = ln2
//ln2.next = ln3
//ln3.next = ln4
//ln4.next = ln5
//ln5.next = ln6
//ln6.next = ln7
//ln7.next = ln8
//
//var p: ListNode? = ln1
//
//while p != nil {
//    print("\(p!.val) - ", separator: "", terminator: "")
//    p = p?.next
//}
//
//print()
//
//let newH = s.removeListElements_1(ln1, 4)
//p = newH
//while p != nil {
//    print("\(p!.val) - ", separator: "", terminator: "")
//    p = p?.next
//}

print(" ==========  MyLinkedList: ")
let lll = MyLinkedList_Double()

//lll.addAtHead(1)
//lll.printList()
//lll.addAtTail(3)
//lll.printList()
//lll.addAtIndex(1, 2)
//lll.printList()
//lll.get(1)
//lll.deleteAtIndex(1)
//lll.printList()
//lll.get(1)

let minAddToMakeValidIn = "))()(())(()())((("
print("minAddToMakeValid : ",s.minAddToMakeValid(minAddToMakeValidIn))

let judgeCircleIn = "lrudurudurldddl"
print("judgeCircle : ", s.judgeCircle(judgeCircleIn))

let maxProfitIn = [7,1,5,3,6,4,9]
print("maxProfit : ", s.maxProfit(maxProfitIn))

var rotateIn = [1,2,3]
s.rotate(&rotateIn, 4)
print("rotate : ", rotateIn)


let maximalSquareIn : [[Character]]
    = [["0","1"]]
//                    = [["1","0","1","0","0"],
//                       ["1","0","1","1","1"],
//                       ["1","1","1","1","1"],
//                       ["1","0","0","1","0"]]
print("maximalSquare : ", s.maximalSquare(maximalSquareIn))

//let robIn = [2,7,9,3,1]
let robIn = [1,9]
print("max rob : ", s.rob_1(robIn))

let sortedArrayToBSTIn = [9]
let node = s.sortedArrayToBST(sortedArrayToBSTIn)
print("sortedArrayToBST res : ",s.inorderTraversal(node))

let createBSTIn = [1,2,3,4,5,6,7,8,9]
let createBSTNode = s.createBST(createBSTIn)
print("createBSTIn res : ",s.inorderTraversal(createBSTNode))

print("myAtoi:",s.myAtoi("20000000000000000000"))
