import Foundation

public class UnionFind_UsingSize : UnionFind_UsingParent {
    
    //size[i] 表示以i 为根的集合中的元素个数
    public var size : [Int] = []
    
    override init() {
        super.init()
        self.unionFindName = "UnionFind_UsingSize"
    }
    
    public convenience init(capacity : Int) {
        self.init()
        for i in 0..<capacity {
            self.idArray.append(i)
            self.parents.append(i)
            //初始状态时，每一个节点的size都为1
            self.size.append(1)
        }
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
        if self.size[pRoot] < self.size[qRoot] {
            self.parents[pRoot] = qRoot
            self.size[qRoot] += size[pRoot]
        } else {
            self.parents[qRoot] = pRoot
            self.size[pRoot] += self.size[qRoot]
        }
    }
}
