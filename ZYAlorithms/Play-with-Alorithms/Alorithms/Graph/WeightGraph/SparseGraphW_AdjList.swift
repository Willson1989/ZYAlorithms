import Foundation

//使用链表实现邻接表的 带权图

public class SparseGraphW_AdjList : Graph_Weighted {
    
    fileprivate var graph : [Vertex] = []
    
    public override init(capacity : Int , directed : Bool) {
        super.init(capacity: capacity, directed: directed)
        for i in 0 ..< capacity {
            let v = Vertex(vertex: i)
            self.graph.append(v)
        }
    }
    
    public override func addEdge(_ v: Int, _ w: Int, weight : Float) {
        if !isAvaliable(v) || !isAvaliable(w) {
            return
        }
        if hasEdge(v, w) {
            return
        }
        if v == w { //不添加自环边
            return
        }
        let ew = Edge(a: v, b: w, weight: weight)
        let vexV = graph[v]
        ew.next = vexV.firstArc
        vexV.firstArc = ew
        
        if !isDirected {
            let ev = Edge(a: w, b: v, weight: weight)
            let vexW = graph[w]
            ev.next = vexW.firstArc
            vexW.firstArc = ev
        }
        self.num_Edge += 1
    }
    
    override func dfs(v: Int, iteration: iteratorBlock?) {
        self.visited[v] = true
        iteration?(v)
        self.connectIds[v] = self.num_Components
        var p = graph[v].firstArc
        while p != nil {
            if visited[p!.to] == false {
                self.dfs(v: p!.to, iteration: iteration)
            }
            p = p!.next
        }
    }
    
    public override func hasEdge(_ v: Int, _ w: Int) -> Bool {
        assert(self.isAvaliable(v))
        assert(self.isAvaliable(w))
        var p : Edge? = self.graph[v].firstArc
        while p != nil {
            if p!.to == w {
                return true
            }
            p = p!.next
        }
        return false
    }
    
    public override func deleteEdge(_ v : Int, _ w : Int) {
        if !self.isAvaliable(v) || !self.isAvaliable(w) {
            return
        }
        var pre : Edge? = nil
        var p = self.graph[v].firstArc
        while p != nil {
            if p?.to == w {
                if pre == nil {
                    self.graph[v].firstArc = p?.next
                } else {
                    pre?.next = p?.next
                    p = nil
                }
                self.num_Edge -= 1
                //不处理平行变的问题,所以匹配的时候，直接break
                break
            }
            pre = p
            p = p?.next
        }
        if !self.isDirected {
            pre = nil
            p = self.graph[w].firstArc
            while p != nil {
                if p?.to == v {
                    if pre == nil {
                        self.graph[w].firstArc = p?.next
                    } else {
                        pre?.next = p?.next
                        p = nil
                    }
                    break
                }
                pre = p
                p = p?.next
            }
        }
        self.depthFirstSearch(iteration: nil)
    }
    
    public override func show() {
        print("稀疏图(有权) 邻接表 ： \(self)")
        for i in 0 ..< self.num_Vertex {
            let v = String(format: "%03d", i)
            print("Vertex \(v) : ", separator: "", terminator: "")
            var p = graph[i].firstArc
            while p != nil {
                print(p!.to, separator: "", terminator: " ")
                p = p!.next
            }
            print()
        }
        print()
    }
}

//MARK: - Finding a Path
extension SparseGraphW_AdjList {
    
    public class Path : GraphPath {
        
        fileprivate var G : SparseGraphW_AdjList!
        
        public init(graph : SparseGraphW_AdjList, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            //寻路算法
            self.dfsFromVertex(self.V)
        }
        
        override func dfsFromVertex(_ v: Int) {
            self.visited[v] = true
            var p = self.G.graph[v].firstArc
            while p != nil {
                if visited[p!.to] == false {
                    self.from[p!.to] = v
                    self.dfsFromVertex(p!.to)
                }
                p = p!.next
            }
        }
    }
    
    public class ShortestPath : GraphPath {
        
        fileprivate var G : SparseGraphW_AdjList!
        
        public init(graph : SparseGraphW_AdjList, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            self.initDistanceArray()
            self.bfsFromVertex(self.V)
        }
        
