import Foundation

/*
 相邻节点迭代器
 */

extension SparseGraph {
    //相邻节点迭代器
    public class adjIterator : NSObject {
        
        internal var G : SparseGraph!
        internal var V : Int = 0
        internal var currIdx : Int = 0
        
        override init() {
            super.init()
        }
        
        public convenience init(graph : SparseGraph, v : Int) {
            self.init()
            self.G = graph
            self.V = v
        }
        
        public func begin() -> Int {
            currIdx = 0
            if self.G.graph[V].count == 0 {
                return -1
            }
            return G.graph[V][currIdx]
        }
        
        public func next() -> Int {
            currIdx += 1
            if currIdx >= G.graph[V].count {
                return -1
            }
            return G.graph[V][currIdx]
        }
        
        public func isEnd() -> Bool {
            return currIdx >= G.graph[V].count
        }
    }
}


extension DenseGraph_Matrix {
    //相邻节点迭代器
    public class adjIterator : NSObject {
        
        internal var G : DenseGraph_Matrix!
        internal var V : Int = 0
        internal var currIdx : Int = 0
        
        override init() {
            super.init()
        }
        
        public convenience init(graph : DenseGraph_Matrix, v : Int) {
            self.init()
            self.G = graph
            self.V = v
        }
        
        public func begin() -> Int {
            self.currIdx = -1
            return self.next()
        }
        
        public func next() -> Int {
            self.currIdx += 1
            while self.currIdx < self.G.graph[V].count {
                if self.G.graph[V][currIdx] == true {
                    return self.currIdx
                }
                self.currIdx += 1
            }
            return -1
        }
        
        public func isEnd() -> Bool {
            return self.currIdx >= self.G.num_Vertex
        }
        
    }
}
