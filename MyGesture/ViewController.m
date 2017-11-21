//
//  ViewController.m
//  MyGesture
//
//  Created by Allen on 21/11/2017.
//  Copyright © 2017 Allen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *MyLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self TapGesture];
    [self SwipGesture];
    [self PinchGesture];
    [self PanGesture];
    [self RotationGesture];
    [self LongPressGesture];
    
    self.MyLabel.userInteractionEnabled = YES;
}

#pragma mark - Pan
- (void) PanGesture {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PanAction:)];
    [self.MyLabel addGestureRecognizer:pan];
}

- (void) PanAction:(UIPanGestureRecognizer *)pan{
    // 移动的坐标值
    CGPoint translation = [pan translationInView: self.view];
    // 移动后的坐标值
    pan.view.center = CGPointMake(pan.view.center.x + translation.x, pan.view.center.y + translation.y);
    // 设置坐标和速度
    [pan setTranslation: CGPointZero inView:self.view];
    _MyLabel.text = @"移动手势";
}

#pragma mark - rotation
- (void) RotationGesture {
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(RotationAction:)];
    [self.MyLabel addGestureRecognizer:rotation];
}

- (void) RotationAction:(UIRotationGestureRecognizer *)rotationRes{
    rotationRes.view.transform = CGAffineTransformRotate(rotationRes.view.transform, rotationRes.rotation);
    rotationRes.rotation = M_PI;
    _MyLabel.text = @"正在旋转";
}

#pragma mark - LongPress
- (void) LongPressGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongPressAction:)];
    longPress.minimumPressDuration = 2;
    
    [self.view addGestureRecognizer:longPress];
}

- (void) LongPressAction:(UILongPressGestureRecognizer *)longPress{
    _MyLabel.text = @"长按手势";
}

#pragma mark - pinch
- (void) PinchGesture {
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(PinchAction:)];
    
    [self.view addGestureRecognizer:pinch];
}

- (void) PinchAction:(UIPinchGestureRecognizer *)pinch{
    float scale = pinch.scale;
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, scale, scale);
    if (scale > 1){
        _MyLabel.text = @"捏合放大";
    }
    else if (scale < 1){
        _MyLabel.text = @"捏合缩小";
    }
}

#pragma mark - swipe
- (void) SwipGesture{
    // initialze
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget: self action:@selector(SwipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipe];
}

- (void) SwipeAction:(UISwipeGestureRecognizer *)swipe{
    _MyLabel.text = @"手势向左扫";
}

#pragma mark - Tap
- (void) TapGesture {
    // ====一个手指单击====
    // initialize
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    // 添加手势
    [self.view addGestureRecognizer: tap];
    
    // ====一个手指双击====
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DoubleTap:)];
    tap2.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer: tap2];
    
    [tap requireGestureRecognizerToFail: tap2];
    
    // ====两个手指单击====
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTwoFingerTap:)];
    tap3.numberOfTapsRequired = 1;
    tap3.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer: tap3];
    
    [tap2 requireGestureRecognizerToFail: tap3];
}

- (void) SingleTap:(UITapGestureRecognizer *)tap{
    _MyLabel.text = @"响应手势单击屏幕事件";
}

- (void) DoubleTap:(UITapGestureRecognizer *)
tap{
   _MyLabel.text = @"响应手势单击屏幕事件*2";
}

- (void) SingleTwoFingerTap: (UITapGestureRecognizer *)tap{
    _MyLabel.text = @"两个手指单击事件";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