        internal override func bfsFromVertex(_ v: Int) {
            let queue = BasicQueue<Int>()
            queue.enqueue(v)
            self.visited[v] = true
            self.distance[v] = 0
            
            while !queue.isEmpty() {
                
                let tmpV = queue.front()!
                queue.dequeue()
                var p = self.G.graph[tmpV].firstArc
                while p != nil {
                    if self.visited[p!.to] == false {
                        queue.enqueue(p!.to)
                        self.visited[p!.to] = true
                        self.from[p!.to] = tmpV
                        self.distance[p!.to] = self.distance[tmpV] + 1
                    }
                    p = p!.next
                }
            }
        }
    }
}

//MARK: - MST
extension SparseGraphW_AdjList {
    
    public class LazyPrimMST : MST_LazyPrim {
        
        internal var G : SparseGraphW_AdjList!
        
        public init(graph : SparseGraphW_AdjList) {
            super.init(capacity: graph.E())
            self.G = graph
            self.GenericMST_lazyPrim()
        }
        
        
        override func visit(_ v: Int) {
            marked[v] = true
            var e = G.graph[v].firstArc
            while e != nil {
                if marked[e!.other(v)] == false {
                    //pq.insertItem(e!)
                    pq.insert(item: e!)
                }
                e = e!.next
            }
        }
    }
    
    public class PrimMST : MST_Prim {
        
        fileprivate var G : SparseGraphW_AdjList!
        
        public init(graph : SparseGraphW_AdjList) {
            super.init(capacity: graph.V())
            self.G = graph
            // Prim
            self.GenericMST_Prim()
        }
        
        override func visit(_ v: Int) {
            
            marked[v] = true
            var p = G.graph[v].firstArc
            while p != nil {
                let w = p!.other(v)
                if !marked[w] {
                    if edgeTo[w] == nil {
                        edgeTo[w] = p
                        ipq.insert(item: p!.wt(), at: w)
                        
                    } else if p!.wt() < edgeTo[w]!.wt() {
                        ipq.change(with: p!.wt(), atHeapIndex: w)
                        edgeTo[w] = p
                    }
                }
                p = p!.next
            }
        }
    }
    
    public class KruskalMST : MST_Kruskal {
        
        fileprivate var G : SparseGraphW_AdjList!
        
        public init(graph : SparseGraphW_AdjList) {
            super.init(capacity: graph.V())
            self.G = graph
            self.GenericMST_Kruskal()
        }
        
        internal override func GenericMST_Kruskal() {
            
            let pq = SimpleHeap<Edge>(capacity: G.E(), type : HeapType.min)
            let uf = UnionFind_CompressPath_01(capacity: G.V())
            
            for i in 0 ..< G.V() {
                var p = G.graph[i].firstArc
                while p != nil {
                    
                    if p!.V() < p!.W() {
                        pq.insert(item: p!)
                    }
                    p = p!.next
                }
            }
            while pq.isEmpty() == false && self.mstArray.count < G.V() - 1 {
                let e = pq.extract()!
                if uf.isConnected(e.V(), e.W()) {
                    continue
                }
                self.mstArray.append(e)
                uf.union(e.V(), e.W())
            }
            for i in 0 ..< mstArray.count {
                mstTotalWeight += mstArray[i].wt()
            }
        }
    }
}

//MARK: - Dijkstra Shortest Path
extension SparseGraphW_AdjList {
    
    public class DijkstraPath : ShortestPath_Dijkstra {
        
        fileprivate var G : SparseGraphW_AdjList
        
        public init(source : Int , graph : SparseGraphW_AdjList) {
            self.G = graph
            super.init(source: source, capacity: graph.V())
            self.dijkstraPath()
        }
        
        override func dijkstraPath() {
            
            distTo[s] = 0.0
            pq.insert(item: 0.0, at: s)
            marked[s] = true
            
            while !pq.isEmpty() {
                
                let v = pq.extractIndex()
                marked[v] = true
                
                // 遍历v的邻接点
                var e = G.graph[v].firstArc
                while e != nil {
                    let w = e!.other(v)
                    if !marked[w] {
                        if from[w] == nil || distTo[v] + e!.wt() < distTo[w] {
                            distTo[w] = distTo[v] + e!.wt()
                            from[w] = e
                            if !pq.contain(w) {
                                pq.insert(item: distTo[w], at: w)
                            } else {
                                pq.insert(item: distTo[w], at: w)
                            }
                        }
                    }
                    e = e!.next
                }
            }
        }
    }
}




