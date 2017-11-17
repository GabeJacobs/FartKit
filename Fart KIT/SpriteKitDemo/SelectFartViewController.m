//
//  SelectFartViewController.m
//  fARtJacker
//
//  Created by Gabe Jacobs on 11/8/17.
//  Copyright © 2017 Gabe Jacobs. All rights reserved.
//

#import "SelectFartViewController.h"
#import "MBProgressHUD.h"

#define kTutorialPointProductID @"com.mssngpeces.fartkit.premiumfarts"

@interface SelectFartViewController ()

@end

@implementation SelectFartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	self.selectedFart = [defaults integerForKey:@"selectedFart"];
	
	self.view.backgroundColor = [UIColor colorWithRed:0.32 green:0.78 blue:0.55 alpha:1.0];

	self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.backButton setImage:[UIImage imageNamed:@"BackDark"] forState:UIControlStateNormal];
	self.backButton.frame = CGRectMake(32, self.view.frame.size.height - 100, 60, 60);
	[self.backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.backButton];
	
	
	UIImageView *titleImage = [[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"FartPack"]];
	titleImage.contentMode = UIViewContentModeCenter;
	[titleImage setFrame:CGRectMake(0, self.view.frame.size.height/7.5, [UIImage imageNamed:@"FartPack"].size.width, [UIImage imageNamed:@"FartPack"].size.height)];
	 titleImage.center = CGPointMake(self.view.center.x, titleImage.center.y);
	[self.view addSubview:titleImage];
	
	self.selectionWrapper = [[UIView alloc]  initWithFrame:CGRectMake(20, titleImage.frame.size.height + titleImage.frame.origin.y + 40, self.view.frame.size.width - 40, self.view.frame.size.height/2.4)];
	[self.view addSubview:self.selectionWrapper];
    // Do any additional setup after loading the view.
	
	
	// wrappers
	self.button1Wrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.selectionWrapper.frame.size.width/3, self.selectionWrapper.frame.size.height/2)];
//	self.button1Wrapper.backgroundColor = [UIColor redColor];
	[self.selectionWrapper addSubview:self.button1Wrapper];
	
	self.button2Wrapper = [[UIView alloc] initWithFrame:CGRectMake(self.selectionWrapper.frame.size.width/3, 0, self.selectionWrapper.frame.size.width/3, self.selectionWrapper.frame.size.height/2)];
//	self.button2Wrapper.backgroundColor = [UIColor greenColor];
	[self.selectionWrapper addSubview:self.button2Wrapper];
	
	self.button3Wrapper = [[UIView alloc] initWithFrame:CGRectMake(2*(self.selectionWrapper.frame.size.width/3), 0, self.selectionWrapper.frame.size.width/3, self.selectionWrapper.frame.size.height/2)];
