import Foundation

public struct UnionFindTestHelper {
    
    public static func testUF(_ n : Int, unionFind : UFType) {
        
        //算法执行前的时间点
        let startTime : clock_t = clock()
        for _ in 0 ..< n {
            let a = randomNum(n)
            let b = randomNum(n)
            unionFind.union(a, b)
        }
        
        for _ in 0 ..< n {
            let a = randomNum(n)
            let b = randomNum(n)
            _ = unionFind.isConnected(a, b)
        }
        //算法执行完的时间点
        let endTime : clock_t = clock()
        
        //计算出时间差然后除以 CLOCKS_PER_SEC 取得以秒为单位的时间
        let timeInterval = Double(endTime - startTime) / Double(CLOCKS_PER_SEC)
        
        //打印Double类型变量时会输出科学计数法，
        //如 1.8e-05,使用C语法exp()来转换成正常的数字输出
        print("Name : \(unionFind.unionFindName), \nOperation time : \(exp(timeInterval)) s\n")
    }
}

func randomNum(_ n : Int) -> Int {
    let rNum = arc4random() % UInt32(n)
    return Int(rNum)
}


