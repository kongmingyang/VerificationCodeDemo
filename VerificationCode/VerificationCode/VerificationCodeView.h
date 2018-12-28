//
//  VerificationCodeView.h
//  VerificationCode
//
//  Created by 55it on 2018/12/21.
//  Copyright © 2018年 55it. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerificationCodeView : UIView
@property (nonatomic,strong) UIColor * lineColor;
@property (nonatomic,strong) UIColor * textColor;
// 输入框数量
@property (nonatomic,assign) NSInteger  inputNum;
//回调
@property (nonatomic,copy)  void (^verCodeBlock)(NSString *verCode);
//初始化
- (instancetype)initWithFrame:(CGRect)frame WithInputNum:(NSInteger)num;
@end

NS_ASSUME_NONNULL_END
