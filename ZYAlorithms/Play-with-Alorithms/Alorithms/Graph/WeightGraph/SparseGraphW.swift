import Foundation


public class SparseGraphW : Graph_Weighted {
    
    public var graph : [[Edge?]] = []
    
    public override init(capacity : Int , directed : Bool) {
        super.init(capacity: capacity, directed: directed)
        for _ in 0 ..< capacity {
            self.graph.append( [Edge?]() )
        }
    }
    
    public override func addEdge(_ v: Int, _ w: Int, weight: Float) {
        if !self.isAvaliable(v) || !self.isAvaliable(w) {
            return
        }
        //if self.hasEdge(v, w) == true {
        //    return
        //}
        let ew = Edge(a: v, b: w, weight: weight)
        self.graph[v].append(ew)
        if v != w && !self.isDirected {
            let ev = Edge(a: w, b: v, weight: weight)
            self.graph[w].append(ev)
        }
        self.num_Edge += 1
    }
    
    override func dfs(v: Int, iteration: iteratorBlock?) {
        self.visited[v] = true
        iteration?(v)
        self.connectIds[v] = self.num_Components
        for i in 0 ..< self.graph[v].count {
            let e = self.graph[v][i]
            if self.visited[e!.to] == false {
                self.dfs(v: e!.to, iteration: iteration)
            }
        }
    }
    
    // O(n)级别
    public override func hasEdge(_ v: Int, _ w: Int) -> Bool {
        assert(self.isAvaliable(v) && self.isAvaliable(w))
        for i in 0 ..< self.graph[v].count {
            if self.graph[v][i]!.to != w {
                return true
            }
        }
        return false
    }
    
    public override func deleteEdge(_ v : Int, _ w : Int) {
        if !self.isAvaliable(v) || !self.isAvaliable(w) {
            return
        }
        for i in 0 ..< self.graph[v].count {
            if self.graph[v][i]!.to == w {
                self.graph[v].remove(at: i)
                self.num_Edge -= 1
                break
            }
        }
        if !self.isDirected {
            for i in 0 ..< self.graph[w].count {
                if self.graph[w][i]!.to == v {
                    self.graph[w].remove(at: i)
                    break
                }
            }
        }
        self.depthFirstSearch(iteration: nil)
    }
    
    //打印邻接表
    public override func show() {
        print("稀疏图 邻接表 ： \(self)")
        for i in 0 ..< self.num_Vertex {
            let v = String(format: "%03d", i)
            print("Vertex \(v) : ", separator: "", terminator: "")
            for j in 0 ..< self.graph[i].count {
                print(self.graph[i][j]!.to, separator: "", terminator: " ")
            }
            print()
        }
        print()
    }
}

//MARK: - Finding a Path
extension SparseGraphW {
    public class Path : GraphPath {
        
        fileprivate var G : SparseGraphW!
        
        public init(graph : SparseGraphW, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            //寻路算法
            self.dfsFromVertex(self.V)
        }
        
        internal override func dfsFromVertex(_ v: Int) {
            self.visited[v] = true
            for i in 0 ..< self.G.graph[v].count {
                let j = self.G.graph[v][i]!.to
                if self.visited[j] == false {
                    self.from[j] = v
                    self.dfsFromVertex(j)
                }
            }
        }
    }
    
    public class ShortestPath : GraphPath {
        
        fileprivate var G : SparseGraphW!
        
        public init(graph : SparseGraphW, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            self.initDistanceArray()
            self.bfsFromVertex(self.V)
        }
        
        internal override func bfsFromVertex(_ v: Int) {
            let queue = BasicQueue<Int>()
            queue.enqueue(v)
            self.distance[v] = 0
            self.visited[v] = true
            while !queue.isEmpty() {
                let tmpV = queue.front()!
                queue.dequeue()
                for i in 0 ..< self.G.graph[tmpV].count {
                    let j = self.G.graph[tmpV][i]!.to
                    if self.visited[j] == false {
                        queue.enqueue(j)
                        self.visited[j] = true
                        self.from[j] = tmpV
                        self.distance[j] = self.distance[tmpV] + 1
                    }
                }
            }
        }
    }
}

