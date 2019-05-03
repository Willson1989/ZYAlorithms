import Foundation


public class UnionFind_Simple : UFType {
    
    override init() {
        super.init()
        self.unionFindName = "UnionFind_Simple"
    }
    
    public convenience init(capacity : Int) {
        self.init()
        for i in 0..<capacity {
            self.idArray.append(i)
        }
    }
    
    override public func find(_ p : Int) -> Int {
        if p > self.idArray.count - 1 || p < 0  {
            return UnionFind_NotFound
        }
        return self.idArray[p]
    }
    
    override public func isConnected(_ p : Int, _ q : Int) -> Bool {
        if p >= self.idArray.count || p < 0 ||
           q >= self.idArray.count || q < 0 {
            return false
        }
        let fp = self.find(p)
        let fq = self.find(q)
        if fp == UnionFind_NotFound || fq == UnionFind_NotFound {
            return false
        }
        return fp == fq
    }
    
    override public func union(_ p : Int, _ q : Int) {
        if p >= self.idArray.count || p < 0 ||
           q >= self.idArray.count || q < 0 {
            return
        }
        let pId = find(p)
        let qId = find(q)
        
        if pId == qId {
            return
        }
        for i in 0 ..< self.idArray.count {
            if pId == self.idArray[i] {
                self.idArray[i] = qId
            }
        }
    }
}
