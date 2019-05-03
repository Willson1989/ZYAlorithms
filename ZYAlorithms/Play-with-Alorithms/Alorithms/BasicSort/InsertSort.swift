import Foundation

public class Class01 {
    var pid : Int = 0
}

//基础插入排序
public extension Sort{
    public static func insertSort01(arr : inout [Class01]) {
        
        let len = arr.count
        for i in 1 ..< len {
            let tmp = arr[i]
            var j = i
            for k in stride(from: i, to: 0, by: -1) {
                
                if arr[k-1].pid > tmp.pid {
                    arr[k] = arr[k-1]
                    j -= 1
                } else {
                    break
                }
            }
            arr[j] = tmp
        }
    }
    
    public static func insertSort(arr : inout [Int]) {
        
        let len = arr.count
        for i in 1 ..< len {
            let tmp = arr[i]
            var j = i
            for k in stride(from: i, to: 0, by: -1) {
                
                if arr[k-1] > tmp {
                    arr[k] = arr[k-1]
                    j -= 1
                } else {
                    break
                }
            }
            arr[j] = tmp
        }
    }
    
}
