//
//  SelectFartViewController.h
//  fARtJacker
//
//  Created by Gabe Jacobs on 11/8/17.
//  Copyright © 2017 Gabe Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface SelectFartViewController : UIViewController <SKProductsRequestDelegate, SKPaymentTransactionObserver>


@property (nonatomic,strong) SKProductsRequest *productsRequest;
@property (nonatomic,strong) NSArray *validProducts;

@property (nonatomic) NSInteger selectedFart;

@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic, strong) UIView *selectionWrapper;

@property (nonatomic, strong) UIView *button1Wrapper;
@property (nonatomic, strong) UIView *button2Wrapper;
@property (nonatomic, strong) UIView *button3Wrapper;
@property (nonatomic, strong) UIView *button4Wrapper;
@property (nonatomic, strong) UIView *button5Wrapper;
@property (nonatomic, strong) UIView *button6Wrapper;

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIButton *button5;
@property (nonatomic, strong) UIButton *button6;

@property (nonatomic, strong) UILabel *button1Label;
@property (nonatomic, strong) UILabel *button2Label;
@property (nonatomic, strong) UILabel *button3Label;
@property (nonatomic, strong) UILabel *button4Label;
@property (nonatomic, strong) UILabel *button5Label;
@property (nonatomic, strong) UILabel *button6Label;

@property (nonatomic, strong) UIButton *buyAll6;
@property (nonatomic, strong) UIButton *restorePurchases;


@end
