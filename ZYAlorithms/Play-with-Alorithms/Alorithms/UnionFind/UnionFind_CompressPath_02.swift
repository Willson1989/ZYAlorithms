import Foundation

public class UnionFind_CompressPath_02 : UnionFind_UsingRank {
    
    override init() {
        super.init()
        self.unionFindName = "UnionFind_CompressPath"
    }
    
    public override func find(_ p: Int) -> Int {
        if p >= self.idArray.count || p < 0 {
            return UnionFind_NotFound
        }
        
        if p != self.parents[p] {
            self.parents[p] = self.find(self.parents[p])
        }
        return self.parents[p]
    }
    
}
