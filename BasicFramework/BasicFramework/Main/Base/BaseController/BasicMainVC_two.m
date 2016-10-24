//
//  BasicMainVC_two.m
//  BasicFramework
//
//  Created by mr-tech on 16/9/19.
//  Copyright © 2016年 Rainy. All rights reserved.
//
#import "BasicMainVC_two.h"
#import "LYLIMGScrollView.h"
/**
 首先@表示当前使用的OC代码。
 @property有两个对应的词，一个是@synthesize，一个是@dynamic。如果@synthesize和@dynamic都没写，那么默认的就是@syntheszie var = _var;
 
 @synthesize的语义是如果你没有手动实现setter方法和getter方法，那么在编译的时候编译器会自动为你加上这两个方法。不用消息转发
 
 @dynamic告诉编译器,属性的setter与getter方法由用户自己实现，不自动生成。（当然对于readonly的属性只需提供getter即可）。假如一个属性被声明为@dynamic var，然后你没有提供@setter方法和@getter方法，编译的时候没问题，但是当程序运行到instance.var =someVar，由于缺setter方法会导致程序崩溃；或者当运行到 someVar = var时，由于缺getter方法同样会导致崩溃。编译时没问题，运行时才执行相应的方法，这就是所谓的动态绑定。
 
 
 
  利用消息转发机制来实现@dynamic的setter和getter方法。
 
 
 
 @dynamic最常用的使用是在NSManagedObject中，此时不需要显示编程setter和getter方法。原因是：@dynamic告诉编译器不做处理，使编译通过，其getter和setter方法会在运行时动态创建，由Core Data框架为此类属性生成存取方法。
 
 iOS内存管理
 copy的作用：新、建立一个索引计数为1 的对象，然后释放旧对象（一般在NSString 和 block中使用）copy是深复制，一个新的对象 如果希望字串的值跟着赋值的字串的值变化，可以使用strong，retain。
 
 So，Block属性的声明，首先需要用copy修饰符(非arc)。Block默认存放在栈中，可能随时被销毁，需要作用域在堆中，所以只有copy后的Block才会在堆中，栈中的Block的生命周期是和栈绑定的。
 编译器自动对 block 进行了 copy 操作(arc)
 
  因此防止循环引用的方法如下：(arc)  __weak typeof(self) *weakSelf = self;(非arc)__block typeof(self) weakSelf = self;（因为ARC环境下仍然会被retain）
 
  修改局部变量时：需要加__block，否则不能在block中修改局部变量。
 
 
 
 Mutable 产生新对象  [*** copy] -> 不可变
 
 
 [objc copy]||[objc Mutablecopy]
 1<NSCopying>  2.copyWithZone重新分配新的内存空间||mutableCopyWithZone:(NSZone *)zone  3.allocWithZone:zone] init];
 
 
 当修饰可变类型的属性时用strong。(属性可变) NSArray 可以强制转换NSMutableArray
 
 当修饰不可变类型的属性时用copy。(属性不可变)
 
 
 
 **/
/**【ARC的特性】
 
 　　ARC下，所有NSObject类型指针，
 
 　　1. 默认为__strong类型
 
 　　2. 可以显示的指定为__weak类型，__weak类型指针在所指向对象销毁后会自动置为nil
 
 　　3. __autorelesing类型用于inout参数类型
 
 　　ARC下，当一个函数返回一个NSObject指针时，编译器会帮我们实现autorelease调用。例如：
 
 　　return pObject;
 
 　　编译器会帮我们扩展为 return [pObject autorelease];
 
 　　ARC下，不能显式release，可以使用将值赋为nil来让编译器为我们release。
 
 【ARC与Block】
 
 　　Block的生命周期管理非常的微妙，与ARC混在一起后，更加复杂。
 
 　　当Block延stack向上（up）传递的时候，直接返回，编译器会添加[[ copy] autorelease]代码。
 
 　　当Block延stack向下传递给需要retain的容器的时候，需要显式的调用[^{} copy]方法。
 
 　　在ARC下，__block修改的NSObject指针依然会被retain。
 
 　　在ARC下，一个block内引用一个对象的实例变量后，self会被retain，所以极易造成strong reference cycle，可以通过__weak指针来避免这种情形，因为ARC不会为__weak指针retain。**/

/**
 const与宏的区别
    编译时刻:宏是预编译(编译之前处理)，const是编译阶段。
 　　编译检查:宏不做检查，不会报编译错误，只是替换，const会编译检查，会报编译错误。
 　　宏的好处:宏能定义一些函数，方法。 const不能。
 　　宏的坏处:使用大量宏，容易造成编译时间久，每次都需要重新替换。
 **/

// 常见的常量：抽成宏
#define XMGAccount @"account"
#define XMGUserDefault [NSUserDefaults standardUserDefaults]

// 字符串常量   被const修饰的变量是只读的。 仅仅用来修饰右边的变量

static NSString * const account = @"account";
static const NSString * account2 = @"account";

@interface BasicMainVC_two ()<LYLIMGScrollViewDelegate>
{
   @private
    NSMutableDictionary *_propertiesDict;

}
@property (retain,nonatomic) NSString *rStr;
@property (copy, nonatomic)   NSString *cStr;
@property (copy) void (^SubmitBlock)(int number);

@property (nonatomic, copy  ) NSMutableArray *mcopy;
@property (nonatomic, strong) NSMutableArray *mstrong;
@property (nonatomic, strong) NSArray        *array;
//@property (nonatomic, copy) NSArray        *array;(error)
@end

