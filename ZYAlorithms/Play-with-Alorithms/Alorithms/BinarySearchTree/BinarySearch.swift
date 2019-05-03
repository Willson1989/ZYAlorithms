import Foundation

//正常的二分查找
public func BinarySearch_Normal(target a : [Int] , item : Int ) -> Int {
    
    var left = 0
    var right = a.count - 1
    
    while left <= right {
        
        let mid = left + (right - left) / 2
        
        if a[mid] == item {
            return mid
        } else if item < a[mid] {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return -1
}

//递归二分查找
public func BinarySearch_Recursion(target a : [Int] , item : Int ) -> Int {
    
    return _BinarySearh(a, e: item, l: 0, r: a.count - 1)
}

fileprivate func _BinarySearh(_ a : [Int], e : Int, l : Int, r : Int) -> Int{

    let mid = l + (r - l) / 2
    if l > r {
        return -1
    }
    if e == a[mid] {
        return mid
        
    } else if e < a[mid] {
        return _BinarySearh(a, e: e, l: l, r: mid-1)
        
    } else {
        return _BinarySearh(a, e: e, l: mid+1, r: r)
    }
}

