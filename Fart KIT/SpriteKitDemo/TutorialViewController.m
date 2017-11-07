//
//  TutorialViewController.m
//  SpriteKitDemo
//
//  Created by Gabe Jacobs on 10/27/17.
//  Copyright © 2017 Gabe Jacobs. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	
	self.tutorialTitle = [[UILabel alloc] init];
	self.tutorialTitle.font = [UIFont fontWithName:@"Rubik-Black" size:20];
	self.tutorialTitle.text = @"TUTORIAL";
	self.tutorialTitle.textColor = [UIColor colorWithRed:0.32 green:0.78 blue:0.55 alpha:1.0];;
	self.tutorialTitle.frame = CGRectMake(32, self.view.frame.size.height/2 - 150, self.view.frame.size.width - 64, 20);
	[self.view addSubview:self.tutorialTitle];
	
	self.tutorialText = [[UILabel alloc] init];
	NSMutableAttributedString* attrString = [[NSMutableAttributedString  alloc] initWithString:@"To use the fARtjacker,\nsimply swipe in the direction\nyou’d like the fart to travel\n(from your friend’s butt)."];
	NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
	[style setLineSpacing:7];
	[attrString addAttribute:NSParagraphStyleAttributeName
					   value:style
					   range:NSMakeRange(0, attrString.length)];
	[attrString addAttribute:NSForegroundColorAttributeName
					   value: [UIColor colorWithRed:0.21 green:0.49 blue:0.34 alpha:1.0]
					   range:NSMakeRange(0, attrString.length)];
	[attrString addAttribute:NSFontAttributeName
					   value: [UIFont fontWithName:@"Rubik-Regular" size:20]
					   range:NSMakeRange(0, attrString.length)];

	self.tutorialText.attributedText = attrString;
	self.tutorialText.frame = CGRectMake(32, self.tutorialTitle.frame.origin.y, self.view.frame.size.width - 64, 250);
	self.tutorialText.numberOfLines = 5;
	[self.view addSubview:self.tutorialText];
	
	
	self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.backButton setImage:[UIImage imageNamed:@"Arrow"] forState:UIControlStateNormal];
	self.backButton.frame = CGRectMake(32, self.view.frame.size.height - 100, 60, 60);
	[self.backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.backButton];
	
}

- (void)goBack {
	[self.navigationController popViewControllerAnimated:YES];
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
