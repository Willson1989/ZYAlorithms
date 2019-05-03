import Foundation

public class BasicQueue<T> {
    fileprivate var queueArr : [T]
    public init() {
        queueArr = [T]()
    }
    
    public func front() -> T? {
        if self.isEmpty() == true {
            return nil
        }
        return self.queueArr.first
    }
    
    public func enqueue(_ obj : T?) {
        if obj == nil {
            return
        }
        self.queueArr.append(obj!)
    }
    
    public func dequeue(){
        if self.isEmpty() == true {
            return
        }
        self.queueArr.removeFirst()
    }
    
    public func isEmpty() -> Bool {
        return self.queueArr.count == 0
    }
    
    public func size() -> Int {
        return self.queueArr.count
    }
}

class BasicStack<T> {
    
    fileprivate var data = [T]()
    
    func push(_ x: T) {
        data.append(x)
    }
    
    func pop() {
        if data.isEmpty {
            return
        }
        data.removeLast()
    }
    
    func top() -> T? {
        if data.isEmpty {
            return nil
        }
        return data.last!
    }
    
    func size() -> Int {
        return data.count
    }
    
    func isEmpty() -> Bool {
        return data.count <= 0
    }
}
