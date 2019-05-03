import Foundation

public func swapElement(_ arr : inout [Int], _ posx : Int, _ posy : Int) {
    if  posx >= arr.count ||
        posy >= arr.count ||
        posx < 0 ||
        posy < 0 ||
        arr.count <= 0 ||
        posx == posy{
        return
    }
    arr.swapAt(posx, posy)
}


public func swapElement_T<T : Comparable & Equatable>(_ arr : inout [T], _ posx : Int, _ posy : Int) {
    if  posx >= arr.count ||
        posy >= arr.count ||
        posx < 0 ||
        posy < 0 ||
        arr.count <= 0 ||
        posx == posy{
        return
    }
    arr.swapAt(posx, posy)
}

public func swapElement_T_Optional<T : Comparable & Equatable>(_ arr : inout [T?], _ posx : Int, _ posy : Int) {
    if  posx >= arr.count ||
        posy >= arr.count ||
        posx < 0 ||
        posy < 0 ||
        arr.count <= 0 ||
        posx == posy{
        return
    }
    arr.swapAt(posx, posy)
}


public struct TestHelper {
    
    public static func randomArray(len : Int, limit : Int) -> [Int] {
        
        var arr : [Int] = []
        for _ in 0 ..< len {
            let max : UInt32 = UInt32(limit)
            let min : UInt32 = 0
            
            let n = arc4random() % (max - min + 1) + min
            
            arr.append(Int(n))
        }
        return arr
    }
    
    public static func randomIndex(ofArray a : Array<Any>) -> Int {
        if a.count == 0 {
            return -1
        }
        return Int(arc4random() % UInt32(a.count))
    }
    
    public static func randomItem(ofArray a : Array<Any>) -> Any {
        let randomIdx = TestHelper.randomIndex(ofArray: a)
        return a[randomIdx]
    }
    
    public static func printArray(_ a : [Int]) {
        
        for i in 0 ..< a.count {
            print(a[i], separator: " ", terminator: " ")
        }
        print()
    }
    
    public static func printArray(_ a : [Int], l : Int, r : Int) {
        if l > r {
            return
        }
        
        for i in l ... r {
            print(a[i], separator: " ", terminator: "")
        }
        print()
    }

    public static func isSorted(array : [Int], ascending : Bool) -> Bool {
        
        if ascending == true {
            //升序
            for i in 1 ..< array.count {
                if array[i-1] > array[i] {
                    return false
                }
            }
            return true
        }else {
            //降序
            for i in 1 ..< array.count {
                if array[i-1] < array[i] {
                    return false
                }
            }
            return true
        }
    }
    
    /**
     生成近乎有序的数组
     */
    public static func nearlyOrderdArray(length : Int , swapTimes : Int) -> [Int]{
        var arr : [Int] = []
        
        for i in 0 ..< length {
            arr.append(i)
        }
        
        for _ in 0 ..< swapTimes {
            
            let posx = Int(arc4random() % UInt32(length))
            let posy = Int(arc4random() % UInt32(length))
            
            arr.swapAt(posx, posy)
        }
        
        return arr
    }
    
    public static func testSort( _ sortName : String ,
                             _ sortFunction : (inout [Int]) -> (),
                                      array : inout [Int]) {
        //算法执行前的时间点
        let startTime : clock_t = clock()
        sortFunction(&array)
        //算法执行完的时间点
        let endTime : clock_t = clock()
        
        if TestHelper.isSorted(array: array, ascending: true) == false {
            print("\(sortName), sort failed")
            return
        }
        
        //计算出时间差然后除以 CLOCKS_PER_SEC 取得以秒为单位的时间
        let timeInterval = Double(endTime - startTime) / Double(CLOCKS_PER_SEC)
        
        //打印Double类型变量时会输出科学计数法，
        //如 1.8e-05,使用C语法exp()来转换成正常的数字输出
        print(" \(sortName), sort time : \(exp(timeInterval)) s")
    }
    
    public static func testSearch(_ searchName : String,
                               _ searchFuntion : ([Int], Int) -> (Int),
                                     targetArr : inout [Int],
                                      findItem : Int) -> Int{
        //算法执行前的时间点
        let startTime : clock_t = clock()
        let index = searchFuntion(targetArr, findItem)
        //算法执行完的时间点
        let endTime : clock_t = clock()
        
        //计算出时间差然后除以 CLOCKS_PER_SEC 取得以秒为单位的时间
        let timeInterval = Double(endTime - startTime) / Double(CLOCKS_PER_SEC)
        
        if index == -1 {
            print("item : \(findItem) not found In array")
            return -1
        }
        //打印Double类型变量时会输出科学计数法，
        //如 1.8e-05,使用C语法exp()来转换成正常的数字输出
        print(" \(searchName), search time : \(exp(timeInterval)) s, itemIndex : \(index)")
        return index
    }
    
}
