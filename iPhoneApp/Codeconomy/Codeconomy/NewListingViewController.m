//
//  NewListingViewController.m
//  Codeconomy
//
//  Created by studio on 2/15/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

#import "NewListingViewController.h"
#import "Coupon.h"
#import "Util.h"

@interface NewListingViewController () <UITextFieldDelegate>
@property (nonatomic, strong) User *user;

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
@property (nonatomic, strong) UIButton *selectedExpire;
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
@property (nonatomic, strong) UIButton *selectedCategory;

@property (nonatomic, strong) UILabel *couponCode;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UIButton *postIt;

@property (nonatomic, strong) UITapGestureRecognizer *scrollViewTap;

@end

@implementation NewListingViewController

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        _user = user;
    }
    return self;
}

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
    _storeField.delegate = self;
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
    _shortTitleField.delegate = self;
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
    [_checkMark addTarget:self action:@selector(tapExpire:) forControlEvents:UIControlEventTouchUpInside];
    _checkMark.titleLabel.textAlignment = NSTextAlignmentCenter;
    _checkMark.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    _checkMark.layer.borderWidth = 6.0f;
    _checkMark.layer.borderColor = [[UIColor blackColor] CGColor];
    _checkMark.layer.opacity = 0.33;
    _checkMark.layer.cornerRadius = 10;
    _checkMark.layer.masksToBounds = YES;
    [_scrollView addSubview:_checkMark];
    _xMark = [[UIButton alloc] init];
    [_xMark setTitle:@"✕" forState:UIControlStateNormal];
    [_xMark setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_xMark addTarget:self action:@selector(tapExpire:) forControlEvents:UIControlEventTouchUpInside];
    _xMark.titleLabel.textAlignment = NSTextAlignmentCenter;
    _xMark.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    _xMark.layer.borderWidth = 6.0f;
    _xMark.layer.borderColor = [[UIColor blackColor] CGColor];
    _xMark.layer.opacity = 0.33;
    _xMark.layer.cornerRadius = 10;
    _xMark.layer.masksToBounds = YES;
    [_scrollView addSubview:_xMark];
    _when = [[UILabel alloc] init];
    _when.text = @"When?";
    _when.font = [UIFont systemFontOfSize:24.0f];
    [_when sizeToFit];
    [_scrollView addSubview:_when];
    _whenField = [[UITextField alloc] init];
    _whenField.delegate = self;
    _whenField.layer.cornerRadius = 10;
    _whenField.layer.masksToBounds = YES;
    _whenField.layer.borderWidth = 1.0f;
    _whenField.layer.borderColor = [[UIColor blackColor] CGColor];
    _whenField.backgroundColor = [UIColor whiteColor];
    _whenField.layer.sublayerTransform = CATransform3DMakeTranslation(12.0, 0, 0);
    [_scrollView addSubview:_whenField];
    _whenPickerView = [[UIDatePicker alloc] init];
    _whenPickerView.datePickerMode = UIDatePickerModeDate;
    _whenPickerView.minimumDate = [NSDate date];
    _whenField.inputView = _whenPickerView;
    [_whenPickerView addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    _extraInfo = [[UILabel alloc] init];
    _extraInfo.text = @"Any more information?";
    _extraInfo.font = [UIFont systemFontOfSize:24.0f];
    [_extraInfo sizeToFit];
    [_scrollView addSubview:_extraInfo];
    _extraInfoField = [[UITextField alloc] init];
    _extraInfoField.delegate = self;
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
    _creditsField.delegate = self;
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
    [_categoryClothing addTarget:self action:@selector(tapCategory:) forControlEvents:UIControlEventTouchUpInside];
    _categoryClothing.titleLabel.textAlignment = NSTextAlignmentCenter;
    _categoryClothing.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    _categoryClothing.layer.borderWidth = 1.0f;
    _categoryClothing.layer.borderColor = [[UIColor blackColor] CGColor];
    _categoryClothing.layer.cornerRadius = 10;
    _categoryClothing.layer.masksToBounds = YES;
    _categoryClothing.layer.opacity = 0.33;
    [_categoryClothing sizeToFit];
    [_scrollView addSubview:_categoryClothing];
    _categoryConcerts = [[UIButton alloc] init];
    [_categoryConcerts setTitle:@"Concerts" forState:UIControlStateNormal];
    [_categoryConcerts setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_categoryConcerts addTarget:self action:@selector(tapCategory:) forControlEvents:UIControlEventTouchUpInside];
    _categoryConcerts.titleLabel.textAlignment = NSTextAlignmentCenter;
    _categoryConcerts.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    _categoryConcerts.layer.borderWidth = 1.0f;
    _categoryConcerts.layer.borderColor = [[UIColor blackColor] CGColor];
    _categoryConcerts.layer.cornerRadius = 10;
    _categoryConcerts.layer.masksToBounds = YES;
    _categoryConcerts.layer.opacity = 0.33;
    [_categoryConcerts sizeToFit];
    [_scrollView addSubview:_categoryConcerts];
    _categoryFood = [[UIButton alloc] init];
    [_categoryFood setTitle:@"Food" forState:UIControlStateNormal];
    [_categoryFood setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_categoryFood addTarget:self action:@selector(tapCategory:) forControlEvents:UIControlEventTouchUpInside];
    _categoryFood.titleLabel.textAlignment = NSTextAlignmentCenter;
    _categoryFood.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    _categoryFood.layer.borderWidth = 1.0f;
    _categoryFood.layer.borderColor = [[UIColor blackColor] CGColor];
    _categoryFood.layer.cornerRadius = 10;
    _categoryFood.layer.masksToBounds = YES;
    _categoryFood.layer.opacity = 0.33;
    [_categoryFood sizeToFit];
    [_scrollView addSubview:_categoryFood];
    _categoryElectronics = [[UIButton alloc] init];
    [_categoryElectronics setTitle:@"Electronics" forState:UIControlStateNormal];
    [_categoryElectronics addTarget:self action:@selector(tapCategory:) forControlEvents:UIControlEventTouchUpInside];
    [_categoryElectronics setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _categoryElectronics.titleLabel.textAlignment = NSTextAlignmentCenter;
    _categoryElectronics.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    _categoryElectronics.layer.borderWidth = 1.0f;
    _categoryElectronics.layer.borderColor = [[UIColor blackColor] CGColor];
    _categoryElectronics.layer.cornerRadius = 10;
    _categoryElectronics.layer.masksToBounds = YES;
    _categoryElectronics.layer.opacity = 0.33;
    [_categoryElectronics sizeToFit];
    [_scrollView addSubview:_categoryElectronics];
    
    _couponCode = [[UILabel alloc] init];
    _couponCode.text = @"Finally, what is the code?";
    _couponCode.font = [UIFont systemFontOfSize:24.0f];
    [_couponCode sizeToFit];
    [_scrollView addSubview:_couponCode];
    _codeField = [[UITextField alloc] init];
    _codeField.delegate = self;
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
    [_postIt addTarget:self action:@selector(tapPostIt:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_postIt];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self.scrollView addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillLayoutSubviews {
    self.xButton.frame = CGRectMake(20.0, 44.0 - self.xButton.frame.size.height / 2.0, self.xButton.frame.size.width, self.xButton.frame.size.height);
    self.listingTitle.frame = CGRectMake(self.view.frame.size.width / 2.0 - self.listingTitle.frame.size.width / 2.0, 44.0 - self.listingTitle.frame.size.height / 2.0, self.listingTitle.frame.size.width, self.listingTitle.frame.size.height);
    self.scrollView.frame = CGRectMake(0.0, self.listingTitle.frame.origin.y + self.listingTitle.frame.size.height + 15.0, self.view.frame.size.width, self.view.frame.size.height - (self.listingTitle.frame.origin.y + self.listingTitle.frame.size.height + 30.0));
    CGSize textSize = [self.whatStore.text boundingRectWithSize:CGSizeMake(self.whatStore.frame.size.width, MAXFLOAT)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName:self.whatStore.font}
                                                              context:nil].size;
    self.whatStore.frame = CGRectMake(20.0, 0.0, self.view.frame.size.width - 40.0, textSize.height);
    self.storeField.frame = CGRectMake(20, self.whatStore.frame.origin.y + self.whatStore.frame.size.height + 8.0, self.view.frame.size.width - 40.0, 40.0);
    textSize = [self.shortTitle.text boundingRectWithSize:CGSizeMake(self.shortTitle.frame.size.width, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:self.shortTitle.font}
                                                 context:nil].size;
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

#pragma mark - UITextFieldDelegate

- (bool)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.creditsField) {
        NSCharacterSet *cs = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    } else {
        return true;
    }
}

- (bool)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.storeField) {
        [self.shortTitleField becomeFirstResponder];
    } else if (textField == self.shortTitleField) {
        [textField resignFirstResponder];
    } else if (textField == self.extraInfoField) {
        [self.creditsField becomeFirstResponder];
    } else if (textField == self.creditsField) {
        [self.codeField becomeFirstResponder];
    } else if (textField == self.codeField) {
        [textField resignFirstResponder];
    }
    
    return false;
}

