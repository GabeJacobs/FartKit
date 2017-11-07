//
//  MainMenuViewController.m
//  
//
//  Created by Gabe Jacobs on 10/27/17.
//

#import "MainMenuNavigationController.h"
#import "MainMenuViewController.h"


@interface MainMenuNavigationController ()

@end

@implementation MainMenuNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.toolbarHidden = YES;
	self.navigationBar.hidden = YES;
	
	MainMenuViewController *mainMenu = [[MainMenuViewController alloc] init];
	[self pushViewController:mainMenu animated:NO];
    // Do any additional setup after loading the view.
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
