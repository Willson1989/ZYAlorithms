import Foundation

//选择排序
public extension Sort {
    
    public static func selectionSort(arr : inout [Int]) {
        
        if arr.isEmpty == true {
            return
        }
        for i in 0 ..< arr.count {
            var min = arr[i]
            var minIndex = i
            for j in i+1 ..< arr.count {
                
                if arr[j] < min {
                    min = arr[j]
                    minIndex = j
                }
            }
            swapElement(&arr, minIndex, i)
        }
    }
    
}
