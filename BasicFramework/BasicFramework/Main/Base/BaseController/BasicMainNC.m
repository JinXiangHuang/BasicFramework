//
//

#import "BasicMainNC.h"



@interface BasicMainNC ()



@end

@implementation BasicMainNC

- (void)viewDidLoad {
    [super viewDidLoad];
    //非继承，用不到  navigation不使用继承
    self.title = @"BasicMainNC";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"destroy_nvc1" style:UIBarButtonItemStylePlain target:self action:@selector(disMissNvc)];

}
-(void)disMissNvc{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setItems
{
    
    self.view.backgroundColor = kMarkedColor;
    
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
