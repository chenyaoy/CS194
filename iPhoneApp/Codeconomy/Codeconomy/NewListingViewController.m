//
//  NewListingViewController.m
//  Codeconomy
//
//  Created by studio on 2/15/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "NewListingViewController.h"
#import "Util.h"

@interface NewListingViewController ()
@property (nonatomic, strong) UILabel *xButton;
@property (nonatomic, strong) UITapGestureRecognizer *xButtonRecognizer;
@property (nonatomic, strong) UILabel *listingTitle;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *whatStore;
@property (nonatomic, strong) UITextField *storeField;
@property (nonatomic, strong) UILabel *shortTitle;
@property (nonatomic, strong) UITextField *shortTitleField;
@property (nonatomic, strong) UILabel *doesItExpire;
@property (nonatomic, strong) UIButton *checkMark;
@property (nonatomic, strong) UIButton *xMark;
@property (nonatomic, strong) UILabel *when;
@property (nonatomic, strong) UITextField *whenField;
@property (nonatomic, strong) UIDatePicker *whenPickerView;
@property (nonatomic, strong) UILabel *extraInfo;
@property (nonatomic, strong) UITextField *extraInfoField;
@property (nonatomic, strong) UILabel *creditsForCode;
@property (nonatomic, strong) UITextField *creditsField;
@property (nonatomic, strong) UILabel *pickCategory;

@property (nonatomic, strong) UIButton *categoryClothing;
@property (nonatomic, strong) UIButton *categoryConcerts;
@property (nonatomic, strong) UIButton *categoryFood;
@property (nonatomic, strong) UIButton *categoryElectronics;

@property (nonatomic, strong) UILabel *couponCode;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UIButton *postIt;

@property (nonatomic, strong) UITapGestureRecognizer *scrollViewTap;

@end

