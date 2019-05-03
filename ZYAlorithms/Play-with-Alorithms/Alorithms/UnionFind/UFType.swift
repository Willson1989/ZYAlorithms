import Foundation


public let UnionFind_NotFound = -1

public class UFType : NSObject {
    
    public var idArray : [Int] = []
    
    public var unionFindName : String = "UFType"
    
    public override init() {
        super.init()
        self.unionFindName = "UFType"
    }
    
    public convenience init(capacity : Int) {
        self.init()
        for i in 0..<capacity {
            self.idArray.append(i)
        }
    }
    
    public func find(_ p : Int) -> Int {
        return UnionFind_NotFound
    }
    
    public func isConnected(_ p : Int, _ q : Int) -> Bool {
        return false
    }
    
    public func union(_ p : Int, _ q : Int){
        
    }

}
