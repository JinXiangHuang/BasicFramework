//
//  commixOCViewController.swift
//  BasicFramework
//
//  Created by mr-tech on 16/9/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

import UIKit

//@objc(commixOCViewController)
 class commixOCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       //调用OC
        RootViewController.init().nsKeyedArchiverarchiveRootObject()
       //
//        logMe()
//        self.logMe()
        
          函数1()
      
          函数2()
        
          函数3()
        
          UI操作()

        //接受通知监听
        NotificationCenter.default.addObserver(self, selector:#selector(didMsgRecv(notification:)), name: NSNotification.Name(rawValue:"notifyChatMsgRecv"), object: nil)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func 函数3(){
        struct Resolution {
            //当这两个属性被初始化为整数0的时候，它们会被推断为Int类型。
            var width = 0
            var height = 0
        }
        class VideoMode {
            var resolution = Resolution()
            var interlaced : Bool = false
            var frameRate = 0.0
            var name: String? = "not nil"
        }
        /*命名
         UpperCamelCase -> 类与结构体的命名
         lowerCamelCase -> 属性与方法的命名
         
         /**/
         */
        
        let somesomeResolution = Resolution(width: 1920, height: 1080)//结构体的成员逐一构造器 Resolution.init(width: 1, height: 1)
        let someResolution = Resolution.init()
        let someVideoMode = VideoMode()
        
        print("***",someResolution,somesomeResolution)
        
        print("***\(someResolution)\(somesomeResolution)",someResolution,somesomeResolution)
        
        (VideoMode.init().interlaced ? print(someVideoMode.name) :print(someVideoMode.resolution.height))
        
        //在 Swift 中，所有的结构体和(!!!!枚举!!!!)类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制
        let hd = Resolution(width: 1920, height: 1080)
        var cinema = hd
        //将hd赋予给cinema的时候，实际上是将hd中所存储的值（values）进行拷贝，然后将拷贝的数据存储到新的cinema实例中。结果就是两个完全独立的实例碰巧包含有相同的数值。由于两者相互独立，因此将cinema的width修改为2048并不会影响hd中的width的值。
        cinema.width = 2048
        print(hd.width)
        
        enum CompassPoint {
            case North, South, East, West
        }
        //枚举中定义的值（例如 North，South，East和West）是枚举的成员值（或者成员）。case关键词用来定义新的一行成员值。
        // 注意：和 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的CompassPoints例子中，North，South，East和West不会隐式地赋值为了0，1，2和3。相反，这些不同的枚举成员在显示定义的类型CompassPoint中拥有各自不同的值。多个成员值可以出现在同一行上，用逗号隔开：必须以一个大写字母开头
        var currentDirection = CompassPoint.West
        let rememberedDirection = currentDirection
        
        print(CompassPoint.West ,"asd")
     
        currentDirection = .East//使用点语法（.）将其设置为另一个CompassPoint的值
        if rememberedDirection == .West {
            print("The remembered direction is still .West")
        }
        //在判断一个枚举类型的值时，switch语句必须穷举所有情况。强制性全部穷举的要求确保了枚举成员不会被意外遗漏。不需要匹配每个成员时，用default代替剩下的情况：
        
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        print(tenEighty.frameRate)//类是引用类型，所以tenEight和alsoTenEight实际上引用的是相同的VideoMode实例,需要注意的是tenEighty和alsoTenEighty被声明为常量（constants）而不是变量
        
        let alsoalsoTen = VideoMode()
        print(alsoalsoTen.frameRate)//它们并不存储这个VideoMode实例，在后台仅仅是对VideoMode实例的引用。改变的是被引用的基础VideoMode的frameRate参数，而不改变常量的值。
        /*
         Swift 内建了两个恒等运算符：
         等价于 （ === ）class type
         不等价于 （ !== ）
         运用这两个运算符检测两个常量或者变量是否引用同一个实例：
         */
        if alsoalsoTen === alsoTenEighty {
            print("运用这两个运算符检测两个常量或者变量是引用同一个实例")
        }else{
            print("运用这两个运算符检测两个常量或者变量不是引用同一个实例")
        }
        
        //递归枚举（recursive enumeration）是一种枚举类型，在枚举中，有一个或多个枚举成员拥有该枚举的其他成员作为相关值。在枚举成员前加上indirect来表示这成员可递归。也可以在开头就加上indirect关键字：indirect enum ArithmeticExpression {
        enum ArithmeticExpression {
            case Number(Int)
            indirect case Addition(ArithmeticExpression, ArithmeticExpression)
            indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        
        func evaluate(expression: ArithmeticExpression) -> Int {
            switch expression {
            case .Number(let value):
                return value
            case .Addition(let left, let right):
                return evaluate(expression: left) + evaluate(expression: right)
            case .Multiplication(let left, let right):
                return evaluate(expression: left) * evaluate(expression: right)
            }
        }
        
        // evaluate (5 + 4) * 2
        
        let product = ArithmeticExpression.Multiplication(ArithmeticExpression.Addition(ArithmeticExpression.Number(5), ArithmeticExpression.Number(4)), ArithmeticExpression.Number(2))
        print(evaluate(expression: product),product)
        // prints "18"
        
        //闭包
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        let names2 = [2, 1, 0, 3, 4]
        
        func backward(s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        
        func backward2(s1: Int, _ s2: Int) -> Bool {
            return s1 > s2
        }
        var reversed = names.sorted(by: backward)
        let reversed2 = names2.sorted(by: { (s1: Int, s2: Int) -> Bool in
            return s1 > s2
        })
        print(reversed2)
        
        print(reversed)
        
        
        func greet(person: String, from hometown: String) -> String {
            return "Hello \(person)!  Glad you could visit from \(hometown)."
        }
        print(greet(person: "Bill", from: "Cupertino"))
        
        
        func sum(num1 : Int, num2 : Int = 1) -> Int
        {
            return num1 + num2
        }
        
        
        func someFunction(parameterWithDefault: Int = 12) {
            // function body goes here
            // if no arguments are passed to the function call,
            // value of parameterWithDefault is 12
        }
        someFunction(parameterWithDefault: 6) // parameterWithDefault is 6
        someFunction() // parameterWithDefault is 12
        
        
        
        func chooseStepFunction(backward: Bool) -> (Int) -> Int {
            func stepForward(input: Int) -> Int { return input + 1 }
            func stepBackward(input: Int) -> Int { return input - 1 }
            return backward ? stepBackward : stepForward
        }
        var currentValue = -4
        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
        // moveNearerToZero now refers to the nested stepForward() function
        while currentValue != 0 {
            print("\(currentValue)... ")
            currentValue = moveNearerToZero(currentValue)
        }
        print("zero!")
        // -4...
        // -3...
        // -2...
        // -1...
        // zero!
        
        
//        func swapTwoInts(inout a: Int, inout _ b: Int) {
//            
//            let temporaryA = a
//            a = b
//            b = temporaryA
//        }
        //函数的参数默认看做常量，在函数体内试图改变参数的值会报编译时错误。如果你想在函数中改变某个参数的值，并将这种变化保留到函数外部，那么可以将参数定义为in-out参数。注意： in-out参数不能有默认值，而且不定参数不能用 inout 标记。
        
        //7、函数类型        每个函数都有种特定的函数类型，由函数的参数类型和返回类型组成。
        /*
         （1）使用函数类型
         
         函数类型的使用和其他类型一样，例如，可以把一个函数赋值给一个常量或变量。
         
         var mathFunction: (Int, Int) -> Int = addTwoInts
         这样，可以用mathFunction的名字来调用addTwoInts函数：
         
         print("Result: \(mathFunction(2, 3))")
         // prints "Result: 5"
         同一函数类型的其他函数也可以赋值给这个变量：
         
         mathFunction = multiplyTwoInts
         print("Result: \(mathFunction(2, 3))")
         // prints "Result: 6"
         由于函数推断，可以不用显示声明变量的类型：
         
         let anotherMathFunction = addTwoInts
         // anotherMathFunction is inferred to be of type (Int, Int) -> Int
         （2）函数类型作为参数类型
         
         你可以用(Int, Int) -> Int这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现交由给函数的调用者。
         
         func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
         print("Result: \(mathFunction(a, b))")
         }
         printMathResult(addTwoInts, 3, 5)
         // prints "Result: 8"
         （3）函数类型作为返回类型
         
         可以用函数类型作为另一个函数的返回类型。
         
         例如，下面是两个简单函数。
         
         
         func stepForward(_ input: Int) -> Int {
         return input + 1
         }
         func stepBackward(_ input: Int) -> Int {
         return input - 1
         }
         
         下面这个叫做 chooseStepFunction(_:) 的函数，它的返回类型是 (Int) -> Int 的函数。
         
         chooseStepFunction(backward:) 根据布尔值 backwards 来返回 stepForward(_:) 函数或 stepBackward(_:) 函数：
         
         func chooseStepFunction(backward: Bool) -> (Int) -> Int {
         return backward ? stepBackward : stepForward
         }
         可以用chooseStepFunction(_:) 来获得一个函数：
         
         var currentValue = 3
         let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
         // moveNearerToZero now refers to the stepBackward() function
         moveNearerToZero已获得了正确的函数，就可以用来将数字数到0：
         
         
         print("Counting to zero:")
         // Counting to zero:
         while currentValue != 0 {
         print("\(currentValue)... ")
         currentValue = moveNearerToZero(currentValue)
         }
         print("zero!")
         // 3...
         // 2...
         // 1...
         // zero!
         
         */
    }
    func 函数2() -> Void {
       
        //如果赋值的右边是一个多元组, 它的元素可以马上被分解多个变量或变量：
        let (x, y) = (1, 2)
        print("\(x)\(y)")
        //与C语言和Objective-C不同, Swift的赋值操作并不返回任何值.复合赋值并没有返回一个值，例如，不能写成 let b = a += 2
        //Swift3.0版本没有++和--运算符了。单目负号写在操作数之前, 中间没有空格.单目正号就直接返回操作数的值.也可以比较两个元组，只要它们元素数目相同，并且对应元素可以相互比较。注意:Swift的标准库只能比较少于7个元素的元组，如果需要比较更多元素，你需要自己实现比较运算符。
        let contentHeight = 40
        let hasHeader = true
        let rowHeight = contentHeight + (hasHeader ? 50 : 20)
        print(rowHeight);//rowHeight is equal to 90
        

        //如果提供的自定义颜色名为空，则返回默认颜色。
        let defaultColorName = "red"
        var userDefinedColorName: String?   // defaults to nil
        var colorNameToUse = userDefinedColorName ?? defaultColorName
        // userDefinedColorName is nil, so colorNameToUse is set to the default of "red"
        print(colorNameToUse)
        
    
        userDefinedColorName = "green"
        colorNameToUse = userDefinedColorName ?? defaultColorName
        print(colorNameToUse)
        

        userDefinedColorName = nil
        colorNameToUse = (userDefinedColorName != nil ? userDefinedColorName! : defaultColorName)
        print(colorNameToUse)
        
        let names = ["Anna", "Alex", "Brian", "Jack"]
        let count = names.count
        for i in 0..<count {
            print("Person \(i + 1) is called \(names[i])")
        }
         //Swift还提供了两个范围操作符(a..<b)闭区间
        //和(a...b)。开区间
    }

    func 函数1() {
        
        func append( string: String, suffix: String, count: Int) -> String
        {
            var string = string
            for _ in 0..<count {
                string += suffix
            }
            return string
        }
        func swap(_ num1: inout Int,_ num2: inout Int) {
            let tempNum1 = num1
            num1 = num2
            num2 = tempNum1
            /*声明函数时，在参数类型前面用inout修饰，在函数内部实现改变外部参数，注意，这里只能传入变量，不能传入常量和字面量，因为这些是不能变的一旦定义，当我们传入的时候，在变量名字前面用&符号修饰表示，传递给inout参数，表明这个变量在参数内部是可以被改变的 inout修饰的参数是不能有默认值的，有范围的参数集合也不能被修饰，另外，一个参数一旦被inout修饰，就不能再被var和let修饰了*/
        }
        
        print( append( string: "jack", suffix: ".", count: 4) )// 调用函数
        var someInt = 7
        var anotherInt = 107
        swap(&someInt, &anotherInt)
        print(someInt,anotherInt)
        
        var myVariable = 42
        myVariable = 50 ;print(myVariable)//Swift不需要在每一句表达式后面加分号，但是如果同一行有多个表达式，则需要分号来分隔。
        
        let myConstant = 42
        print(myConstant, terminator: "")//不换行
        
        let x = 0.0, y = 0.0, z = 0.0
        print(x,y,z)//, 空格
        
        typealias AudioSample = UInt16//类型别名
        typealias AudioSample2 = Int16
        typealias HSting = String
        let maxAmplitudeFound = AudioSample.min
        let maxAmplitudeFound2 = AudioSample2.min
        let maxAmplitudeFound3 : String = "类型名"
        let maxAmplitudeFound4 : HSting = "类型别名"
        print("maxAmplitudeFound,AudioSample2\(maxAmplitudeFound,maxAmplitudeFound2)",maxAmplitudeFound3,maxAmplitudeFound4,AudioSample.max,maxAmplitudeFound3.appending("+"))
        
        var aa :Int?
        aa = 10
        let orangesAreOrange = 1
        let turnipsAreDelicious = 2
        if turnipsAreDelicious + aa! == 2 {
            print("Mmm, tasty turnips!")
        } else if orangesAreOrange == 1 {
            print("Eww, turnips are horrible.")
        }
        
        let possibleNumber :HSting? = "123"
        let convertedNumber = Int(possibleNumber!)//如果确定可选包确实含值，你可以在可选的名字后面加一个感叹号(!)来获取值。这个惊叹号表示“我知道这个可选有值，请使用它。”这被称为可选值的强制解析（forced unwrapping）使用!来获取一个不存在的可选值会导致运行时错误。使用!来强制解析值之前，一定要确定可选包含一个非nil的值。unexpectedly found nil while unwrapping an Optional value
        print(convertedNumber)
        
        var optionalString: String? //变量的可选值 "?"标记变量是可选的
        optionalString = nil //nil 与? 可以通过赋值nil使可选值变成没有值的状态  注意：nil不能赋给不可选的常量或变量，如果变量的值存在没有值的情况，那就将其声明为可选型。如果没有赋初值，则可选型默认初值为nil。Swift的nil不同于Objective-C的nil。在Objective-C中，nil是一个不存在的对象的指针。在Swift中，nil不是一个指针，它是某种类型的缺失值，不只是对象，任意类型的可选值都可以赋值为nil
        
        /*
         可选绑定
         
         使用可选绑定（optional binding）来判断可选是否有值，如果有，就把值赋给一个临时常量或者变量。可选绑定可以用在if和while语句中来对可选的值进行判断并把值赋给一个常量或者变量。
         
         */
        
      
       let optionalName: String?
        
        if arc4random() < arc4random() {
            
          optionalName = nil
            
        }else{
            
          optionalName = "optionalName"
        }
        
        var greeting = "Hello"
        if let name = optionalName {
            greeting = greeting+","+name
            print("ture",greeting)
        }else{
            
            greeting = greeting+","
            print("可选值是nil,条件会判断为false",greeting)
        }
        
        /*隐式解析可选
         
         有时候在程序架构中，第一次被赋值之后，可以确定一个可选总会有值。在这种情况下，每次都要判断和解析可选值是非常低效的，因为可以确定它总会有值。
         
         这种类型的可选被定义为隐式解析可选（implicitly unwrapped optionals）。把想要用作可选的类型的后面的问号（String?）改成感叹号（String!）来声明一个隐式解析可选。
         
         一个隐式解析可选其实就是一个普通的可选，但是可以被当做非可选来使用，并不需要每次都使用解析来获取可选值。
         */
        let possibleString: String? = "asd"
        let forcedString: String = possibleString! // requires an exclamation mark
        
        let assumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString // no need for an exclamation mark
        
        /*
         let possibleString: String?
         let forcedString: String = possibleString!
         注意：如果在隐式解析可选没有值的时候尝试取值，会触发运行时错误。和在没有值的普通可选后面加一个惊叹号一样。
         
         可以把隐式解析可选当做普通可选来判断它是否包含值，*/
        
        if assumedString != nil {
            
            print(implicitString,forcedString)
        }
        
        /*
         1、用断言进行调试
         
         断言会在运行时判断一个逻辑条件是否为true。从字面意思来说，断言“断言”一个条件是否为真。你可以使用断言来保证在运行其他代码之前，某些重要的条件已经被满足。如果条件判断为true，代码运行会继续进行；如果条件判断为false，代码运行停止，你的应用被终止。
         2、什么时候使用断言
         
         当条件可能为假时使用断言，但是最终一定要保证条件为真，这样你的代码才能继续运行。断言的适用情景：
         
         - 整数的附属脚本索引被传入一个自定义附属脚本实现，但是下标索引值可能太小或者太大。
         
         - 需要给函数传入一个值，但是非法的值可能导致函数不能正常执行。
         
         - 一个可选值现在是nil，但是后面的代码运行需要一个非nil值。
         
         注意：断言可能导致应用终止运行，所以应当仔细设计你的代码来让非法条件不会出现。当然，在你的应用发布之前，有时候非法条件可能出现，这时使用断言可以快速发现问题
         */
                 let age = 3
                 assert(age >= 0)
                 assert(age >= 0, "A person's age cannot be less than zero")

        
                hs1(1, 参数2: 2)
    
                print(hs2(num: 1, num2: 2))
        
                var a = 4
        
              for _ in 0..<5 {
               increase(a: &a)
              }
        
            let queue = DispatchQueue(label: "myqueue")
               queue.async {
                debugPrint("hello world!")
                }
    }

    //通知处理函数
    func didMsgRecv(notification:NSNotification){
        print("didMsgRecv: \(notification.userInfo)")
    }
    func UI操作() {
        
        let label:UILabel = UILabel()
        
        label.text = "123456"
        
        label.frame = CGRect(x:100, y: 100, width: 100, height: 100)
        
        self.view.addSubview(label)
        
        
        
        let button:UIButton = UIButton()
        
        button.frame = CGRect(x: 100,y: 200,width: 100,height: 100)
        
        button.backgroundColor = UIColor.orange
        
        button.setTitle("🔘", for: UIControlState())
        
        button.addTarget(self, action: #selector(logMe), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(button)
        
        
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notifyChatMsgRecv"), object: "参数")
        
        NotificationCenter.default.post(Notification.init(name: NSNotification.Name(rawValue:"notifyChatMsgRecv")))
    }
    
    func logMe() {
        print("log me - swift");
        
    }
   
    func hs1(_ num1:Int,参数2 :Int) {
      // 从第一个参数就必须指定参数名，除非使用"_"明确指出省略参数 外部名
        print("log \(num1) - swift",num1);
        
        
    }
    func hs2(num: Int,num2: Int) -> (Int,Int){
//        取消var参数
        var nu = num
        nu = 10
        
        let nu2 = num2
    
        return (nu,nu2);
    }
    func increase( a:inout Int) {

        a += 1  //3.0 rm a ++
        print(a)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