@implementation NewListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[[Util sharedManager] colorWithHexString:@"F7F7F7"]];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    _scrollViewTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
    [_scrollView addGestureRecognizer:_scrollViewTap];
    
    _xButton = [[UILabel alloc] init];
    _xButton.text = @"✕";
    _xButton.font = [UIFont systemFontOfSize:24.0f];
    [_xButton sizeToFit];
    _xButton.userInteractionEnabled = YES;
    _xButtonRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapX)];
    [_xButton addGestureRecognizer:_xButtonRecognizer];
    [self.view addSubview:_xButton];
    _listingTitle = [[UILabel alloc] init];
    _listingTitle.text = @"New Listing";
    _listingTitle.font = [UIFont systemFontOfSize:18.0f];
    [_listingTitle sizeToFit];
    [self.view addSubview:_listingTitle];
    _whatStore = [[UILabel alloc] init];
    _whatStore.text = @"What store/event is your code for?";
    _whatStore.numberOfLines = 2;
    _whatStore.font = [UIFont systemFontOfSize:24.0f];
    [_scrollView addSubview:_whatStore];
    _storeField = [[UITextField alloc] init];
    _storeField.layer.cornerRadius = 10;
    _storeField.layer.masksToBounds = YES;
    _storeField.layer.borderWidth = 1.0f;
    _storeField.layer.borderColor = [[UIColor blackColor] CGColor];
    _storeField.backgroundColor = [UIColor whiteColor];
    _storeField.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
    [_scrollView addSubview:_storeField];
    _shortTitle = [[UILabel alloc] init];
    _shortTitle.text = @"Write a short title! (e.g. \"$5 off $20 purchase\")";
    _shortTitle.numberOfLines = 2;
    _shortTitle.font = [UIFont systemFontOfSize:24.0f];
    [_scrollView addSubview:_shortTitle];
    _shortTitleField = [[UITextField alloc] init];
    _shortTitleField.layer.cornerRadius = 10;
    _shortTitleField.layer.masksToBounds = YES;
    _shortTitleField.layer.borderWidth = 1.0f;
    _shortTitleField.layer.borderColor = [[UIColor blackColor] CGColor];
    _shortTitleField.backgroundColor = [UIColor whiteColor];
    _shortTitleField.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
    [_scrollView addSubview:_shortTitleField];
    _doesItExpire = [[UILabel alloc] init];
    _doesItExpire.text = @"Does it expire?";
    _doesItExpire.font = [UIFont systemFontOfSize:24.0f];
    [_doesItExpire sizeToFit];
    [_scrollView addSubview:_doesItExpire];
    _checkMark = [[UIButton alloc] init];
    [_checkMark setTitle:@"✔" forState:UIControlStateNormal];
    _checkMark.titleLabel.textAlignment = NSTextAlignmentCenter;
    _checkMark.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    _checkMark.layer.borderWidth = 6.0f;
    _checkMark.layer.borderColor = [[UIColor blackColor] CGColor];
    _checkMark.layer.cornerRadius = 10;
    _checkMark.layer.masksToBounds = YES;
    [_scrollView addSubview:_checkMark];
    _xMark = [[UIButton alloc] init];
    [_xMark setTitle:@"✕" forState:UIControlStateNormal];
    [_xMark setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _xMark.titleLabel.textAlignment = NSTextAlignmentCenter;
    _xMark.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    _xMark.layer.borderWidth = 6.0f;
    _xMark.layer.borderColor = [[UIColor blackColor] CGColor];
    _xMark.layer.cornerRadius = 10;
    _xMark.layer.masksToBounds = YES;
    [_scrollView addSubview:_xMark];
    _when = [[UILabel alloc] init];
    _when.text = @"When?";
    _when.font = [UIFont systemFontOfSize:24.0f];
    [_when sizeToFit];
    [_scrollView addSubview:_when];
    _whenField = [[UITextField alloc] init];
    _whenField.layer.cornerRadius = 10;
    _whenField.layer.masksToBounds = YES;
    _whenField.layer.borderWidth = 1.0f;
    _whenField.layer.borderColor = [[UIColor blackColor] CGColor];
    _whenField.backgroundColor = [UIColor whiteColor];
    _whenField.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
    [_scrollView addSubview:_whenField];
    _whenPickerView = [[UIDatePicker alloc] init];
    _whenPickerView.datePickerMode = UIDatePickerModeDate;
    _whenField.inputView = _whenPickerView;
    [_whenPickerView addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    _extraInfo = [[UILabel alloc] init];
    _extraInfo.text = @"Any more information?";
    _extraInfo.font = [UIFont systemFontOfSize:24.0f];
    [_extraInfo sizeToFit];
    [_scrollView addSubview:_extraInfo];
    _extraInfoField = [[UITextField alloc] init];
    _extraInfoField.layer.cornerRadius = 10;
    _extraInfoField.layer.masksToBounds = YES;
    _extraInfoField.layer.borderWidth = 1.0f;
    _extraInfoField.layer.borderColor = [[UIColor blackColor] CGColor];
    _extraInfoField.backgroundColor = [UIColor whiteColor];
    _extraInfoField.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
    [_scrollView addSubview:_extraInfoField];
    _creditsForCode = [[UILabel alloc] init];
    _creditsForCode.text = @"🔑 for your code?";
    _creditsForCode.font = [UIFont systemFontOfSize:24.0f];
    [_creditsForCode sizeToFit];
    [_scrollView addSubview:_creditsForCode];
    _creditsField = [[UITextField alloc] init];
    _creditsField.layer.cornerRadius = 10;
    _creditsField.layer.masksToBounds = YES;
    _creditsField.layer.borderWidth = 1.0f;
    _creditsField.layer.borderColor = [[UIColor blackColor] CGColor];
    _creditsField.backgroundColor = [UIColor whiteColor];
    _creditsField.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_creditsField];
    _pickCategory = [[UILabel alloc] init];
    _pickCategory.text = @"Pick a category for your code.";
    _pickCategory.font = [UIFont systemFontOfSize:24.0f];
    [_pickCategory sizeToFit];
    [_scrollView addSubview:_pickCategory];
    
    _categoryClothing = [[UIButton alloc] init];
    [_categoryClothing setTitle:@"Clothing" forState:UIControlStateNormal];
    [_categoryClothing setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _categoryClothing.titleLabel.textAlignment = NSTextAlignmentCenter;
    _categoryClothing.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    _categoryClothing.layer.borderWidth = 1.0f;
    _categoryClothing.layer.borderColor = [[UIColor blackColor] CGColor];
    _categoryClothing.layer.cornerRadius = 10;
    _categoryClothing.layer.masksToBounds = YES;
    [_categoryClothing sizeToFit];
    [_scrollView addSubview:_categoryClothing];
    _categoryConcerts = [[UIButton alloc] init];
    [_categoryConcerts setTitle:@"Concerts" forState:UIControlStateNormal];
    [_categoryConcerts setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _categoryConcerts.titleLabel.textAlignment = NSTextAlignmentCenter;
    _categoryConcerts.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    _categoryConcerts.layer.borderWidth = 1.0f;
    _categoryConcerts.layer.borderColor = [[UIColor blackColor] CGColor];
    _categoryConcerts.layer.cornerRadius = 10;
    _categoryConcerts.layer.masksToBounds = YES;
    [_categoryConcerts sizeToFit];
    [_scrollView addSubview:_categoryConcerts];
    _categoryFood = [[UIButton alloc] init];
    [_categoryFood setTitle:@"Food" forState:UIControlStateNormal];
    [_categoryFood setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _categoryFood.titleLabel.textAlignment = NSTextAlignmentCenter;
    _categoryFood.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    _categoryFood.layer.borderWidth = 1.0f;
    _categoryFood.layer.borderColor = [[UIColor blackColor] CGColor];
    _categoryFood.layer.cornerRadius = 10;
    _categoryFood.layer.masksToBounds = YES;
    [_categoryFood sizeToFit];
    [_scrollView addSubview:_categoryFood];
    _categoryElectronics = [[UIButton alloc] init];
    [_categoryElectronics setTitle:@"Electronics" forState:UIControlStateNormal];
    [_categoryElectronics setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _categoryElectronics.titleLabel.textAlignment = NSTextAlignmentCenter;
    _categoryElectronics.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    _categoryElectronics.layer.borderWidth = 1.0f;
    _categoryElectronics.layer.borderColor = [[UIColor blackColor] CGColor];
    _categoryElectronics.layer.cornerRadius = 10;
    _categoryElectronics.layer.masksToBounds = YES;
    [_categoryElectronics sizeToFit];
    [_scrollView addSubview:_categoryElectronics];
    
    _couponCode = [[UILabel alloc] init];
    _couponCode.text = @"Finally, what is the code?";
    _couponCode.font = [UIFont systemFontOfSize:24.0f];
    [_couponCode sizeToFit];
    [_scrollView addSubview:_couponCode];
    _codeField = [[UITextField alloc] init];
    _codeField.layer.cornerRadius = 10;
    _codeField.layer.masksToBounds = YES;
    _codeField.layer.borderWidth = 1.0f;
    _codeField.layer.borderColor = [[UIColor blackColor] CGColor];
    _codeField.backgroundColor = [UIColor whiteColor];
    _codeField.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
    [_scrollView addSubview:_codeField];
    _postIt = [[UIButton alloc] init];
    [_postIt setTitle: @"Post it!" forState: UIControlStateNormal];
    _postIt.backgroundColor = [[Util sharedManager] colorWithHexString:@"9FCBFE"];
    _postIt.titleLabel.font = [UIFont systemFontOfSize:30.0f weight:UIFontWeightMedium];
    _postIt.layer.cornerRadius = 10;
    _postIt.layer.masksToBounds = YES;
    [_scrollView addSubview:_postIt];
}

- (void)viewWillLayoutSubviews {
    self.xButton.frame = CGRectMake(20.0, 44.0 - self.xButton.frame.size.height / 2.0, self.xButton.frame.size.width, self.xButton.frame.size.height);
    self.listingTitle.frame = CGRectMake(self.view.frame.size.width / 2.0 - self.listingTitle.frame.size.width / 2.0, 44.0 - self.listingTitle.frame.size.height / 2.0, self.listingTitle.frame.size.width, self.listingTitle.frame.size.height);
    self.scrollView.frame = CGRectMake(0.0, self.listingTitle.frame.origin.y + self.listingTitle.frame.size.height + 30.0, self.view.frame.size.width, self.view.frame.size.height - (self.listingTitle.frame.origin.y + self.listingTitle.frame.size.height + 30.0));
    CGSize textSize = [self.whatStore.text sizeWithFont:self.whatStore.font
                                              constrainedToSize:CGSizeMake(self.whatStore.frame.size.width, MAXFLOAT)
                                                  lineBreakMode:self.whatStore.lineBreakMode];
    self.whatStore.frame = CGRectMake(20.0, 0.0, self.view.frame.size.width - 40.0, textSize.height);
    self.storeField.frame = CGRectMake(20, self.whatStore.frame.origin.y + self.whatStore.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 40.0);
    textSize = [self.shortTitle.text sizeWithFont:self.shortTitle.font
                               constrainedToSize:CGSizeMake(self.shortTitle.frame.size.width, MAXFLOAT)
                                   lineBreakMode:self.shortTitle.lineBreakMode];
    self.shortTitle.frame = CGRectMake(20.0, self.storeField.frame.origin.y + self.storeField.frame.size.height + 12.0, self.view.frame.size.width - 40.0, textSize.height);
    self.shortTitleField.frame = CGRectMake(20.0, self.shortTitle.frame.origin.y + self.shortTitle.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 40.0);
    self.doesItExpire.frame = CGRectMake(20.0, self.shortTitleField.frame.origin.y + self.shortTitleField.frame.size.height + 16.0, self.doesItExpire.frame.size.width, self.doesItExpire.frame.size.height);
    self.checkMark.frame = CGRectMake(self.view.frame.size.width - 108.0, self.shortTitleField.frame.origin.y + self.shortTitleField.frame.size.height + 12.0, 40.0, 40.0);
    self.xMark.frame = CGRectMake(self.checkMark.frame.origin.x + self.checkMark.frame.size.width + 8.0, self.checkMark.frame.origin.y, 40.0, 40.0);
    self.when.frame = CGRectMake(20.0, self.xMark.frame.origin.y + self.xMark.frame.size.height + 12.0, self.when.frame.size.width, self.when.frame.size.height);
    self.whenField.frame = CGRectMake(20.0, self.when.frame.origin.y + self.when.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 40.0);
    self.extraInfo.frame = CGRectMake(20.0, self.whenField.frame.origin.y + self.whenField.frame.size.height + 12.0, self.extraInfo.frame.size.width, self.extraInfo.frame.size.height);
    self.extraInfoField.frame = CGRectMake(20.0, self.extraInfo.frame.origin.y + self.extraInfo.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 40.0);
    self.creditsForCode.frame = CGRectMake(20.0, self.extraInfoField.frame.origin.y + self.extraInfoField.frame.size.height + 16.0, self.creditsForCode.frame.size.width, self.creditsForCode.frame.size.height);
    self.creditsField.frame = CGRectMake(self.view.frame.size.width - 90.0, self.extraInfoField.frame.origin.y + self.extraInfoField.frame.size.height + 12.0, 70.0, 40.0);
    self.pickCategory.frame = CGRectMake(20.0, self.creditsField.frame.origin.y + self.creditsField.frame.size.height + 12.0, self.pickCategory.frame.size.width, self.pickCategory.frame.size.height);
    
    self.categoryClothing.frame = CGRectMake(20.0, self.pickCategory.frame.origin.y + self.pickCategory.frame.size.height + 8.0, self.categoryClothing.frame.size.width + 12.0, 40.0);
    self.categoryConcerts.frame = CGRectMake(self.categoryClothing.frame.origin.x + self.categoryClothing.frame.size.width + 8.0, self.categoryClothing.frame.origin.y, self.categoryConcerts.frame.size.width + 12.0, 40.0);
    self.categoryFood.frame = CGRectMake(self.categoryConcerts.frame.origin.x + self.categoryConcerts.frame.size.width + 8.0, self.categoryConcerts.frame.origin.y, self.categoryFood.frame.size.width + 12.0, 40.0);
    self.categoryElectronics.frame = CGRectMake(20.0, self.categoryClothing.frame.origin.y + self.categoryClothing.frame.size.height + 8.0, self.categoryElectronics.frame.size.width + 12.0, 40.0);
    
    self.couponCode.frame = CGRectMake(20.0, self.categoryElectronics.frame.origin.y + self.categoryElectronics.frame.size.height + 12.0, self.couponCode.frame.size.width, self.couponCode.frame.size.height);
    self.codeField.frame = CGRectMake(20.0, self.couponCode.frame.origin.y + self.couponCode.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 40.0);
    self.postIt.frame = CGRectMake(20.0, self.codeField.frame.origin.y + self.codeField.frame.size.height + 12.0, self.view.frame.size.width - 40.0, 50.0);
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.postIt.frame.origin.y + self.postIt.frame.size.height + 12.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Listeners

- (void)tapX {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker *)self.whenField.inputView;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MM/dd/yy";
    NSString *dateString = [dateFormatter stringFromDate: picker.date];
    self.whenField.text = [NSString stringWithFormat:@"%@",dateString];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] != self.whenPickerView) {
        [self.whenField endEditing:YES];
    }
}

- (void)touchScrollView {
    [self.whenField endEditing:YES];
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
