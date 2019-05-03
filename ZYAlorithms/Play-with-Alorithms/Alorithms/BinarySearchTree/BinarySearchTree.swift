import Foundation

/*
 参考 ：
 1. http://blog.csdn.net/quzhongxin/article/details/45038399
 2. http://www.importnew.com/24059.html
 (注意！)2里面的select方法是有问题的，正确写法如下：
  public Node select(Node x, int k) {
      if(x == null) {
          return null;
      } else {
          int t = size(x.left);
          if(t > k) {
              return select(x.left, k);
          } else if(t < k) {
              return select(x.right, k - t - 1);  //这句在原文里面有问题
          } else {
              return x;
          }
      }
  }
*/

public class Node<NodeKeyType : Comparable & Equatable> : NSObject {
    
    var key   : NodeKeyType!
    var value : Any!
    var left  : Node<NodeKeyType>?
    var right : Node<NodeKeyType>?
    //以该节点为根的树的节点总数（包含自身）
    var size  : Int = 0
    
    override init() {
        super.init()
    }
    
    convenience init(key : NodeKeyType, value : Any) {
        self.init()
        self.key = key
        self.value = value
        self.left = nil
        self.right = nil
        self.size = 1
    }
    
    convenience init(key : NodeKeyType, value : Any, size : Int) {
        self.init()
        self.key = key
        self.value = value
        self.left = nil
        self.right = nil
        self.size = size
    }
    
    convenience init(node : Node<NodeKeyType>) {
        self.init()
        self.key = node.key
        self.value = node.value
        self.left = node.left
        self.right = node.right
        self.size = node.size
    }
    

}

public typealias TreeEnumaratorBlock<T : Comparable & Equatable> = ( _ key : T? , _ value : Any?) -> Void


public struct BinarySearchTree<KeyType : Comparable & Equatable> {
        
    //二分搜索树的根节点
    public var root : Node<KeyType>?
    
    public init() {
        self.root = nil
    }
    
    //MARK: - Public
    //=======================================
    public func size() -> Int {
        if root == nil {
            return 0
        }
        return root!.size
    }
    
    public func treeSize() -> Int {
        if root == nil {
            return 0
        }
        return root!.size
    }
    
    //返回以node为根的树的节点总数
    public func size(node : Node<KeyType>?) -> Int{
        if node == nil {
            return 0
        }
        return node!.size
    }
    
    public func size(nodeKey : KeyType?) -> Int {
        if nodeKey == nil {
            return 0
        }
        if self.searchNode(key: nodeKey!) == nil {
            return 0
        }
        let node = self.searchNode(key: nodeKey!)!
        return node.size
    }
    
    public func isEmpty() -> Bool {
        return self.treeSize() == 0
    }
    
    public func contain(key : KeyType) -> Bool{
        return _contain(node: root, key: key)
    }
    
    public func search(key : KeyType) -> Any? {
        return _search(node: root, key: key)
    }
    
    public func searchNode(key : KeyType) -> Node<KeyType>? {
        return _searchNode(node: root, key: key)
    }
    
    public mutating func insert(key : KeyType, value : Any) {
        root = _insertNode(node: root, key: key, value: value)
    }
    
    //    public mutating func insert_While(key : KeyType, value : Any) {
    //        _insertNode_While(key: key, value: value)
    //    }
    
    //深度优先遍历
    public func perOrderTree(enumarator : TreeEnumaratorBlock<KeyType>) {
        _perOrder(node: root, enumaratorBlock: enumarator)
    }
    
    public func inOrderTree(enumarator : TreeEnumaratorBlock<KeyType>) {
        _inOrder(node: root, enumaratorBlock: enumarator)
    }
    
    public func postOrderTree(enumarator : TreeEnumaratorBlock<KeyType>) {
        _postOrder(node: root, enumaratorBlock: enumarator)
    }
    
    public mutating func reverseTree() {
        self.root = self._reverse(root: self.root)
    }
    
