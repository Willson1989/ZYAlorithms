import Foundation

public class DenseGraphW_Matrix : Graph_Weighted {
    
    internal var graph : [[Edge?]] = []
    
    public override init(capacity : Int , directed : Bool) {
        super.init(capacity: capacity, directed: directed)
        for _ in 0 ..< capacity {
            let tmpArr = Array<Edge?>(repeating: nil, count: capacity)
            self.graph.append(tmpArr)
        }
    }

    public override func addEdge(_ v: Int, _ w: Int, weight : Float) {
        if !isAvaliable(v) || !isAvaliable(w) {
            return
        }
        if hasEdge(v, w) == true {
            //如果v和w之间已经有边了，则不做任何操作
            return
        }
        graph[v][w] = Edge(a: v, b: w, weight: weight)
        if !isDirected {
            //如果是无向图
            graph[w][v] = Edge(a: w, b: v, weight: weight)
        }
        num_Edge += 1
    }
    
    public override func deleteEdge(_ v: Int, _ w: Int) {
        if !self.isAvaliable(v) || !self.isAvaliable(w) {
            return
        }
        if !self.hasEdge(v, w) {
            return
        }
        
        if self.graph[v][w] != nil {
            self.graph[v][w] = nil
            if self.isDirected == false {
                self.graph[w][v] = nil
            }
        }
        self.num_Edge -= 1
        self.depthFirstSearch(iteration: nil)
    }
    
    internal override func dfs(v: Int, iteration: iteratorBlock?) {
        self.visited[v] = true
        iteration?(v)
        self.connectIds[v] = self.num_Components
        for i in 0 ..< self.graph[v].count {
            if self.graph[v][i] != nil && self.visited[i] == false {
                self.dfs(v: i, iteration: iteration)
            }
        }
    }
    
    public override func hasEdge(_ v : Int, _ w : Int) -> Bool{
        assert(self.isAvaliable(v))
        assert(self.isAvaliable(w))
        return self.graph[v][w] != nil
    }
    
    public override func show() {
        
        print("稠密图(有权图) 邻接矩阵 ： \(self)")
        for i in 0 ..< self.num_Vertex {
            let str = String(format: "%03d", i)
            print("Vertex \(str) : ", separator: "", terminator: "")
            for j in 0 ..< self.num_Vertex {
                let content = self.graph[i][j] != nil ? "1" : "0"
                print(content, separator: "", terminator: " ")
            }
            print()
        }
        print()
    }
    
    
}

//MARK: - Finding a Path
extension DenseGraphW_Matrix {
    public class Path : GraphPath {
        
        fileprivate var G : DenseGraphW_Matrix!
        
        public init(graph : DenseGraphW_Matrix, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            self.dfsFromVertex(self.V)
        }
        
        internal override func dfsFromVertex(_ v: Int) {
            self.visited[v] = true
            for i in 0 ..< self.num_Vertex {
                if self.G.graph[v][i] != nil && self.visited[i] == false {
                    self.from[i] = v
                    self.dfsFromVertex(i)
                }
            }
        }
    }
    
    public class ShortestPath : GraphPath {
        
        fileprivate var G : DenseGraphW_Matrix!
        
        public init(graph : DenseGraphW_Matrix, v : Int) {
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
                for i in 0 ..< self.num_Vertex {
                    if self.G.graph[tmpV][i] != nil && self.visited[i] == false {
                        queue.enqueue(i)
                        self.visited[i] = true
                        self.from[i] = tmpV
                        self.distance[i] = self.distance[tmpV] + 1
                    }
                }
            }
        }
    }
}

//MARK: - MST
extension DenseGraphW_Matrix {
    
    public class LazyPrimMST : MST_LazyPrim {
        
        fileprivate var G : DenseGraphW_Matrix!
        
        public init(graph : DenseGraphW_Matrix) {
            super.init(capacity: graph.E())
            self.G = graph
            
            //Lazy Prim
            self.GenericMST_lazyPrim()
        }
        
