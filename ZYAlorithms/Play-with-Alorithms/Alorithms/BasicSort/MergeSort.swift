import Foundation

public extension Sort {
    
    //MARK: - 归并排序
    static public func mergeSort(arr : inout [Int]){
        
        let len = arr.count
        Sort._mergeSort(arr: &arr, first: 0, last: len - 1)
    }
    
    static fileprivate func _mergeSort(arr : inout [Int], first : Int, last : Int) {
        
        if first < last {
            let mid = (first + last) / 2
            //过程类似于二叉树的后序遍历
            Sort._mergeSort (arr: &arr, first: first, last: mid)
            Sort._mergeSort (arr: &arr, first: mid+1, last: last)
            Sort._mergeArray(&arr, first, mid, last)
        }
    }
    
    static fileprivate func _mergeArray(_ arr : inout [Int],
                                        _ first : Int,
                                        _ mid : Int,
                                        _ last : Int){
        
        var mergedArray : [Int] = []
        
        var i = first
        var j = mid+1
        
        let m = mid
        let n = last
        
        while i <= m && j <= n {
            
            if arr[i] < arr[j] {
                mergedArray.append(arr[i])
                i += 1
            } else {
                mergedArray.append(arr[j])
                j += 1
            }
        }
        
        while i <= m {
            mergedArray.append(arr[i])
            i += 1
        }
        
        while j <= n {
            mergedArray.append(arr[j])
            j += 1
        }
        
        for i in 0 ..< mergedArray.count {
            arr[first + i] = mergedArray[i]
        }
    }
    
}