//	self.button3Wrapper.backgroundColor = [UIColor blackColor];
	[self.selectionWrapper addSubview:self.button3Wrapper];
	
	self.button4Wrapper = [[UIView alloc] initWithFrame:CGRectMake(0, self.selectionWrapper.frame.size.height/2, self.selectionWrapper.frame.size.width/3, self.selectionWrapper.frame.size.height/2)];
	[self.selectionWrapper addSubview:self.button4Wrapper];
	
	self.button5Wrapper = [[UIView alloc] initWithFrame:CGRectMake(self.selectionWrapper.frame.size.width/3, self.selectionWrapper.frame.size.height/2, self.selectionWrapper.frame.size.width/3, self.selectionWrapper.frame.size.height/2)];
	[self.selectionWrapper addSubview:self.button5Wrapper];
	
	self.button6Wrapper = [[UIView alloc] initWithFrame:CGRectMake(2*(self.selectionWrapper.frame.size.width/3), self.selectionWrapper.frame.size.height/2, self.selectionWrapper.frame.size.width/3, self.selectionWrapper.frame.size.height/2)];
	[self.selectionWrapper addSubview:self.button6Wrapper];
	
	/// buttons
	
	self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
	self.button1.frame = CGRectMake(18, 0, self.button1Wrapper.frame.size.width - 36, self.button1Wrapper.frame.size.width - 36);
	self.button1.backgroundColor = [UIColor colorWithRed:0.25 green:0.60 blue:0.42 alpha:1.0];
	self.button1.layer.cornerRadius = 16;
	[self.button1 addTarget:self action:@selector(tappedSelection:) forControlEvents:UIControlEventTouchUpInside];
	[self.button1Wrapper addSubview:self.button1];
	
	UIImageView *smoke = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Smoke"]];
	smoke.center = self.button1.center;
	[self.button1Wrapper addSubview:smoke];
	
	self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
	self.button2.frame = CGRectMake(18, 0, self.button2Wrapper.frame.size.width - 36, self.button2Wrapper.frame.size.width - 36);
	self.button2.backgroundColor = [UIColor colorWithRed:0.25 green:0.60 blue:0.42 alpha:1.0];
	self.button2.layer.cornerRadius = 16;
	[self.button2 addTarget:self action:@selector(tappedSelection:) forControlEvents:UIControlEventTouchUpInside];
	[self.button2Wrapper addSubview:self.button2];
	
	self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
	self.button3.frame = CGRectMake(18, 0, self.button2Wrapper.frame.size.width - 36, self.button2Wrapper.frame.size.width - 36);
	self.button3.backgroundColor = [UIColor colorWithRed:0.25 green:0.60 blue:0.42 alpha:1.0];
	self.button3.layer.cornerRadius = 16;
	[self.button3 addTarget:self action:@selector(tappedSelection:) forControlEvents:UIControlEventTouchUpInside];
	[self.button3Wrapper addSubview:self.button3];
	
	UIImageView *bomb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bomb"]];
	bomb.center = self.button3.center;
	[self.button3Wrapper addSubview:bomb];
	
	
	self.button4 = [UIButton buttonWithType:UIButtonTypeCustom];
	self.button4.frame = CGRectMake(18, 0, self.button4Wrapper.frame.size.width - 36, self.button4Wrapper.frame.size.width - 36);
	self.button4.backgroundColor = [UIColor colorWithRed:0.25 green:0.60 blue:0.42 alpha:1.0];
	self.button4.layer.cornerRadius = 16;
	[self.button4 addTarget:self action:@selector(tappedSelection:) forControlEvents:UIControlEventTouchUpInside];
	[self.button4Wrapper addSubview:self.button4];
	
	self.button5 = [UIButton buttonWithType:UIButtonTypeCustom];
	self.button5.frame = CGRectMake(18, 0, self.button5Wrapper.frame.size.width - 36, self.button5Wrapper.frame.size.width - 36);
	self.button5.backgroundColor = [UIColor colorWithRed:0.25 green:0.60 blue:0.42 alpha:1.0];
	self.button5.layer.cornerRadius = 16;
	[self.button5 addTarget:self action:@selector(tappedSelection:) forControlEvents:UIControlEventTouchUpInside];
	[self.button5Wrapper addSubview:self.button5];
	
	self.button6 = [UIButton buttonWithType:UIButtonTypeCustom];
	self.button6.frame = CGRectMake(18, 0, self.button6Wrapper.frame.size.width - 36, self.button6Wrapper.frame.size.width - 36);
	self.button6.backgroundColor = [UIColor colorWithRed:0.25 green:0.60 blue:0.42 alpha:1.0];
	self.button6.layer.cornerRadius = 16;
	[self.button6 addTarget:self action:@selector(tappedSelection:) forControlEvents:UIControlEventTouchUpInside];
	[self.button6Wrapper addSubview:self.button6];
	
	
	//labels
	
	self.button1Label = [[UILabel alloc] init];
	self.button1Label.font = [UIFont fontWithName:@"Rubik-Regular" size:12];
	self.button1Label.text = @"The Original";
	self.button1Label.textColor = [UIColor whiteColor];
	[self.button1Label sizeToFit];
	self.button1Label.center = self.button1.center;
	self.button1Label.frame = CGRectMake(self.button1Label.frame.origin.x, self.button1.frame.size.height + self.button1.frame.origin.y + 12, self.button1Label.frame.size.width, self.button1Label.frame.size.height);
	[self.button1Wrapper addSubview:self.button1Label];
	
	self.button2Label = [[UILabel alloc] init];
	self.button2Label.font = [UIFont fontWithName:@"Rubik-Regular" size:12];
	self.button2Label.text = @"The Rainbow";
	self.button2Label.textColor = [UIColor whiteColor];
	[self.button2Label sizeToFit];
	self.button2Label.center = self.button2.center;
	self.button2Label.frame = CGRectMake(self.button2Label.frame.origin.x, self.button2.frame.size.height + self.button2.frame.origin.y + 12, self.button2Label.frame.size.width, self.button2Label.frame.size.height);
	[self.button2Wrapper addSubview:self.button2Label];
	
	self.button3Label = [[UILabel alloc] init];
	self.button3Label.font = [UIFont fontWithName:@"Rubik-Regular" size:12];
	self.button3Label.text = @"The Atomic Cloud";