#pragma mark - Helpers

- (NSMutableArray *)getMissingFields {
    NSString *store = self.storeField.text;
    NSString *shortTitle = self.shortTitleField.text;
    BOOL expiresChosen = (self.selectedExpire != nil);
    BOOL expires = (self.selectedExpire == self.checkMark);
    NSDate *expirationDate = nil;
    if (expires) {
        expirationDate = self.whenPickerView.date;
    }
    NSString *credits = self.creditsField.text;
    BOOL categorySelected = (self.selectedCategory != nil);
    NSString *code = self.codeField.text;
    NSMutableArray *missingFields = [[NSMutableArray alloc] init];
    
    if (store.length == 0) {
        [missingFields addObject:@"store/event name"];
    }
    if (shortTitle.length == 0) {
        [missingFields addObject:@"short title"];
    }
    if (!expiresChosen) {
        [missingFields addObject:@"expiration date"];
    } else if (expires && expirationDate == nil) {
        [missingFields addObject:@"expiration date"];
    }
    if (credits.length == 0) {
        [missingFields addObject:@"price"];
    }
    if (!categorySelected) {
        [missingFields addObject:@"category"];
    }
    if (code.length == 0) {
        [missingFields addObject:@"code"];
    }
    return missingFields;
}

#pragma mark - Listeners

