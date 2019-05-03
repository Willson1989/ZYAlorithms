import Foundation

public extension Sort {
    
    //MARK: - 普通快速排序
    /**
     普通快速排序
     
     普通的快速排序，总是取数组中第一个元素为基准值。
     如果待排序的数组为近乎有序的数组的话，这种快速排序会退化为n^2级别的算法，效率大打折扣
     */
    public static func quickSort_Normal(arr : inout [Int]) {
        let len = arr.count
        Sort._quickSort_Normal(arr: &arr, left: 0, right: len - 1)
    }
    
    fileprivate static func _quickSort_Normal(arr : inout [Int], left : Int , right : Int) {
        
        if left >= right {
            return
        }
        //先返回一个p，使得数组前半部分小于v，后半部分大于v
        // p 的位置正好是基准值v的位置
        let p = Sort._partitionArr_Normal(arr: &arr, left: left, right: right)
        
        //递归分别对前后两部分进行快速排序
        Sort._quickSort_Normal(arr: &arr, left: left, right: p-1)
        Sort._quickSort_Normal(arr: &arr, left: p+1,  right: right)
    }
    
    fileprivate static func _partitionArr_Normal(arr : inout [Int], left : Int, right : Int) -> Int{
        
        //返回位置p ,使得a[left ... p-1] < a[p] 和 a[p+1 ... right] > a[p]
        var p = left
        
        //取基准值为数组的第一个元素
        let v = arr[left]
        
        for i in left+1 ... right {
            if arr[i] < v {
                p += 1
                swapElement(&arr, i, p)
            }
        }
        swapElement(&arr, left, p)
        return p
    }
    
    //MARK: - 随机化快速排序
    /**
     随机化快速排序
     
     相比上边的快排算法，这里在数组中随机去一个位置，让其和第一个元素交换并当做基准值，
     这样的话，虽然他还是有可能会退化为n^2级别，但是其概率会很小，所以其期望值会为nlog n 级别
     添加了随机位置之后，会极大地提升快排的效率
     */
    public static func quickSort_Random(arr : inout [Int]) {
        let len = arr.count
        Sort._quickSort_Random(arr: &arr, left: 0, right: len - 1)
    }
    
    fileprivate static func _quickSort_Random(arr : inout [Int], left : Int , right : Int) {
        
        if left >= right {
            return
        }
        //先返回一个p，使得数组前半部分小于v，后半部分大于v
        // p 的位置正好是基准值v的位置
        let p = Sort._partitionArr_Random(arr: &arr, left: left, right: right)
        
        //递归分别对前后两部分进行快速排序
        Sort._quickSort_Random(arr: &arr, left: left, right: p-1)
        Sort._quickSort_Random(arr: &arr, left: p+1,  right: right)
    }
    
    fileprivate static func _partitionArr_Random(arr : inout [Int], left : Int, right : Int) -> Int{
        
        
        //取随机位置为基准值
        let randomIndex = Int(arc4random() % UInt32((right - left + 1)) + UInt32(left))
        
        swapElement(&arr, left, randomIndex)
        
        //返回位置p ,使得a[left ... p-1] < v 和 a[p+1 ... right] > v
        var p = left
        
        //去基准值为数组的第一个元素
        let v = arr[left]
        
        for i in left+1 ... right {
            if arr[i] < v {
                p += 1
                swapElement(&arr, i, p)

            }
        }
        swapElement(&arr, left, p)
        return p
    }
    
    //MARK: -  双路快速排序
    // 当数组中有很多重复值的情况下，上述的normal快速排序会退化为n^2级别
    // 原因是 == v 的元素会被交换到某一端，导致partition之后的二分树极不平衡
    public static func quickSort_2Ways(arr : inout [Int]) {
        let len = arr.count
        Sort._quickSort_2Ways(arr: &arr, left: 0, right: len-1)
    }
    
    fileprivate static func _quickSort_2Ways(arr : inout [Int], left : Int, right : Int) {
        
        if left >= right {
            return
        }
        let p = Sort._partition_2Ways(arr: &arr, left: left, right: right)
        Sort._quickSort_2Ways(arr: &arr, left: left, right: p-1)
        Sort._quickSort_2Ways(arr: &arr, left: p+1, right: right)
    }
    
    fileprivate static func _partition_2Ways(arr : inout [Int], left : Int, right : Int) -> Int {
        
        
        let randomIdx = Int(arc4random() % UInt32(right - left + 1) + UInt32(left))
        swapElement(&arr, randomIdx, left)
    
        let v = arr[left]
        
        //a[left+1, i) <= v ; a(j, right] >= v
        var i = left+1
        var j = right
        
        while true {
            //i的位置最多可以达到right
            while i <= right && arr[i] < v {
                i += 1
            }
            //由于left是基准值的位置，所以这里j最多可以达到left+1的位置
            while j >= left + 1 && arr[j] > v {
                j -= 1
            }
            
            if i > j {
                break
            }
            swapElement(&arr, i, j)
            i += 1
            j -= 1
        }
        
        //出循环则代表着 i > j 
        //此时i是第一个 >=v 的元素的位置， j是最后一个 <=v 的元素的位置
        //所以此时将 arr[left] 和 arr[j] 的元素互换位置然后返回j
        swapElement(&arr, left, j)
        return j
    }
    
    //MARK: -  三路快速排序
    public static func quickSort_3Ways(arr : inout [Int]) {
        let len = arr.count
        Sort._quickSort_3Ways(a: &arr, l: 0, r: len - 1)
    }
    
    fileprivate static func _quickSort_3Ways(a : inout [Int], l : Int, r : Int) {
        
        if l >= r {
            return
        }
        let p = Sort._partition_3Ways(a: &a, l: l, r: r)
        Sort._quickSort_3Ways(a: &a, l: l, r: p.lt-1)
        Sort._quickSort_3Ways(a: &a, l: p.gt, r: r)
    }
    
    fileprivate static func _partition_3Ways(a : inout [Int], l : Int, r : Int) -> (lt : Int , gt : Int) {
        
        let randomIdx = Int(arc4random()%UInt32(r - l + 1) + UInt32(l))
        
        swapElement(&a, randomIdx, l)
        
        let v = a[l]
        var lt = l      //a[l+1  ... lt] < v
        var gt = r + 1  //a[gt   ... r] > v
        var i  = lt     //a[lt+1 ... i) == v
        
        while i < gt {
            if a[i] < v {
                swapElement(&a, lt + 1, i)
                lt += 1
                i += 1
            }
            else if a[i] > v {
                swapElement(&a, gt - 1, i)
                gt -= 1
            }
            else {
                i += 1
            }
        }
        
        swapElement(&a, lt, l)
        
        return  (lt,gt)
    }
    
}
