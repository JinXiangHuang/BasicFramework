//
//  bPreferenceViewController.m
//  BasicFramework
//
//  Created by mr-tech on 16/11/2.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "bPreferenceViewController.h"
#import "bLanguageManager.h"
@interface bPreferenceViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    BOOL editingButtonSelect;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataAry;
@property (nonatomic,copy) NSString *searchText;//搜索词
@property(nonatomic, strong)NSMutableArray *selectedArray;//是否被点击
@end

@implementation bPreferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataAry = [NSMutableArray new];
    _selectedArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil];//这个用于判断展开还是缩回当前section的cell
    [self changeLanguage];
    [self addSearchBar];
    // Do any additional setup after loading the view.
}
- (void)addSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
    searchBar.placeholder = kLocalizedString(@"search",@"搜索");
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
    [self.view addSubview:self.tableView];
    
//    //block 回调
//    __weak __typeof(self)weakSelf = self;
//    kLanguageManager.completion = ^(NSString *currentLanguage) {
//        __strong __typeof(self)self = weakSelf;
//        [self changeLanguage];
//    };
}
#pragma mark - data

//目前支持的语言
- (NSMutableArray *)languageAry {
    return [NSMutableArray arrayWithObjects:@"zh-Hans-CN", @"zh-Hant-CN", @"en-CN",  @"ko-CN",  @"ja-CN", @"fr-CN", @"it-CN", nil];
//    return @[@"zh-Hans-CN", @"zh-Hant-CN", @"en-CN",  @"ko-CN",  @"ja-CN", @"fr-CN", @"it-CN"];
}

- (NSArray *)dataAry {
    if (_searchText.length > 0) {
        //搜索则返回搜索数据
        return _dataAry;
    }
    else
    {
        //反之返回所有数据
        return self.languageAry;
    }
}

////对应国家的语言
- (NSString *)ittemCountryLanguage:(NSString *)lang {
    NSString *language = [kLanguageManager languageFormat:lang];
    
    //国家语言
    NSString *countryLanguage = [[[NSLocale alloc] initWithLocaleIdentifier:language] displayNameForKey:NSLocaleIdentifier value:language];
    return countryLanguage;
}

////当前语言下的对应国家语言翻译
- (NSString *)ittemCurrentLanguageName:(NSString *)lang {
    NSString *language = [kLanguageManager languageFormat:lang];
    //当前语言
    NSString *currentLanguage = kLanguageManager.currentLanguage;
    //当前语言下的对应国家语言翻译
    NSString *currentLanguageName = [[[NSLocale alloc] initWithLocaleIdentifier:currentLanguage] displayNameForKey:NSLocaleIdentifier value:language] ;
    
    return currentLanguageName;
}

#pragma mark UITableViewDataSource/UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 0)];
    view.backgroundColor = [UIColor brownColor];
    UIButton *haadView =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
    haadView.backgroundColor = [UIColor orangeColor];
    [haadView setTitle:[NSString stringWithFormat:@"列表展示%ld",section] forState:UIControlStateNormal];
    [haadView addTarget:self action:@selector(headerDelegate:) forControlEvents:UIControlEventTouchUpInside];
    haadView.tag = section + 1000;
    [view addSubview:haadView];
    return view;
}
-(void)headerDelegate:(UIButton *)button
{
  
   
    
    if ([_selectedArray[button.tag - 1000] isEqualToString:@"0"]) {
        [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"1"];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
    }
    else{
        //如果当前点击的section是展开的,那么点击后就需要把它缩回,使_selectedArray对应的值为0,这样当前section返回cell的个数变成0,然后刷新这个section就行了
        [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"0"];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
    }
}



-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
    
    //UITableViewCellEditingStyleInsert;//左编辑为添加
    
    //UITableViewCellEditingStyleNone//左编辑为空,不可编辑
    
    //UITableViewCellEditingStyleDelete//左编辑为删除
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
// 这一行是否可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}
//这个方法用来告诉表格 这一行是否可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//这个方法就是执行移动操作的
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *) sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    id object = [self.languageAry objectAtIndex:fromRow];
    [self.languageAry removeObjectAtIndex:fromRow];
    [self.languageAry insertObject:object atIndex:toRow];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
          NSLog(@"%@",indexPath);
