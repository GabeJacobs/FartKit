//
//  MainMenuViewController.m
//  
//
//  Created by Gabe Jacobs on 10/27/17.
//

#import "MainMenuViewController.h"
#import "CameraViewController.h"
#import "TutorialViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
		
	self.view.backgroundColor = [UIColor colorWithRed:0.32 green:0.78 blue:0.55 alpha:1.0];
	
	self.icon = [[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"Icon"]];
	self.icon.center = CGPointMake(self.view.center.x, self.view.center.y - 90);
	[self.view addSubview:self.icon];
	
	self.titleImage = [[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"Title"]];
	self.titleImage.center = self.view.center;
	self.titleImage.contentMode = UIViewContentModeCenter;
	[self.titleImage setFrame:CGRectMake(self.titleImage.frame.origin.x, self.icon.frame.origin.y + self.icon.frame.size.height + 15, self.titleImage.frame.size.width, self.titleImage.frame.size.height)];
	[self.view addSubview:self.titleImage];
	
	self.tutorial = [UIButton buttonWithType:UIButtonTypeCustom];
	self.tutorial.backgroundColor =  [UIColor colorWithRed:0.21 green:0.49 blue:0.34 alpha:1.0];;
	self.tutorial.frame = CGRectMake(0, 0, 136, 34);
	self.tutorial.center = CGPointMake(self.view.center.x, self.view.center.y + 90);
	self.tutorial.layer.cornerRadius = 4;
	[self.tutorial addTarget:self action:@selector(showTutorial) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.tutorial];
	
	UILabel *tutorial = [[UILabel alloc] initWithFrame:self.tutorial.frame];
	tutorial.font = [UIFont fontWithName:@"Rubik-Bold" size:16];
	tutorial.text = @"TUTORIAL";
	tutorial.textColor = [UIColor whiteColor];
	tutorial.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:tutorial];
	
	self.begin = [UIButton buttonWithType:UIButtonTypeCustom];
	self.begin.backgroundColor =  [UIColor colorWithRed:0.21 green:0.49 blue:0.34 alpha:1.0];;
	self.begin.frame = CGRectMake(0, 0, 136, 34);
	self.begin.center = CGPointMake(self.view.center.x, self.view.center.y + 140);
	self.begin.layer.cornerRadius = 4;
	[self.begin addTarget:self action:@selector(showCamera) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.begin];
	
	UILabel *begin = [[UILabel alloc] initWithFrame:self.begin.frame];
	begin.font = [UIFont fontWithName:@"Rubik-Bold" size:16];
	begin.text = @"BEGIN";
	begin.textColor = [UIColor whiteColor];
	begin.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:begin];
	
	
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showTutorial {
	TutorialViewController *tutorialController = [[TutorialViewController alloc]init];
	[self.navigationController pushViewController:tutorialController animated:YES];
	
}

- (void)showCamera {
	CameraViewController *cameraController = [[CameraViewController alloc]init];
	[self.navigationController presentViewController:cameraController animated:YES completion:nil];
}

-(BOOL)prefersStatusBarHidden {
	return YES;
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