//	self.button3Label.numberOfLines = 2;
	self.button3Label.textAlignment = NSTextAlignmentCenter;
	self.button3Label.textColor = [UIColor whiteColor];
	[self.button3Label sizeToFit];
	self.button3Label.center = self.button3.center;
	self.button3Label.frame = CGRectMake(self.button3Label.frame.origin.x, self.button3.frame.size.height + self.button3.frame.origin.y + 12, self.button3Label.frame.size.width, self.button3Label.frame.size.height);
	[self.button3Wrapper addSubview:self.button3Label];
	
	self.button4Label = [[UILabel alloc] init];
	self.button4Label.font = [UIFont fontWithName:@"Rubik-Regular" size:12];
	self.button4Label.text = @"The Screamer";
	self.button4Label.textColor = [UIColor whiteColor];
	[self.button4Label sizeToFit];
	self.button4Label.center = self.button4.center;
	self.button4Label.frame = CGRectMake(self.button4Label.frame.origin.x, self.button4.frame.size.height + self.button4.frame.origin.y + 12, self.button4Label.frame.size.width, self.button4Label.frame.size.height);
	[self.button4Wrapper addSubview:self.button4Label];
	
	self.button5Label = [[UILabel alloc] init];
	self.button5Label.font = [UIFont fontWithName:@"Rubik-Regular" size:12];
	self.button5Label.text = @"Laser Danger";
	self.button5Label.textColor = [UIColor whiteColor];
	[self.button5Label sizeToFit];
	self.button5Label.center = self.button5.center;
	self.button5Label.frame = CGRectMake(self.button5Label.frame.origin.x, self.button5.frame.size.height + self.button5.frame.origin.y + 12, self.button5Label.frame.size.width, self.button5Label.frame.size.height);
	[self.button5Wrapper addSubview:self.button5Label];
	
	self.button6Label = [[UILabel alloc] init];
	self.button6Label.font = [UIFont fontWithName:@"Rubik-Regular" size:12];
	self.button6Label.text = @"The Hose";
	self.button6Label.textColor = [UIColor whiteColor];
	[self.button6Label sizeToFit];
	self.button6Label.center = self.button6.center;
	self.button6Label.frame = CGRectMake(self.button6Label.frame.origin.x, self.button6.frame.size.height + self.button6.frame.origin.y + 12, self.button6Label.frame.size.width, self.button6Label.frame.size.height);
	[self.button6Wrapper addSubview:self.button6Label];
	
	
	self.button1.tag = 0;
	self.button2.tag = 1;
	self.button3.tag = 2;
	self.button4.tag = 3;
	self.button5.tag = 4;
	self.button6.tag = 5;
	
	/// buy buttons
	
	self.buyAll6 = [UIButton buttonWithType:UIButtonTypeCustom];
	self.buyAll6.frame = CGRectMake(self.view.frame.size.width/2 - 110, self.selectionWrapper.frame.size.height + self.selectionWrapper.frame.origin.y, 220, 32);
	[self.buyAll6 setTitle:@"BUY ALL SIX FOR .99" forState:UIControlStateNormal];
	[self.buyAll6.titleLabel setFont:[UIFont fontWithName:@"Rubik-Bold" size:12]];
	self.buyAll6.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.buyAll6.backgroundColor = [UIColor colorWithRed:0.21 green:0.49 blue:0.34 alpha:1.0];
	self.buyAll6.layer.cornerRadius = 16;
	[self.view addSubview:self.buyAll6];
	
	self.restorePurchases = [UIButton buttonWithType:UIButtonTypeCustom];
	self.restorePurchases.frame = CGRectMake(self.view.frame.size.width/2 - 110, self.buyAll6.frame.size.height + self.buyAll6.frame.origin.y + 12, 220, 32);
	[self.restorePurchases setTitle:@"RESTORE PURCHASES" forState:UIControlStateNormal];
	[self.restorePurchases.titleLabel setFont:[UIFont fontWithName:@"Rubik-Bold" size:12]];
	self.restorePurchases.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.restorePurchases.backgroundColor = [UIColor colorWithRed:0.21 green:0.49 blue:0.34 alpha:1.0];
	self.restorePurchases.layer.cornerRadius = 16;
	[self.view addSubview:self.restorePurchases];

	[self updateUIForSelection];
	
