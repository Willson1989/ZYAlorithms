import Foundation


public extension Sort {
    
    public static func heapSort_01(arr : inout [Int]) {
        let mh = SimpleHeap<Int>(capacity: arr.count, type: HeapType.max)
        //将元素先插入堆中，然后对这个元素进行shiftUp形成最大堆
        for i in 0 ..< arr.count {
            mh.insert(item: arr[i])
        }
        //然后依次从最大堆中取出根节点（最大元素）逆序复制到数组中，完成排序
        for i in stride(from: arr.count-1, through : 0, by: -1) {
            arr[i] = mh.extract()!
        }
    }
    
    public static func heapSort_02(arr : inout [Int]) {
        
        //使用heapfiy的方法通过数组直接构建最大堆
        let mh = SimpleHeap<Int>(arr: arr, type: HeapType.max)
        //然后依次从最大堆中取出根节点（最大元素）逆序复制到数组中，完成排序
        for i in stride(from: arr.count-1, through : 0, by: -1) {
            arr[i] = mh.extract()!
        }
    }
    
    public static func heapSort_03(arr : inout [Int]) {
        
        //原地堆排序
        let n = arr.count - 1
        for i in stride(from: (n - 1) / 2, through: 0, by: -1) {
            //MaxHeap.shiftDown(arr: &arr, index: i, len : arr.count)
            CommonHeap.fixDown(arr: &arr, index: i, len: arr.count, type: .max)
        }
        for i in stride(from: n, through: 0, by: -1) {
            swapElement_T(&arr, i, 0)
            //MaxHeap.shiftDown(arr: &arr, index: 0, len : i)
            CommonHeap.fixDown(arr: &arr, index: 0, len: i, type: .max)
        }
    }
    

    
}
