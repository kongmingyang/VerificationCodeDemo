
//
//  VerificationCodeView.m
//  VerificationCode
//
//  Created by 55it on 2018/12/21.
//  Copyright © 2018年 55it. All rights reserved.
//

#import "VerificationCodeView.h"

@interface VerificationCodeView ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField * textView;
@property (nonatomic,copy) NSMutableArray * lables;
@property (nonatomic,copy)NSMutableArray * lines;
@property (nonatomic,strong)CABasicAnimation * opacityAnimation;
@end

@implementation VerificationCodeView

#define  WIDTH   self.frame.size.width
#define  HEIGHT  self.frame.size.height
#define   K_W    60
#define   K_H    60
#define  PADDING 2
- (instancetype)initWithFrame:(CGRect)frame WithInputNum:(NSInteger)num
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.inputNum = num;
        [self  initSubView];
    }
    
    return self;
}



-(void)initSubView{
    [self addSubview:self.textView];
    

    if (_inputNum == 4) {
        _textView.frame = CGRectMake((WIDTH - (4 * K_W) - (3 * PADDING)) / 2, 0, (4 * K_W) + (3 * PADDING), HEIGHT);
    }else{
        _textView.frame = CGRectMake(10, 0, WIDTH-20, HEIGHT);
    }
    [self.textView becomeFirstResponder];
    //初始化输入框
  
    for (int i = 0; i < self.inputNum; i++) {
        
        UIView *subView = [UIView new];
        subView.userInteractionEnabled = NO;
        float sizeW = (WIDTH - 20 - 5 * PADDING) /6;
        if (_inputNum == 4) {
            float left = (WIDTH - (4 * K_W ) - (3 * PADDING)) / 2;
            subView.frame = CGRectMake(left + (K_W+PADDING), 0, K_W, K_H);
        }else if (_inputNum == 6){
            float left = 10;
            subView.frame = CGRectMake(left + (sizeW + PADDING) * i, 0, sizeW, K_H);
        }
        [self addSubview:subView];
        UILabel *lable = [[UILabel alloc]init];
        if (_inputNum == 4) {
            lable.frame = CGRectMake(0, 0, K_W, K_H);
            
        }else{
            lable.frame = CGRectMake(0, 0,sizeW , K_H);
        }
        lable.layer.borderWidth = 1;
        lable.layer.borderColor = [UIColor grayColor].CGColor;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:38];
        lable.textColor = self.textColor;
        [subView addSubview:lable];
        
        //光标
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(K_W/2, 15, 2, K_H-30)];
        CAShapeLayer  *line = [CAShapeLayer layer];
        line.path = path.CGPath;
        line.fillColor = [[UIColor redColor]CGColor];
//       line.strokeColor = [[UIColor redColor]CGColor];
        [subView.layer addSublayer:line];
        if (i == 0) {
            [line addAnimation:[self opacityAnimation] forKey:@"kOpacityAnimation"];
            line.hidden = NO;
        }else{
            line.backgroundColor = [UIColor clearColor].CGColor;
            line.hidden = YES;
            
        }
        //把光标对象和label对象装进数组
        [self.lines addObject:line];
        [self.lables addObject:lable];
    }
    
    
}

-(void)textFieldChange:(UITextField *)textView{
    
    NSString *verStr = textView.text;
   
    if (verStr.length > self.inputNum) {
        self.textView.text = [textView.text substringToIndex:self.inputNum];
    }
    //大于等于4时结束编辑
    if (verStr.length >= self.inputNum) {
        [self.textView resignFirstResponder];
    }
    if (self.verCodeBlock) {
        self.verCodeBlock(textView.text);
    }
    for (int i = 0; i < self.lables.count; i++) {
        UILabel *bgLable = self.lables[i];
        if (i < verStr.length) {
            [self changeViewLayerIndex:i linesHidden:YES];
            bgLable.text = [verStr substringWithRange:NSMakeRange(i, 1)];
        }else{
            
            [self changeViewLayerIndex:i linesHidden:i == verStr.length ? NO : YES];
            // textView的text为空的时候
            if (!verStr && verStr.length == 0) {
                [self changeViewLayerIndex:0 linesHidden:NO];
            }
            bgLable.text = @"";
        }
        
        
    }
    
    
}
-(void)changeViewLayerIndex:(NSInteger)index linesHidden:(BOOL)hidden{
    
    UILabel *label = self.lables[index];
    [UIView animateWithDuration:0.8 animations:^{
        label.backgroundColor = hidden ? [UIColor clearColor] : [UIColor whiteColor];
        
    }];
    
    CAShapeLayer *line = self.lines[index];
    if (hidden) {
        [line removeAnimationForKey:@"kOpacityAnimation"];
    }else{
        [line addAnimation:[self opacityAnimation] forKey:@"kOpacityAnimation"];
    }
    [UIView animateWithDuration:0.25 animations:^{
        line.hidden = hidden;
    }];
}
#pragma maek -- lazy
-(CABasicAnimation *)opacityAnimation{
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1.0);
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.duration = 0.9;
    opacityAnimation.repeatCount = HUGE_VALF;
    opacityAnimation.removedOnCompletion = YES;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return opacityAnimation;
}
-(UITextField *)textView{
    
    if (!_textView) {
        _textView = [[UITextField alloc]init];
        _textView.tintColor = [UIColor clearColor];
        _textView.textColor = [UIColor clearColor];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.keyboardType = UIKeyboardTypeNamePhonePad;
        [_textView addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        _textView.autocorrectionType = UITextAutocapitalizationTypeNone;
    }
    return _textView;
    
}
-(NSMutableArray *)lables{
    if (!_lables) {    
        _lables = [NSMutableArray array];
    }
    return _lables;
}
-(NSMutableArray *)lines{
    if (!_lines) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}
@end