//        [self.languageAry removeAllObjects];删除对应的数据
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
//        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];//
        
        NSLog(@"%@",NSStringFromCGSize([@"删除对应的数据删除对应的数据删除对应的数据删除对应的数据删除对应的数据删除对应的数据删除对应的数据删除对应的数据" sizeWithFont:[UIFont systemFontOfSize:18]]));
        NSLog(@"%@",NSStringFromCGSize(CGSizeMake(MAXFLOAT, MAXFLOAT)));
        NSLog(@"%@",NSStringFromCGRect([@"删除对应的数据删除对应的数据删除对应的数据删除对应的数据删除对应的数据删除对应的数据删除对应的数据删除对应的数据" boundingRectWithSize:CGSizeMake(180, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:18]} context:nil]));
    
//        //        设置图片拉伸的方式
//        //        第一个参数:当需要横向拉伸的时候,就复制第image.size.width/2 + 1个像素
//        //        第二个参数:当纵向需要拉伸的时候,就复制第51个像素
//        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:50];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//       [_tableView insertRowsAtIndexPaths:@[path1,path2] withRowAnimation:UITableViewRowAnimationRight];
//        NSIndexPath *path1 = [NSIndexPath indexPathForRow:2 inSection:0];
//        NSIndexPath *path2 = [NSIndexPath indexPathForRow:3 inSection:0];

    }
}
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    return 3;
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //判断section的标记是否为1,如果是说明为展开,就返回真实个数,如果不是就说明是缩回,返回0.
    if ([_selectedArray[section] isEqualToString:@"1"])
    {
        return self.dataAry.count;

    }
    return 0;
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellID"];
    }

    
    NSString *language = [kLanguageManager languageFormat:self.dataAry[indexPath.row]];
    
    //对应国家的语言
    NSString *countryLanguage = [self ittemCountryLanguage:self.dataAry[indexPath.row]];
    //当前语言下的对应国家语言翻译
    NSString *currentLanguageName = [self ittemCurrentLanguageName:self.dataAry[indexPath.row]] ;
    
    cell.textLabel.text = countryLanguage;
    cell.detailTextLabel.text = currentLanguageName;
    
    if (_searchText.length > 0) {
        cell.textLabel.attributedText = [self searchTitle:countryLanguage key:_searchText keyColor:[UIColor redColor]];
        cell.detailTextLabel.attributedText = [self searchTitle:currentLanguageName key:_searchText keyColor:[UIColor redColor]];
    } else {
        cell.textLabel.text = countryLanguage;
        cell.detailTextLabel.text = currentLanguageName;
    }
    
    //当前语言
    NSString *currentLanguage = kLanguageManager.currentLanguage;
    
    if([currentLanguage rangeOfString:language].location != NSNotFound)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    NSString *language = self.dataAry[indexPath.row];
    [kLanguageManager setUserlanguage:language];
    [self cancleButtonAction:nil];
     */
    
    
//     1、标记行
     UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];
     if (oneCell.accessoryType == UITableViewCellAccessoryNone) {
     oneCell.accessoryType = UITableViewCellAccessoryCheckmark;
     } else
     oneCell.accessoryType = UITableViewCellAccessoryNone;
    oneCell.tintColor = [UIColor greenColor];
     
    
    NSLog(@"%@",[self.tableView indexPathForSelectedRow]);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}






#pragma mark - UISearchBar Delegate

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    [self changeSearchBarCancleText:searchBar];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 252);
}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
    _searchText = searchText;
    
    [self ittemSearchResultsDataAryWithSearchText:searchText];
    
    [self.tableView reloadData];
}

//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    _searchText = nil;
    searchBar.text = nil;
    [self.view endEditing:YES];
    self.tableView.frame = [UIScreen mainScreen].bounds;
    [self.tableView reloadData];
}

//搜索结果按钮点击的回调
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    [kLanguageManager setUserlanguage:searchBar.text];
    [self cancleButtonAction:nil];
}

//修改searchBar中的文字为多语言
- (void)changeSearchBarCancleText:(UISearchBar *)searchBar {
    for (UIView *view in [[searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:kLocalizedString(@"cancel",@"取消") forState:UIControlStateNormal];
            [cancelBtn setTitle:kLocalizedString(@"cancel",@"取消") forState:UIControlStateHighlighted];
            [cancelBtn setTitle:kLocalizedString(@"cancel",@"取消") forState:UIControlStateSelected];
            [cancelBtn setTitle:kLocalizedString(@"cancel",@"取消") forState:UIControlStateDisabled];
        }
    }
}

#pragma mark - 自定义方法