        internal override func visit(_ v: Int) {
            assert(v < self.G.V())
            //当前访问的节点变成红色了
            self.marked[v] = true
            for i in 0 ..< G.V() {
                if let e = G.graph[v][i] {
                    if marked[e.other(v)] == false {
                        //另一个节点是蓝色，说明e是横切边，将e添加到最小堆中
                        pq.insert(item: e)
                    }
                }
            }
        }
    }
    
    public class PrimMST : MST_Prim {
        
        fileprivate var G : DenseGraphW_Matrix!
        
        public init(graph : DenseGraphW_Matrix) {
            super.init(capacity: graph.V())
            self.G = graph
            // Prim
            self.GenericMST_Prim()
        }
        
        override func visit(_ v: Int) {
            
            marked[v] = true
            for i in 0 ..< G.V() {
                if let e = G.graph[v][i] {
                    let w = e.other(v)
                    if marked[w] == false { //是横切边
                        // 总是取和w相连的权值最小的边，然后将其权值存储进最小堆中
                        if edgeTo[w] == nil {
                            // 没存储过和w顶点相连接的横切边
                            ipq.insert(item: e.wt(), at: w)
                            edgeTo[w] = e
                            
                        } else if e.wt() < edgeTo[w]!.wt() {
                            // 如果edgeTo中存储过和w相连的横切边，那么比较权值大小，存入权值小的边
                            ipq.change(with: e.wt(), atDataIndex: w)
                            edgeTo[w] = e
                        }
                    }
                }
            }
        }
    }
    
    public class KruskalMST : MST_Kruskal {
        
        fileprivate var G : DenseGraphW_Matrix!
        
        public init(graph : DenseGraphW_Matrix) {
            
            super.init(capacity: graph.V())
            self.G = graph
            self.GenericMST_Kruskal()
        }
        
        override func GenericMST_Kruskal() {
            //使用最小堆来对图中的所有边进行排序
            let minHeap = SimpleHeap<Edge>(capacity: G.E(), type: HeapType.min)
            let unionFind = UnionFind_UsingRank(capacity: G.V())
            
            //对每一个节点的邻接边进行遍历
            for i in 0 ..< G.V() {
                for j in 0 ..< G.graph[i].count {
                    if let e = G.graph[i][j] {
                        if e.V() < e.W() {
                            minHeap.insert(item: e)
                        }
                    }
                }
            }
            // 堆不为空 而且 最小生成树的边个数小于节点个数减一
            // 有n个节点，那么最小生成树的边数目最多为 n-1
            // 所以这里可以提前结束循环
            while (minHeap.isEmpty() == false && self.mstArray.count < G.V() - 1) {
                
                let minE = minHeap.extract()!
                
                if unionFind.isConnected(minE.V(), minE.W()) {
                    //如果取出的最小权边的两个顶点相连接（或者说有相同的根节点）则构成了环路
                    //因为最小生成树不可以有环路，所以这样的边不使用
                    continue
                }
                mstArray.append(minE)
                
                //该边符合条件，纳入最小生成树中，同时在并查集中让这边的两个顶点相连接
                unionFind.union(minE.V(), minE.W())
            }
            // 计算总权值
            for i in 0 ..< mstArray.count {
                mstTotalWeight += mstArray[i].wt()
            }
        }
        
    }
}

//MARK: - Dijkstra Shortest Path
extension DenseGraphW_Matrix {
    
    public class DijkstraPath : ShortestPath_Dijkstra {
        
        fileprivate var G : DenseGraphW_Matrix
        
        public init(source : Int , graph : DenseGraphW_Matrix) {
            self.G = graph
            super.init(source: source, capacity: graph.V())
            // Dijkstra
            self.dijkstraPath()
        }
        
        internal override func dijkstraPath() {
            
            distTo[s] = 0.0
            pq.insert(item: 0.0, at: s)
            marked[s] = true
            while !pq.isEmpty() {
                //获取最短路径的顶点
                let v = pq.extractIndex()
                marked[v] = true
    
                //遍历顶点v的邻接点
                for i in 0 ..< G.V() {
                    if let e = G.graph[v][i] {
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
    
    
}



