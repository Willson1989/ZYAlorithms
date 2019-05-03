import Foundation

/*
 稀疏图
 适合用  邻接表(二维整型数组)  来标识
 */
public class SparseGraph : Graph {
    //（可以将所有的边都添加完之后再处理平行变的问题）？
    
    internal var graph : [[Int]] = []
    
    public override init(capacity : Int , directed : Bool) {
        super.init(capacity: capacity, directed: directed)
        for _ in 0 ..< capacity {
            self.graph.append( [Int]() )
        }
    }
    
    //存在平行边
    /* 由于使用邻接表实现的稀疏图的hasEdge方法的时间复杂度是O(n)级别的
     那么在addEdge中加入处理平行变的处理之后 addEdge 的
     时间复杂度则变成了至少为O(n)级别的，这样会降低效率，
     所以，使用邻接表实现的图的缺点是对平行变的处理效率比较低 */
    public override func addEdge(_ v: Int, _ w: Int) {
        
        if !self.isAvaliable(v) || !self.isAvaliable(w) {
            return
        }
        
        //if self.hasEdge(v, w) == true {
        //    return
        //}
        self.graph[v].append(w)
        if v != w && !self.isDirected {
            self.graph[w].append(v)
        }
        self.num_Edge += 1
    }
    
    
    internal override func dfs(v: Int, iteration: iteratorBlock?) {
        
        self.visited[v] = true
        iteration?(v)
        self.connectIds[v] = self.num_Components
        for i in 0 ..< self.graph[v].count {
            let j = self.graph[v][i]
            if self.visited[j] == false {
                self.dfs(v: j, iteration: iteration)
            }
        }
    }
    
    // O(n)级别
    public override func hasEdge(_ v: Int, _ w: Int) -> Bool {
        assert(self.isAvaliable(v) && self.isAvaliable(w))
        for i in 0 ..< self.graph[v].count {
            if self.graph[v][i] == w {
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
            if self.graph[v][i] == w {
                self.graph[v].remove(at: i)
                self.num_Edge -= 1
                break
            }
        }
        if !self.isDirected {
            for i in 0 ..< self.graph[w].count {
                if self.graph[w][i] == v {
                    self.graph[w].remove(at: i)
                    break
                }
            }
        }
        self.depthFirstSearch(iteration: nil)
    }
    
    public override func iterateGraph(forVertex v: Int, _ iteration: (Int) -> ()) {
        for i in 0 ..< self.graph[v].count {
            iteration(self.graph[v][i])
        }
    }
    
    //打印邻接表
    public override func show() {
        print("稀疏图 邻接表 ： \(self)")
        for i in 0 ..< self.num_Vertex {
            let v = String(format: "%03d", i)
            print("Vertex \(v) : ", separator: "", terminator: "")
            for j in 0 ..< self.graph[i].count {
                print(self.graph[i][j], separator: "", terminator: " ")
            }
            print()
        }
        print()
    }
    
    public class Path : GraphPath {
        
        fileprivate var G : SparseGraph!
        
        public init(graph : SparseGraph, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            
            //寻路算法
            self.dfsFromVertex(self.V)
            print("from array : \(self.from)")
            print("visited array : \(self.visited)")
        }
        
        internal override func dfsFromVertex(_ v: Int) {
            self.visited[v] = true
            for i in 0 ..< self.G.graph[v].count {
                let j = self.G.graph[v][i]
                if self.visited[j] == false {
                    self.from[j] = v
                    self.dfsFromVertex(j)
                }
            }
        }
    }
    
    public class ShortestPath : GraphPath {
        
        fileprivate var G : SparseGraph!
        
        public init(graph : SparseGraph, v : Int) {
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
                    let j = self.G.graph[tmpV][i]
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
