import Foundation

public class UnionFind_CompressPath_01 : UnionFind_UsingRank {
    
    override init() {
        super.init()
        self.unionFindName = "UnionFind_CompressPath"
    }
    
    public override func find(_ p: Int) -> Int {
        if p >= self.idArray.count || p < 0 {
            return UnionFind_NotFound
        }
        var vp = p
        //路径压缩：如果p的父节点不是自己，那么让p的父节点指向p的祖父节点即parents[parents[p]]
        //这样的话，会降低该节点所处的集合的层数，提高遍历效率
        while vp != self.parents[vp] {
            self.parents[vp] = self.parents[self.parents[vp]]
            vp = self.parents[vp]
        }
        return vp
    }
}
