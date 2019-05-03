import Foundation

public class UnionFind_UsingRank : UnionFind_UsingParent {
    
    //存储元素对应的树的层数，rank[p] 表示以元素p为根的集合的层数
    public var rank : [Int] = []
    
    override init() {
        super.init()
        self.unionFindName = "UnionFind_UsingRank"
    }
    
    public convenience init(capacity : Int) {
        self.init()
        for i in 0..<capacity {
            self.idArray.append(i)
            self.parents.append(i)
            //初始状态时，每一个节点都是根，层数都为1
            self.rank.append(1)
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
        
        if self.rank[pRoot] < self.rank[qRoot] {
            //p的层数小于 q的层数,让p 连接q
            self.parents[pRoot] = qRoot
            
        } else if self.rank[pRoot] > self.rank[qRoot] {
            //q的层数小于 p的层数,让q 连接p
            self.parents[qRoot] = pRoot
            
        } else {
            //层数相同,self.rank[pRoot] == self.rank[qRoot]
            self.parents[qRoot] = pRoot
            self.rank[pRoot] += 1
        }
    }
    
}
