//
//  TMDAlertView.m
//  newIMDbv2
//
//  Created by Dino Praso on 16.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

#import "TMDAlertView.h"

NSString *const AlertViewIdentifier = @"AlertView";

@implementation TMDAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:70 green:166 blue:324 alpha:0.6];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]);
    return self;
}

-(void)showAlertViewWithMessage:(NSString*)message type:(AlertType)type shouldRotate:(BOOL)shouldRotate{
    _textLabel.text = message;
    _textLabel.minimumScaleFactor = 0.5;
    _textLabel.adjustsFontSizeToFitWidth = YES;
    alertType = type;
    _imageLabel.text = @"Test Message";
    //_imageLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:self.iconCodeForAlertType attributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont fontWithName:@"FontAwesome" size:35],@"font", nil]];
    _backgroundView.alpha = 0.9;
    _backgroundView.backgroundColor = self.colorForAlertType;
    if(shouldRotate){
        [self startRotation];
    } else {
        [self stopRotation];
    }
    if(type != 0){
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(dismiss)];
        [self addGestureRecognizer:singleFingerTap];
    }
    
    UIWindow* mainWindow = (([UIApplication sharedApplication].delegate).window);
    self.frame = mainWindow.frame;
    [mainWindow addSubview:self];
}

-(UIColor*)colorForAlertType{
    UIColor *alertColor;
    switch (alertType) {
        case DefaultAlertType:
            alertColor = [UIColor blueColor];
            break;
        case SuccessAlertType:
            alertColor = [UIColor greenColor];
            break;
        case FailureAlertType:
            alertColor = [UIColor redColor];
            break;
    }
    return alertColor;
}

-(NSString*)iconCodeForAlertType{
    NSString *iconCode;
    switch (alertType) {
        case DefaultAlertType:
            iconCode = @"\uf110";
            break;
        case SuccessAlertType:
            iconCode = @"\uf058";
            break;
        case FailureAlertType:
            iconCode = @"\uf071";
            break;
    }
    return iconCode;
}

- (void)startRotation{
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    rotation.duration = 1.5f; // Speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [_imageLabel.layer removeAllAnimations];
    [_imageLabel.layer addAnimation:rotation forKey:@"Spin"];
}

-(void)stopRotation{
    [_imageLabel.layer removeAllAnimations];
}

-(void)dismiss{
    [self removeFromSuperview];
}

@end