    //广度优先遍历
    public func levelOrder(enumarator : TreeEnumaratorBlock<KeyType>) {
        if self.isEmpty() == true {
            return
        }
        _levelOrder(enumarator)
    }
    
    public func getMaxNode() -> Any? {
        if self.isEmpty() == true {
            return nil
        }
        let node = _maxKeyNode(node: root!)
        return node.value
    }
    
    public func getMinNode() -> Any? {
        if self.isEmpty() == true {
            return nil
        }
        let node = _minKeyNode(node: root!)
        return node.value
    }
    
    public func maxNodeKey() -> KeyType? {
        if isEmpty() == true {
            return nil
        }
        let node = _maxKeyNode(node: root!)
        return node.key
    }
    
    public func minNodeKey() -> KeyType? {
        if isEmpty() == true {
            return nil
        }
        let node = _minKeyNode(node: root!)
        return node.key
    }
    
    public mutating func deleteMaxNode() {
        var tmp = self.root
        self.root = _deleteMaxKeyNode(node: &tmp)
        //self.root = _deleteMaxKeyNode(node: &self.root)
    }
    
    public mutating func deleteMinNode() {
        var tmp = self.root
        root = _deleteMinKeyNode(node: &tmp)
        //root = _deleteMinKeyNode(node: &root)
    }
    
    public mutating func deleteNode(key : KeyType) {
        var tmp = self.root
        root = _deleteNode(node: &tmp, key: key)
        //root = _deleteNode(node: &root, key: key)
    }
    
    public func select(rank : Int) -> KeyType? {
        //外部使用时，rank从1开始，1的位置为最小值
        if rank <= 0 || rank > self.treeSize() {
            return nil
        }
        let node = _select(node: root, rank: rank - 1)
        return node?.key
    }
    
    public func rank(withKey key : KeyType) -> Int {
        //外部对使用者来说排名是从1开始的而不是0
        return _rank(node: root, key: key) + 1
    }
    
    public func floor(key : KeyType) -> KeyType? {
        
        if self.isEmpty() == true {
            return nil
        }
        
        if self.isEmpty() == false && key < self.minNodeKey()! {
            return nil
        }
        let node = _floor(node: root, key: key)
        return node?.key
    }
    
    public func ceil(key : KeyType) -> KeyType?{
        
        if self.isEmpty() == true {
            return nil
        }
        
        let node = _ceil(node: root, key: key)
        return node?.key
    }
    
    //MARK: - Private
    //=======================================
    
    /**
     二分搜索树的插入 - 递归实现
     node为二分搜索树（或者子树）的根节点，
     二分搜索树的每个节点的字节点下面的子树都是一个二分搜索树。
     */
    fileprivate mutating func _insertNode(node : Node<KeyType>?, key : KeyType, value : Any) -> Node<KeyType> {
        
        if node == nil {
            return Node(key: key, value: value, size: 1)
        }
        
        if node!.key == key {
            node!.value = value
        } else if node!.key > key {
            node!.left  = _insertNode(node: node!.left,  key: key, value: value)
        } else {
            node!.right = _insertNode(node: node!.right, key: key, value: value)
        }
        node!.size = size(node: node!.left) + size(node: node!.right) + 1
        return node!
    }
    
    /**
     二分搜索树的插入 - 非递归实现
     */
    //    fileprivate mutating func _insertNode_While(key : KeyType, value : Any) {
    //
    //        //p 代表当前搜索树（或这其子树）的左节点或者右节点，初值为root
    //        var p = root
    //
    //        // tmpRoot代表p 的父节点，初值为root
    //        var tmpRoot = root
    //
    //        while p != nil {
    //            if key == p!.key {
    //                //如果key匹配，则给value复制，然后直接结束
    //                p!.value = value
    //                return
    //            }
    //
    //            //暂存根节点
    //            tmpRoot = p
    //            if key < p!.key {
    //                p = p!.left
    //            } else {
    //                p = p!.right
    //            }
    //        }
    //
    //        //出while循环，代表没有找到key值对应的节点，同时p的位置就是插入的位置
    //        if tmpRoot == nil {
    //            //只有整棵树的根节点为空的时候才会走这个分支
    //            root = Node(key: key, value: value)
    //        } else if key < tmpRoot!.key {
    //            tmpRoot!.left = Node(key: key, value: value)
    //        } else {
    //            tmpRoot!.right = Node(key: key, value: value)
    //        }
    //        count += 1
    //    }
    