@implementation BasicMainVC_two
-(void)test2{
    
    // 偏好设置存储
    
    // 使用宏
   [XMGUserDefault setValue:@"123" forKey:XMGAccount];
    
    // 使用const常量
   [[NSUserDefaults standardUserDefaults] setValue:@"123" forKey:account];
    
    int a = 10;
    
    int *p = &a; //(*p（指针变量） 指向a的地址) -> *p = a
    
     NSLog(@"%p",&a);
    
     NSLog(@"%d",a);
    
     NSLog(@"%d",*p);
    
     NSLog(@"%p",p);
    
    NSString * s = @"1";

     NSLog(@"%p",&s);
    
    
    
    
    
    
}

- (void)test{
    NSMutableString *mStr = [NSMutableString stringWithFormat:@"abc"];
    self.rStr   = mStr;
    self.cStr     = mStr;
    NSLog(@"mStr:%p,%p",  mStr,&mStr);
    NSLog(@"retainStr:%p,%p", _rStr, &_rStr);
    NSLog(@"copyStr:%p,%p",   _cStr, &_cStr);
    /*当把NSMutableString赋值给NSString的时候，才会有不同，如果是赋值是NSString对象，那么使用copy还是strong，结果都是一样的，因为NSString对象根本就不能改变自身的值，他是不可变的。浅拷贝*/
   __block int multiplier = 7;//不能在block中修改局部变量
    self.SubmitBlock = ^(int number){
        multiplier ++;//这样就可以了
        NSLog(@"%d",multiplier)

    };
    //NSMutableArray 被copy、strong修饰后的变化：
     NSMutableArray * muarr = [NSMutableArray array];
    
    /*等同于
     @property (nonatomic, strong) NSMutableArray *mcopy;
     NSMutableArray* muarr = [NSMutableArray array];
     mcopy = [muarr copy];
     mcopy 被copy后就成了NSArray了。
     */
    self.mcopy = muarr;

    self.mstrong = muarr;
    
    NSLog(@"%p,%p,%p",self.mcopy,muarr,self.mstrong);
    
    NSLog(@"%@,%@,%@",self.mcopy.class,muarr.class,self.mstrong.class);
    
//    [self.mcopy removeAllObjects];不可变
    
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    [mutableArray addObject:@"1"];
    
    self.array = [NSArray array];
    
    self.array = mutableArray;
    
    NSMutableArray *mutableArray2 = (NSMutableArray *)self.array;
    
    
    NSLog(@"array---%@  array.class --- %@",self.array,self.array.class);
    
    [mutableArray addObject:@"2"];
    
    NSLog(@"array---%@  array.class --- %@",self.array,self.array.class);
    
    [mutableArray2 removeAllObjects];
    
    NSLog(@"array---%@  array.class --- %@",self.array,self.array.class);
    
}
//@dynamic 可以利用消息转发机制来实现setter和getter方法
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    //为另一个类实现的消息创建一个有效的方法签名
    NSString *sel = NSStringFromSelector(selector);
    if ([sel rangeOfString:@"set"].location == 0)
    {
        //set***
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        
    }
    else
    {
        //get***
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
        
    }
    
}
//-(void)blockTest:(void(^)(int number))block{
//
//
//
//}


- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *key = NSStringFromSelector([invocation selector]);
    
    if ([key rangeOfString:@"set"].location == 0)
    {
        key= [[key substringWithRange:NSMakeRange(3, [key length]-4)] lowercaseString];
        
        NSString *obj;
        
        [invocation getArgument:&obj atIndex:2];//得到参数
        
        [_propertiesDict setObject:obj forKey:key];
    }
    else
    {
        NSString *obj = [_propertiesDict objectForKey:key];
        [invocation setReturnValue:&obj];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

//    [self test];
    
    [self test2];
    /*
    UIButton * button = [[UIButton alloc]initWithFrame: CGRectMake(200, 0, 150, 150)];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"lookImage" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(LYLIMGScroll) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIScrollView * scr = [[UIScrollView alloc]initWithFrame:CGRectMake(50, 300, 300, 300)];
    scr.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scr];
    UIImageView * imv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    imv.userInteractionEnabled = YES;
    [imv yg_setImageWithURL:[NSURL URLWithString:@"http://pic1.5442.com/2013/0830/05/02.jpg"] placeholderImage:[UIImage createImageWithColor:kThemeColor] progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"**%ld,%ld",receivedSize,expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"***%@,%@",NSStringFromCGSize(image.size),image.CGImage);
        NSLog(@"***%f,%ld",image.scale,image.imageOrientation);
        imv.size = image.size;
        //        imv.frame = CGRectMake(10, 10,image.size.width, image.size.height);
        //        imv.bounds = CGRectMake(10, 10, image.size.width, image.size.height);
        scr.contentSize = image.size;
        [scr addSubview:imv];
    }];
    
    // 增加额外的滚动区域（逆时针，上、左、下、右）
    // top  left  bottom  right
    scr.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
}
- (void)LYLIMGScroll{
    
    NSMutableArray * mm = [[NSMutableArray alloc]init];
    for (int i = 0; i< 10 ; i++) {
        for (int j=0; j < 10; j++) {
            [mm addObject:[NSString stringWithFormat:@"http://pic1.5442.com/2013/0830/0%d/0%d.jpg",i,j]];
        }
    }
    
    LYLIMGScrollView * lb = [[LYLIMGScrollView alloc]initWithImgURLs:mm withIndexPage:0];
    lb.backgroundColor = [UIColor purpleColor];
    //    lb.contentSize = CGSizeMake(30, 30);
    lb.LYLScrDelegate = self;
    [self.view addSubview:lb];*/
    
}
-(void)touchedImageViewAction:(id)sender{
    
    NSLog(@"单击%@",sender);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file.*/
//            <key>NSAppTransportSecurity</key>
//            <dict>
//            <key>NSAllowsArbitraryLoads</key>
//            <true/>
//            </dict>

@end
