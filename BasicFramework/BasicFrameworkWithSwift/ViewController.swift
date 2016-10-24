//
//  ViewController.swift
//  BasicFrameworkWithSwift
//
//  Created by mr-tech on 16/9/23.
//  Copyright © 2016年 Rainy. All rights reserved.
//

import Foundation
import UIKit



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    
        part3()
        
    
}


    
       }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

/*
 1 func 函数名(形参列表) -> 返回值类型  {
 // 函数体...
 
 }
 func 函数名(形参列表) -> Void {
 // 函数体...
 }
 
 func 函数名(形参列表) -> () {
 // 函数体...
 }
 
 func 函数名(形参列表) {
 // 函数体...
 }
 一个函数如果没有形参，函数名后面的小括号也不能省略
 一个函数也可以返回元组数据
 
 2   外部参数名可以在调用函数时提醒每个参数的含义  一般情况下，第一个参数省略其外部参数名，第二个以后的参数使用其局部参数名作为自己的外部参数名。
 
 所有参数必须有不同的局部参数名（parameter name），尽管外部参数名（argument label）可以是相同的，独特的外部参数名还是能让代码更具有可读性。
 func 函数名(外部参数名 形式参数名: 形式参数类型) -> 返回值类型  {
 // 函数体...
 }
 外部参数名写在形式参数名的前面，与形式参数名之间用空格隔开
 注意：一旦定义了外部参数名，在调用函数时就必须加上外部参数名
 使用#能简化外部参数名的定义
 func sum(#num1 : Int, #num2 : Int)
 {
 return num1 + num2
 }
 既是形式参数名，又是外部参数名
 3 默认参数值
 （1）可以在定义函数时，给形参指定一个默认值，调用函数时，就可以不用给这个形参传值
 
 func addStudent(name: String, age: Int = 20) {
 println("添加1个学生：name=\(name)，age=\(age)")
 }
 addStudent("jack")
 （2）带有默认参数值的形参，Swift会自动给它生成一个跟形参名相同的外部参数名
 
 age: Int = 20相当于#age: Int = 20
 
 因此，如果要传入age参数值时，只能这么调用
 
 addStudent("jack", age: 25)
 
 （3）在带有默认参数值的参数名前加个下划线 _ ，调用函数时就不用写外部参数名
 
 第一个参数的外部名默认是省略的，所以 不必为它添加下划线。（V2.1）
 
 
 func addStudent(name: String, _ age: Int = 20) {
 println("添加1个学生：name=\(name)，age=\(age)")
 }
 
 addStudent("jack", 25)
 
 注：如果在代码中，某个存储的数据量不会再发生变化，则总是把这个量用let关键字声明为常量。只用变量来表示那些需要改变值的量。
 
 Swift可以根据赋的初值来推断出变量或常量的类型。当你没有赋予初值的时候，则务必要声明变量或常量的类型。
 var red, green, blue: Double
 
 默认情况下，打印输出的内容会在最后换行。如果不想换行，可以将空的字符串传递给terminator
 
 尽量不要使用UInt，除非你真的需要存储一个和当前平台原生字长相同的无符号整数。除了这种情况，最好使用Int，即使你要存储的值已知是非负的。统一使用Int可提高代码的可复用性，避免不同整型数据之间的转换，并且匹配整型的类型推测。
 如果你在需要使用Bool类型的地方使用了非布尔值，Swift 的类型安全机制会报错：
 */

/*
 类和结构体
 类和结构体是人们构建代码所用的一种通用且灵活的构造体。可以使用完全相同的语法规则来为类和结构体定义属性（常量、变量）和添加方法，从而扩展类和结构体的功能。
 不同于其他语言，Swift不需要为类和结构体创建独立的接口和实现文件。在一个单一文件中定义一个类或者结构体，系统将会自动生成面向其它代码的外部接口。通常一个类的实例被称为对象（object）。
 、类和结构体的比较
 
 相同点：
 
 定义属性（properties）用于存储值
 定义方法（methods）用于提供功能
 定义附属下标（subscripts）用于访问值
 定义构造器（initializers）用于建立初始化状态
 通过扩展（extend）以增加默认实现的功能
 实现协议（protocols）以提供某种标准功能
 与结构体相比，类还有如下的附加功能：
 
 继承（Inheritance），允许一个类继承另一个类的特征
 类型转换（Type casting），允许在运行时检查和解释一个类实例的类型
 解构器（Deinitializers），允许一个类实例释放任何其所被分配的资源
 引用计数（Reference counting ），允许对一个类的多次引用
 注意： 结构体总是通过被复制的方式在代码中传递，没有用到引用计数。
 
 、类和结构体的选择
 
 在代码中，可以使用类和结构体来定义自定义数据类型。
 
 但是，结构体实例总是通过值传递，类实例总是通过引用传递。这意味两者适用不同的任务。
 
 按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：
 
 结构体的主要目的是用来封装少量相关简单数据值。
 有理由预计一个结构体实例在赋值或传递时，封装的数据将会被拷贝而不是被引用。
 任何在结构体中储存的值类型属性，也将会被拷贝，而不是被引用。
 结构体不需要去继承另一个已存在类型的属性或者行为。
 举例来说，以下情境中适合使用结构体：
 
 几何形状的大小，封装一个width属性和height属性，两者均为Double类型。
 一定范围内的路径，封装一个start属性和length属性，两者均为Int类型。
 三维坐标系内一点，封装x，y和z属性，三者均为Double类型。
 在其它情况下，定义一个类，生成一个它的实例，并通过引用来管理和传递。实际中，这意味着绝大部分的自定义数据构造都应该是类，而非结构体。
 
 Swift 中字符串（String）,数组（Array）和字典（Dictionary）类型均以结构体的形式实现。这意味着String，Array，Dictionary类型数据被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会发生拷贝行为（值传递方式）。
 注意： 以上是对于字符串、数组、字典和其它值的拷贝的描述。 在代码中，拷贝好像确实是在有拷贝行为的地方产生过。实际上，在 Swift 的后台中，只有确有必要，实际（actual）拷贝才会被执行。Swift 管理所有的值拷贝以确保性能最优化的性能，所以没有必要去避免赋值以保证最优性能。
 
 */

