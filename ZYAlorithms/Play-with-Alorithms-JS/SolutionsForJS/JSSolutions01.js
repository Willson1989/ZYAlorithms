

class BasicQueue {
    constructor() {
        this.data = [];
        this.enqueue = function (val) {
            data.push(val);
        };
        this.dequeue = function () {
            if (this.data.length == 0) {
                return null;
            }
            return this.data.shift();
        };
        this.size = function () {
            return this.data.length;
        };
    }
}

class TreeNode {
    constructor(val) {
        this.val = val;
        this.left = this.right = null;
    }
}

/*
leetCode #26  删除排序数组中的重复项
https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array/
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
var removeDuplicates = function (nums) {
    let i = 0
    for (let j = 1; j < nums.length; j++) {
        if (nums[j] != nums[i]) {
            i++
            nums[i] = nums[j]
        }
    }
    return i + 1
};


/**
leetCode #53  最大子序和
https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array/
给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

示例:

输入: [-2,1,-3,4,-1,2,1,-5,4],
输出: 6
解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
进阶:

如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的分治法求解。
 * @param {number[]} nums
 * @return {number}
 */
var maxSubArray = function (nums) {
    let dp = new Array(nums.length)
    dp[0] = nums[0]
    let res = dp[0]
    for (let i = 1; i < nums.length; i++) {
        dp[i] = Math.max(dp[i - 1] + nums[i], nums[i])
        res = Math.max(dp[i], res)
    }
    return res
};


/*
leetCode #278 第一个错误的版本
https://leetcode-cn.com/problems/first-bad-version/
你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。
由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错的。
假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。
你可以通过调用 bool isBadVersion(version) 接口来判断版本号 version 是否在单元测试中出错。
实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。

示例:
给定 n = 5，并且 version = 4 是第一个错误的版本。
调用 isBadVersion(3) -> false
调用 isBadVersion(5) -> true
调用 isBadVersion(4) -> true
所以，4 是第一个错误的版本。
 
 */
/**
 * Definition for isBadVersion()
 * 
 * @param {integer} version number
 * @return {boolean} whether the version is bad
 * isBadVersion = function(version) {
 *     ...
 * };
 */

var isBadVersion = function (version) {
    return version >= 2
};
/**
 * @param {function} isBadVersion()
 * @return {function}
 */
var solution = function (isBadVersion) {
    /**
     * @param {integer} n Total versions
     * @return {integer} The first bad version
     */
    return function (n) {
        let l = 1, r = n
        while (l < r) {
            let mid = parseInt(((r - l) / 2 + l))
            if (isBadVersion(mid)) {
                r = mid
            } else {
                l = mid + 1
            }
        }
        return l
    };
};

/*
leetCode #198 打家劫舍
https://leetcode-cn.com/problems/house-robber/
你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，
影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。
给定一个代表每个房屋存放金额的非负整数数组，计算你在不触动警报装置的情况下，能够偷窃到的最高金额。

示例 1:
输入: [1,2,3,1] 输出: 4
解释: 偷窃 1 号房屋 (金额 = 1) ，然后偷窃 3 号房屋 (金额 = 3)。
     偷窃到的最高金额 = 1 + 3 = 4 。

示例 2:
输入: [2,7,9,3,1]  输出: 12
解释: 偷窃 1 号房屋 (金额 = 2), 偷窃 3 号房屋 (金额 = 9)，接着偷窃 5 号房屋 (金额 = 1)。
     偷窃到的最高金额 = 2 + 9 + 1 = 12 。
 */
/**
 * @param {number[]} nums
 * @return {number}
 */
var rob = function (nums) {
    let dp = new Array()
    dp[0] = nums[0]
    dp[1] = Math.max(nums[0], nums[1])
    for (let i = 2; i < nums.length; i++) {
        dp[i] = Math.max(dp[i - 2] + nums[i], dp[i - 1])
    }
    return dp[nums.length - 1]
};

/*
leetCode #104 二叉树的最大深度
https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/
给定一个二叉树，找出其最大深度。

二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。

说明: 叶子节点是指没有子节点的节点。

示例：
给定二叉树 [3,9,20,null,null,15,7]，

    3
   / \
  9  20
    /  \
   15   7
返回它的最大深度 3 。
 */

/**
 * @param {TreeNode} root
 * @return {number}
 */
var maxDepth = function (root) {
    if (root == null) {
        return 0;
    }
    let leftSize = 1 + maxDepth(root.left)
    let rightSize = 1 + maxDepth(root.right)
    return Math.max(leftSize, rightSize)
};

/*
leetCode #98 验证二叉搜索树
https://leetcode-cn.com/problems/validate-binary-search-tree/
给定一个二叉树，判断其是否是一个有效的二叉搜索树。
假设一个二叉搜索树具有如下特征：
节点的左子树只包含小于当前节点的数。
节点的右子树只包含大于当前节点的数。
所有左子树和右子树自身必须也是二叉搜索树。
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


      10
   5      15
        6    20

*/
/**
 * @param {TreeNode} root
 * @return {boolean}
 * 二叉搜索树的中序遍历是严格递增的
 */
var isValidBST = function (root) {
    let res = [];
    _inorder(root, res);
    for (let i = 0; i < res.length - 1; i++) {
        if (res[i] > res[i + 1]) {
            return false;
        }
    }
    return true;
};

var _inorder = function (root, res) {
    if (root == null) {
        return;
    }
    _inorder(root.left, res);
    res.push(root.val);
    _inorder(root.right, res);
}


var getChars = function (s) {
    let chars = s.split('')
    let ret = [], len = s.length
    var sub = ""
    for (let index = 0; index < chars.length; index++) {
        if (isChar(chars[index])) {
            sub += chars[index]
            if (index == len - 1) {
                ret.push(sub)
            }
        } else {
            if (sub.length > 0) {
                ret.push(sub)
            }
            sub = ""
        }
    }
    return ret
}