//根据搜索词来查找符合的数据
- (void)ittemSearchResultsDataAryWithSearchText:(NSString *)searchText {
    [_dataAry removeAllObjects];
    
    [self.languageAry enumerateObjectsUsingBlock:^(NSString *lang, NSUInteger idx, BOOL * _Nonnull stop) {
        //对应国家的语言
        NSString *countryLanguage = [self ittemCountryLanguage:lang];
        //当前语言下的对应国家语言翻译
        NSString *currentLanguageName = [self ittemCurrentLanguageName:lang] ;
        
        if([countryLanguage rangeOfString:_searchText options:NSCaseInsensitiveSearch].location != NSNotFound || [currentLanguageName rangeOfString:_searchText options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [_dataAry addObject:lang];
        }
    }];
}

// 设置文字中关键字高亮
- (NSMutableAttributedString *)searchTitle:(NSString *)title key:(NSString *)key keyColor:(UIColor *)keyColor {
    
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSString *copyStr = title;
    
    NSMutableString *xxstr = [NSMutableString new];
    for (int i = 0; i < key.length; i++) {
        [xxstr appendString:@"*"];
    }
    
    while ([copyStr rangeOfString:key options:NSCaseInsensitiveSearch].location != NSNotFound) {
        
        NSRange range = [copyStr rangeOfString:key options:NSCaseInsensitiveSearch];
        
        [titleStr addAttribute:NSForegroundColorAttributeName value:keyColor range:range];
        copyStr = [copyStr stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:xxstr];
    }
    return titleStr;
}






#pragma mark - Action

//刷新界面
- (void)changeLanguage {
    self.title = kLocalizedString(@"preference",@"偏好");
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:kLocalizedString(@"cancel",@"取消") style:UIBarButtonItemStyleDone target:self action:@selector(cancleButtonAction:)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editing)];
   
    [self.tableView reloadData];
}
-(void)editing{

     [_tableView setEditing:!editingButtonSelect animated:YES];
      editingButtonSelect = !editingButtonSelect;
}
//取消按钮
- (void)cancleButtonAction:(UIButton *)button {
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 懒加载
/*
 1.简单粗暴，直接转化
 
 float f = 1.5;
 int a;
 a = (int)f;
 NSLog("a = %d",a);

 输出结果是1。（int）是强制类型转化，丢弃浮点数的小数部分。
 
 2.高斯函数，向下取整
 
 float f = 1.6;
 int a;
 a = floor(f);
 NSLog("a = %d",a);

 输出结果是1。floor()方法是向下取整，类似于数学中的高斯函数 [].取得不大于浮点数的最大整数，对于正数来说是舍弃浮点数部分，对于复数来说，舍弃浮点数部分后再减1.
 
 3.ceil函数，向上取整。
 
 float f = 1.5;
 int a;
 a = ceil(f);
 NSLog("a = %d",a);

 输出结果是2。ceil()方法是向上取整，取得不小于浮点数的最小整数，对于正数来说是舍弃浮点数部分并加1，对于复数来说就是舍弃浮点数部分.
 
 4.通过强制类型转换四舍五入。
 
 float f = 1.5;
 int a;
 a = (int)(f+0.5);
 NSLog("a = %d",a);
 **/
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
    //从iOS7开始，设置选择背景为蓝色，已经没有作用了
       //选中颜色
        // cell.selectionStyle = UITableViewCellSelectionStyleBlue;
//        cell.selectedBackgroundView = bgView
        
        //分割线
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorColor = [UIColor blackColor];
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        /*提高tableView的性能
         　　a、重用cell
         　　我们都知道申请内存是需要时间，特别是在一段时间内频繁的申请内存将会造成很大的开销，而且上tebleView中cell大部分情况下布局都是一样的，这个时候我们可以通过回收重用机制来提高性能。
         　　b、避免content的重新布局
         　　尽量避免在重用cell时候，对cell的重新布局，一般情况在在创建cell的时候就将cell布局好。
         　　c、使用不透明的subView
         　　在定制cell的时候，将要添加的subView设置成不透明的会大大减少多个view层叠加时渲染所需要的时间。
         　　d、如果方便，直接重载subView的drawRect方法
         　　如果定制cell的过程中需要多个小的元素的话，最好直接对要显示的多个项目进行绘制，而不是采用添加多个subView。
         　　e、tableView的delegate的方法如非必要，尽量不要实现
         　　tableView的delegate中的很多函数提供了对cell属性的进一步控制，比如每个cell的高度，cell是否可以编辑，支持的edit风格等，如非必要最好不要实现这些方法因为快速的调用这些方法也会影响性能。*/
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