- (void)tapX {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapPostIt:(UIButton *)sender {
    NSMutableArray *missingFields = [self getMissingFields];
    if (missingFields.count > 0) {
        NSMutableString *message = [[NSMutableString alloc] initWithString:@"You are missing some fields! Please fix the following fields before proceeding:\n"];
        for (NSString *field in missingFields) {
            [message appendString:[NSString stringWithFormat:@"- %@\n", field]];
        }
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"New Listing"
                                                                       message:[message substringToIndex:message.length - 1]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {}];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        NSString *category = @"Clothing";
        if (self.selectedCategory == self.categoryConcerts) {
            category = @"Concerts";
        } else if (self.selectedCategory == self.categoryFood) {
            category = @"Food";
        } else if (self.selectedCategory == self.categoryElectronics) {
            category = @"Electronics";
        }
        NSDate *expirationDate = self.whenPickerView.date;
        if (self.selectedExpire == self.xMark) {
            expirationDate = NULL;
        }
        
        Coupon *coupon1 = [[Coupon alloc] initWithSeller:_user
                                                    status:1
                                                     price:[self.creditsField.text intValue]
                                            expirationDate:expirationDate
                                                 storeName:self.storeField.text
                                         couponDescription:self.shortTitleField.text
                                            additionalInfo:self.extraInfoField.text
                                                      code:self.codeField.text
                                                  category:category
                                                   deleted:0];
        [coupon1 saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (!succeeded) {
                NSLog(@"%@", error);
            }
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker *)self.whenField.inputView;
    picker.datePickerMode = UIDatePickerModeDateAndTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"M/d/yy 'at' h:mm a";
    NSString *dateString = [dateFormatter stringFromDate: picker.date];
    self.whenField.text = [NSString stringWithFormat:@"%@", dateString];
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

- (void)tapExpire:(UIButton *)sender {
    if (sender == self.xMark) {
        self.xMark.layer.opacity = 1.0;
        self.checkMark.layer.opacity = 0.33;
        self.selectedExpire = self.xMark;
    } else {
        self.checkMark.layer.opacity = 1.0;
        self.xMark.layer.opacity = 0.33;
        self.selectedExpire = self.checkMark;
    }
}

- (void)tapCategory:(UIButton *)sender {
    if (sender == self.categoryClothing) {
        self.categoryClothing.layer.opacity = 1.0;
        self.categoryClothing.backgroundColor = [[Util sharedManager] colorWithHexString:@"9FCBFE"];
        self.categoryConcerts.layer.opacity = 0.33;
        self.categoryConcerts.backgroundColor = [UIColor clearColor];
        self.categoryFood.layer.opacity = 0.33;
        self.categoryFood.backgroundColor = [UIColor clearColor];
        self.categoryElectronics.layer.opacity = 0.33;
        self.categoryElectronics.backgroundColor = [UIColor clearColor];
        self.selectedCategory = self.categoryClothing;
    } else if (sender == self.categoryConcerts) {
        self.categoryConcerts.layer.opacity = 1.0;
        self.categoryConcerts.backgroundColor = [[Util sharedManager] colorWithHexString:@"9FCBFE"];
        self.categoryClothing.layer.opacity = 0.33;
        self.categoryClothing.backgroundColor = [UIColor clearColor];
        self.categoryFood.layer.opacity = 0.33;
        self.categoryFood.backgroundColor = [UIColor clearColor];
        self.categoryElectronics.layer.opacity = 0.33;
        self.categoryElectronics.backgroundColor = [UIColor clearColor];
        self.selectedCategory = self.categoryConcerts;
    } else if (sender == self.categoryFood) {
        self.categoryFood.layer.opacity = 1.0;
        self.categoryFood.backgroundColor = [[Util sharedManager] colorWithHexString:@"9FCBFE"];
        self.categoryConcerts.layer.opacity = 0.33;
        self.categoryConcerts.backgroundColor = [UIColor clearColor];
        self.categoryClothing.layer.opacity = 0.33;
        self.categoryClothing.backgroundColor = [UIColor clearColor];
        self.categoryElectronics.layer.opacity = 0.33;
        self.categoryElectronics.backgroundColor = [UIColor clearColor];
        self.selectedCategory = self.categoryFood;
    } else {
        self.categoryElectronics.layer.opacity = 1.0;
        self.categoryElectronics.backgroundColor = [[Util sharedManager] colorWithHexString:@"9FCBFE"];
        self.categoryConcerts.layer.opacity = 0.33;
        self.categoryConcerts.backgroundColor = [UIColor clearColor];
        self.categoryFood.layer.opacity = 0.33;
        self.categoryFood.backgroundColor = [UIColor clearColor];
        self.categoryClothing.layer.opacity = 0.33;
        self.categoryClothing.backgroundColor = [UIColor clearColor];
        self.selectedCategory = self.categoryElectronics;
    }
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.codeField.isEditing) {
        CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = -keyboardSize.height;
            self.view.frame = f;
        }];
    }
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
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