    /**
     是否包含键值为key的节点，返回bool值
     */
    fileprivate func _contain(node : Node<KeyType>? , key : KeyType) -> Bool {
        
        if node == nil {
            return false
        }
        
        if key == node!.key {
            return true
        } else if key < node!.key {
            return _contain(node: node!.left, key: key)
        } else {
            return _contain(node: node!.right, key: key)
        }
    }
    
    /**
     搜索键值为key的节点，并返回对应的value值
     */
    fileprivate func _search(node : Node<KeyType>? , key : KeyType) -> Any? {
        
        if node == nil {
            return nil
        }
        if key == node!.key {
            return node!.value
        } else if key < node!.key {
            return _search(node: node!.left, key: key)
        } else {
            return _search(node: node!.right, key: key)
        }
    }
    
    /**
     搜索键值为key的节点，并返回对应的节点
     */
    fileprivate func _searchNode(node : Node<KeyType>?, key : KeyType) -> Node<KeyType>? {
        
        if node == nil {
            return nil
        }
        if key == node!.key {
            return node!
        } else if key < node!.key {
            return _searchNode(node: node!.left, key: key)
        } else {
            return _searchNode(node: node!.right, key: key)
        }
    }
    
    /*
     二分搜索树的深度优先遍历 （访问当前节点的顺序）
     1.前序遍历 ： 当前节点 -> 递归访问左右子树
     2.中序遍历 ： 递归访问左子树 -> 访问自身节点 -> 递归访问右子树
     3.后序遍历 ： 递归访问左右子树 -> 访问自身节点
     */
    //前序遍历
    fileprivate func _perOrder(node : Node<KeyType>?, enumaratorBlock : TreeEnumaratorBlock<KeyType>) {
        if node != nil {
            enumaratorBlock(node!.key, node!.value)
            _perOrder(node: node!.left, enumaratorBlock: enumaratorBlock)
            _perOrder(node: node!.right, enumaratorBlock: enumaratorBlock)
        }
    }
    
    //中序遍历
    //终须遍历的结果是一个有小到大的有序数列
    fileprivate func _inOrder(node : Node<KeyType>?, enumaratorBlock : TreeEnumaratorBlock<KeyType>) {
        if node != nil {
            _inOrder(node: node!.left, enumaratorBlock: enumaratorBlock)
            enumaratorBlock(node!.key, node!.value)
            _inOrder(node: node!.right, enumaratorBlock: enumaratorBlock)
        }
    }
    
    //后序遍历
    //后序遍历通常用来释放（析构）搜索树，先释放节点的左子树再释放其右子树之后才能放心地释放该节点
    fileprivate func _postOrder(node : Node<KeyType>?, enumaratorBlock : TreeEnumaratorBlock<KeyType>) {
        if node != nil {
            _postOrder(node: node!.left, enumaratorBlock: enumaratorBlock)
            _postOrder(node: node!.right, enumaratorBlock: enumaratorBlock)
            enumaratorBlock(node!.key, node!.value)
        }
    }
    
    /**
     二分搜索树的广度优先遍历
     层序遍历
     */
    fileprivate func _levelOrder(_ enumarator : TreeEnumaratorBlock<KeyType>) {
        
        //创建队列
        let queue = BasicQueue<Node<KeyType>>()
        
        //先将根节点入队
        queue.enqueue(root)
        
        //如果队列不为空，就代表遍历还没有完成
        while !queue.isEmpty() {
            
            //取出队首元素
            let node = queue.front()!
            //移除队中该元素
            queue.dequeue()
            
            //遍历到了该节点
            enumarator(node.key, node.value)
            
            //如果该节点的左右节点不为空，则将左右节点入队列
            if node.left != nil {
                queue.enqueue(node.left!)
            }
            if node.right != nil {
                queue.enqueue(node.right!)
            }
        }
    }
    
