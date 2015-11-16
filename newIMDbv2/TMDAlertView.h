//
//  TMDAlertView.h
//  newIMDbv2
//
//  Created by Dino Praso on 16.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const AlertViewIdentifier;

typedef enum : NSUInteger {
    DefaultAlertType,
    SuccessAlertType,
    FailureAlertType,
} AlertType;

@interface TMDAlertView : UIView {
    AlertType alertType;
}

@property (nonatomic,strong) IBOutlet UILabel* imageLabel;
@property (nonatomic,strong) IBOutlet UILabel* textLabel;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

-(void)showAlertViewWithMessage:(NSString*)message type:(AlertType)type shouldRotate:(BOOL)shouldRotate;

@end