//	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//	[self fetchAvailableProducts];

}

- (void)goBack {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
	return NO;
}

- (void)updateUIForSelection {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSInteger selection = [defaults integerForKey:@"selectedFart"];
	
	switch (selection) {
		case 0:
			self.button1.layer.borderColor = [[UIColor colorWithRed:0.91 green:1.00 blue:0.22 alpha:1.0] CGColor];
			self.button1.layer.borderWidth = 3;
			
			self.button2.layer.borderWidth = 0;
			self.button3.layer.borderWidth = 0;
			self.button4.layer.borderWidth = 0;
			self.button5.layer.borderWidth = 0;
			self.button6.layer.borderWidth = 0;

			break;
			
		case 1:
			self.button2.layer.borderColor = [[UIColor colorWithRed:0.91 green:1.00 blue:0.22 alpha:1.0] CGColor];
			self.button2.layer.borderWidth = 3;
			
			self.button1.layer.borderWidth = 0;
			self.button3.layer.borderWidth = 0;
			self.button4.layer.borderWidth = 0;
			self.button5.layer.borderWidth = 0;
			self.button6.layer.borderWidth = 0;
			
			break;
			
		case 2:
			self.button3.layer.borderColor = [[UIColor colorWithRed:0.91 green:1.00 blue:0.22 alpha:1.0] CGColor];
			self.button3.layer.borderWidth = 3;
			
			self.button1.layer.borderWidth = 0;
			self.button2.layer.borderWidth = 0;
			self.button4.layer.borderWidth = 0;
			self.button5.layer.borderWidth = 0;
			self.button6.layer.borderWidth = 0;
			
			break;
			
		case 3:
			self.button4.layer.borderColor = [[UIColor colorWithRed:0.91 green:1.00 blue:0.22 alpha:1.0] CGColor];
			self.button4.layer.borderWidth = 3;
			
			self.button1.layer.borderWidth = 0;
			self.button2.layer.borderWidth = 0;
			self.button3.layer.borderWidth = 0;
			self.button5.layer.borderWidth = 0;
			self.button6.layer.borderWidth = 0;
			
			break;
			
		case 4:
			self.button5.layer.borderColor = [[UIColor colorWithRed:0.91 green:1.00 blue:0.22 alpha:1.0] CGColor];
			self.button5.layer.borderWidth = 3;
			
			self.button1.layer.borderWidth = 0;
			self.button2.layer.borderWidth = 0;
			self.button3.layer.borderWidth = 0;
			self.button4.layer.borderWidth = 0;
			self.button6.layer.borderWidth = 0;
			
			break;
			
		case 5:
			self.button6.layer.borderColor = [[UIColor colorWithRed:0.91 green:1.00 blue:0.22 alpha:1.0] CGColor];
			self.button6.layer.borderWidth = 3;
			
			self.button1.layer.borderWidth = 0;
			self.button2.layer.borderWidth = 0;
			self.button3.layer.borderWidth = 0;
			self.button4.layer.borderWidth = 0;
			self.button5.layer.borderWidth = 0;
			
			break;
		default:
			break;
	}
}