    /**
     取得二分搜索树中的最小key
     */
    fileprivate func _minKeyNode(node : Node<KeyType>) -> Node<KeyType> {
        if node.left != nil {
            return _minKeyNode(node: node.left!)
        }
        return node
    }
    
    /**
     取得二分搜索树中的最大key
     */
    fileprivate func _maxKeyNode(node : Node<KeyType>) -> Node<KeyType> {
        if node.right != nil {
            return _maxKeyNode(node: node.right!)
        }
        return node
    }
    
    /**
     删除以node为根节点的搜索树中 Key值最小的节点
     返回删除之后的二叉搜索树的根节点。
     */
    fileprivate mutating func _deleteMinKeyNode(node : inout Node<KeyType>?) -> Node<KeyType>?{
        
        if node == nil {
            return nil
        }
        if node!.left == nil {
            let rightNode = node!.right
            _destroyNode(&node)
            return rightNode
        }
        node!.left = _deleteMinKeyNode(node: &node!.left)
        node!.size = size(node: node?.left) + size(node: node?.right) + 1
        return node
    }
    
    
    /**
     删除以node为根节点的搜索树中 Key值最大的节点
     */
    fileprivate mutating func _deleteMaxKeyNode(node : inout Node<KeyType>?) -> Node<KeyType>? {
        
        if node == nil {
            return nil
        }
        if node!.right == nil {
            let leftNode = node!.left
            _destroyNode(&node)
            return leftNode
        }
        node!.right = _deleteMaxKeyNode(node: &node!.right)
        node?.size = size(node: node?.left) + size(node: node?.right) + 1
        return node
    }
    
    /**
     删除指定key值的节点
     */
    fileprivate mutating func _deleteNode(node : inout Node<KeyType>?,  key : KeyType) -> Node<KeyType>? {
        if node == nil {
            print("节点 - \(key)不存在，删除失败")
            return nil
        }
        
        if key < node!.key! {
            node!.left = _deleteNode(node: &node!.left, key: key)
            node!.size = size(node: node!.left) + size(node: node!.right) + 1
            return node
            
        } else if key > node!.key! {
            node!.right = _deleteNode(node: &node!.right, key: key)
            node!.size = size(node: node!.left) + size(node: node!.right) + 1
            return node
            
        } else { // key == node!.key!
            
            if node!.left == nil {
                let rightNode = node!.right
                _destroyNode(&node)
                return rightNode
            }
            
            if node!.right == nil {
                let leftNode = node!.left
                _destroyNode(&node)
                return leftNode
            }
            //取右边子树中的最小值节点当做新节点
            let newNode = Node(node: _minKeyNode(node: node!.right!))
            // 从右边
            newNode.right = _deleteMinKeyNode(node: &node!.right)
            newNode.left = node!.left
            _destroyNode(&node)
            newNode.size = size(node: newNode.left) + size(node: newNode.right) + 1
            return newNode
        }
    }
   

    
    //返回以node为根节点的树中，//从小到大，排名为rank的节点
    fileprivate func _select(node : Node<KeyType>?, rank : Int) -> Node<KeyType>? {
        //内部使用时，rank是从0开始的，0的位置为最小值
        if node == nil {
            return nil
        }
        let lSize = size(node: node?.left)
        if rank < lSize {
            //要找的节点一定是node的左子树中第 rank 小的节点
            return _select(node: node?.left, rank: rank)
            
        } else if rank > lSize {
            //要找的节点一定是node的右子树中第 rank-lSize-1 小的节点（额外减去1 是除去了node这个根节点）
            return _select(node: node?.right, rank: rank - lSize - 1)
            
        } else {
            //如果rank正好等于lSize，那么node就是所要找的节点，直接返回node
            return node
        }
    }
    