//MARK: - MST
extension SparseGraphW {
    public class LazyPrimMST : MST_LazyPrim {
        
        fileprivate var G : SparseGraphW!
        
        public init(graph : SparseGraphW) {
            super.init(capacity: graph.E())
            self.G = graph
            //Lazy Prim
            self.GenericMST_lazyPrim()
        }
        override func visit(_ v: Int) {
            marked[v] = true
            for i in 0 ..< G.graph[v].count {
                let e = G.graph[v][i]!
                if marked[e.other(v)] == false {
                    //是横切边
                    pq.insert(item: e)
                }
            }
        }
    }
    
    public class PrimMST : MST_Prim {
        
        fileprivate var G : SparseGraphW!
        
        public init(graph : SparseGraphW) {
            super.init(capacity: graph.V())
            self.G = graph
            // Prim
            self.GenericMST_Prim()
        }
        
        override func visit(_ v: Int) {
            
            marked[v] = true
            for i in 0 ..< G.graph[v].count {
                let e = G.graph[v][i]!
                let w = e.other(v)
                if !marked[w] {
                    if edgeTo[w] == nil {
                        edgeTo[w] = e
                        ipq.insert(item: e.wt(), at: w)
                    } else if e.wt() < edgeTo[w]!.wt() {
                        ipq.change(with: e.wt(), atHeapIndex: w)
                        edgeTo[w] = e
                    }
                }
            }
        }
    }
    
    public class KruskalMST : MST_Kruskal {
        
        fileprivate var G : SparseGraphW!
        
        public init(graph : SparseGraphW) {
            super.init(capacity: graph.V())
            self.G = graph
            self.GenericMST_Kruskal()
        }
        
        internal override func GenericMST_Kruskal() {
            let pq = SimpleHeap<Edge>(capacity: G.E(), type : HeapType.min)
            let uf = UnionFind_UsingSize(capacity: G.V())
            for i in 0 ..< G.V() {
                for j in 0 ..< G.graph[i].count {
                    let e = G.graph[i][j]!
                    if e.V() < e.W() {
                        pq.insert(item: e)
                    }
                }
            }
            while !pq.isEmpty() && mstArray.count < G.V() - 1 {
                let e = pq.extract()!
                if uf.isConnected(e.V(), e.W()) {
                    continue
                }
                mstArray.append(e)
                uf.union(e.V(), e.W())
            }
            for i in 0 ..< mstArray.count {
                mstTotalWeight += mstArray[i].wt()
            }
        }
    }
}

//MARK: - Dijkstra Shortest Path
extension SparseGraphW {
    
    public class DijkstraPath : ShortestPath_Dijkstra {
        
        fileprivate var G : SparseGraphW!
        
        public init(source : Int , graph : SparseGraphW) {
            super.init(source: source, capacity: graph.V())
            self.G = graph
            self.dijkstraPath()
        }
        
        internal override func dijkstraPath() {
            
            distTo[s] = 0.0
            marked[s] = true
            pq.insert(item: 0.0, at: s)
            
            while !pq.isEmpty() {
                
                let v = pq.extractIndex()
                marked[v] = true
                
                for i in 0 ..< G.graph[v].count {
                    let e = G.graph[v][i]!
                    let w = e.other(v)
                    
                    if !marked[w] {
                        if from[w] == nil || distTo[v] + e.wt() < distTo[w] {
                            distTo[w] = distTo[v] + e.wt()
                            from[w] = e
                            if !pq.contain(w) {
                                pq.insert(item: distTo[w], at: w)
                            } else {
                                pq.change(with: distTo[w], atDataIndex: w)
                            }
                        }
                    }
                }
            }
        }
    }
}