- (void)tappedSelection:(UIButton *)selection {
	NSInteger tapped = selection.tag;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger:tapped forKey:@"selectedFart"];
	[defaults synchronize];
	[self updateUIForSelection];
	
	NSNumber *tappedNum = [NSNumber numberWithInt:(int)tapped];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"changeSelection" object:tappedNum];
}

/// purchases


- (void)fetchAvailableProducts {
	NSLog(@"%@", kTutorialPointProductID);
	NSSet *productIdentifiers = [NSSet setWithObjects:kTutorialPointProductID,nil];
	self.productsRequest = [[SKProductsRequest alloc]  initWithProductIdentifiers:productIdentifiers];
	self.productsRequest.delegate = self;
	[self.productsRequest start];
}


- (BOOL)canMakePurchases {
	return [SKPaymentQueue canMakePayments];
}

- (void)purchaseMyProduct:(SKProduct*)product {
	if ([self canMakePurchases]) {
		SKPayment *payment = [SKPayment paymentWithProduct:product];
		[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
		[[SKPaymentQueue defaultQueue] addPayment:payment];
	} else {
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
								  @"Purchases are disabled in your device" message:nil delegate:
								  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[alertView show];
	}
}
-(IBAction)purchase:(id)sender {
	[self purchaseMyProduct:[self.validProducts objectAtIndex:0]];
}


-(void)paymentQueue:(SKPaymentQueue *)queue
updatedTransactions:(NSArray *)transactions {
	for (SKPaymentTransaction *transaction in transactions) {
		switch (transaction.transactionState) {
			case SKPaymentTransactionStatePurchasing:
				NSLog(@"Purchasing");
				break;
				
			case SKPaymentTransactionStatePurchased:
				if ([transaction.payment.productIdentifier
					 isEqualToString:kTutorialPointProductID]) {
					NSLog(@"Purchased ");
					UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
											  @"Purchase is completed succesfully" message:nil delegate:
											  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
					[alertView show];
				}
				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				break;
				
			case SKPaymentTransactionStateRestored:
				NSLog(@"Restored ");
				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				break;
				
			case SKPaymentTransactionStateFailed:
				NSLog(@"Purchase failed");
				break;
			default:
				break;
		}
	}
}

-(void)productsRequest:(SKProductsRequest *)request
	didReceiveResponse:(SKProductsResponse *)response {
	SKProduct *validProduct = nil;
	int count = [response.products count];
	
	if (count>0) {
		self.validProducts = response.products;
		validProduct = [response.products objectAtIndex:0];
		
		if ([validProduct.productIdentifier
			 isEqualToString:kTutorialPointProductID]) {
		
			NSLog(@"%@" , [NSString stringWithFormat:@"Product Price: %@",validProduct.price]);
			NSLog(@"%@" , [NSString stringWithFormat:@"Product Desc: %@",validProduct.localizedDescription]);
			NSLog(@"%@" , [NSString stringWithFormat:@"Product Title: %@",validProduct.localizedTitle]);
			
		}
	} else {
		UIAlertView *tmp = [[UIAlertView alloc]
							initWithTitle:@"Not Available"
							message:@"No products to purchase"
							delegate:self
							cancelButtonTitle:nil
							otherButtonTitles:@"Ok", nil];
		[tmp show];
	}
	
	[MBProgressHUD hideHUDForView:self.view animated:YES];
}


@end