    //返回以node为根节点的树中，值为key的节点node在这棵树中的排名rank（node在树中是第rank小的节点）
    //排名rank在内部使用时是从0开始的
    fileprivate func _rank(node : Node<KeyType>?, key : KeyType) -> Int {
        if node == nil {
            return 0
        }
        if key < node!.key {
            //如果key值小于当前根节点的key值，递归node的左子树
            return _rank(node: node?.left, key: key)
            
        } else if key > node!.key {
            //如果key值大于node的值，则至少要加上node的左子树节点的数量和node本身（1）
            //然后递归走左子树
            return 1 + size(node: node?.left) + _rank(node: node?.right, key: key)
            
        } else { //key == node.key
            //如果key值和node的值相等了，则需要再加上node的左子树的数量
            return size(node: node?.left)
        }
    }
    
    /**
     向下取整，取得树种小于key的key值中最大的值 floorKey。
     node为需要查找的树的根节点。
     如果key == node.key,那么 floorKey 为 key 本身
     如果key < node.key,那么 floorKey 一定在node的左子树中，
     如果key > node.key,那么如果node的右子树中还有比key小的值n(n > node.key)，
     那么这个n 是比 node.key 还接近key的值，此时返回这个n
     如果node的右子树中没有比key小的值，那么floorKey就是node节点的key本身（即node.key）
     */
    fileprivate func _floor(node : Node<KeyType>?, key : KeyType) -> Node<KeyType>? {
        
        //如果查找到的节点为空，则返回nil
        if node == nil {
            return nil
        }
        if key == node!.key! {
            //如果key和node.key相等，则返回node本身
            return node
        }
        else if key < node!.key! {
            //如果key 小于 node.key，那么floorKey应该在该节点的左子树中
            return _floor(node: node!.left, key: key)
        }
        else {
            //key > node!.key!
            //向右子树中查找看看，是否还有比key小的节点
            let resNode = _floor(node: node!.right, key: key)
            
            if resNode != nil {
                //如果有，那么返回这个节点
                return resNode
            } else {
                //如果没有，则返回该节点本身
                return node
            }
        }
    }
   
    /*
     返回以node为根节点的字数中大于key值中的最小的那个键值(ceilKey)的node。
     有以下两种情况：
     1. 如果 key == node.key, 那说明ceilKey就是node.key
     2. 如果 key > node.key,说明比ceilKey一定在node的右子树中。
     3. 如果 key < node.key,那么应该去左子树中查找，如果存在着某一个节点tmpNode并且tmpNode.key < node.key,
        那么说明这个tmpNode.key是比node.key还接近key的值，那么这个tmpNode就是我们要的结果。
     */
    fileprivate func _ceil(node : Node<KeyType>?, key : KeyType) -> Node<KeyType>? {
        
        if node == nil {
            return nil
        }
        if key == node!.key {
            return node
            
        } else if key > node!.key {
            return _ceil(node: node?.right, key: key)
            
        } else {
            let tmpNode = _ceil(node: node?.left, key: key)
            if tmpNode != nil {
                return tmpNode
                
            } else {
                return node
            }
        }
    }
    
    fileprivate func _reverse(root : Node<KeyType>?) -> Node<KeyType>? {
        if root == nil { return nil }
        if !(root?.left == nil && root?.right == nil) {
            //调换左右子树
            let temp = root?.left
            root?.left = root?.right
            root?.right = temp
            
            if root?.left != nil {
                root?.left = _reverse(root: root?.left)
            }
            
            if root?.right != nil {
                root?.right = _reverse(root: root?.right)
            }
        }
        return root
    }
    
    fileprivate mutating func _destroyNode(_ node : inout Node<KeyType>?) {
        node?.size = 0
        node = nil
    }
    
    fileprivate func _printNode(node : Node<KeyType>) {
        print(node.key, separator: "", terminator: ", ")
    }
}


