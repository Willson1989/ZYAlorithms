import Foundation

public class UnionFind_UsingParent : UnionFind_Simple {
    
    public var parents : [Int] = []
    
    override init() {
        super.init()
        self.unionFindName = "UnionFind_UsingParent"
    }
    
    public convenience init(capacity : Int) {
        self.init()
        for i in 0..<capacity {
            self.idArray.append(i)
            self.parents.append(i)
        }
    }
    
    //找到元素的根节点
    public override func find(_ p: Int) -> Int {
        var vp = p
        if vp > self.idArray.count - 1 || vp < 0  {
            return UnionFind_NotFound
        }
        while vp != parents[vp] {
            //如果vp的parent节点不是自己，那么说明p不是根节点，那么向上继续查找
            vp = parents[vp]
        }
        return vp
    }
    
    public override func union(_ p: Int, _ q: Int) {
        if p >= self.idArray.count || p < 0 ||
           q >= self.idArray.count || q < 0 {
            return
        }
        let pRoot = self.find(p)
        let qRoot = self.find(q)
        
        if pRoot == qRoot {
            return
        }
        parents[pRoot] = qRoot
    }
    
    
}
