//
//  FISViewController.m
//  theFinalCountdown
//
//  Created by Joe Burgess on 7/9/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIView *grayBackground;
@property (strong, nonatomic) NSTimer *countdownTimer;
@property (nonatomic) NSInteger seconds;
@property (nonatomic) BOOL pauseTapped;
@property (nonatomic) NSInteger pausedTime;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pauseButton.enabled = NO;
    self.time.hidden = YES;
    self.pauseTapped = NO;
    
    self.seconds = 0;
    
    // self.timePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    // this has already been set up in the interface builder so don't need this!!

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) countdown {
    
    NSLog(@"time left in seconds: %li", self.seconds);

    [self countdownTextLabel];
    self.seconds--;
    
    if(self.seconds == 0){
        [self.countdownTimer invalidate];
        self.time.text = @"timer complete";
    }
    
}

-(void)countdownTextLabel {
    
    // self.time.text = [NSString stringWithFormat:@"%li", self.seconds];
    
    //incorporate HOURS - MINUTES - SECONDS
    
    NSInteger remainder = 0;
        
    NSInteger hours = self.seconds/3600;
    remainder = self.seconds%3600;
    NSInteger minutes = remainder/60;
    remainder = self.seconds%60;
    NSInteger seconds = remainder;
        
        self.time.text = [NSString stringWithFormat:@"%02li : %02li : %02li", hours, minutes, seconds];
        
    
    
    //    while(self.seconds > 0){
    
    //        if(self.seconds >= 3600){
    //            hours = self.seconds/3600;
    //            minutes = self.seconds%60;
    //            seconds = minutes%60;
    //        }
    //
    //        else if (self.seconds >= 60){
    //            minutes = self.seconds/60;
    //            seconds = self.seconds%60;
    //        }
    //
    //        else {
    //            seconds = self.seconds;
    //        }
    
    //        self.time.text = [NSString stringWithFormat:@"%li:%li:%li", hours, minutes, seconds];
    
}


- (IBAction)startButton:(id)sender {
    
    
    self.seconds = self.timePicker.countDownDuration;
    
    if(self.pauseTapped){
        self.seconds = self.pausedTime;
        self.pauseTapped = NO;
    }
    
    self.timePicker.hidden = YES;
    self.time.hidden = NO;
    self.pauseButton.enabled = YES;
    
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];

    
//    self.seconds--;
//    self.time.text = [NSString stringWithFormat:@"%li", self.seconds];
    //adding the above code will make the time label print at 119!! never see 120;
    
    //    NSTimeInterval timeInterval = (NSTimeInterval)self.timePicker.countDownDuration;
    //    self.seconds = timeInterval;
    //    self.time.text = [NSString stringWithFormat:@"%f", self.timePicker.countDownDuration];
}


- (IBAction)pauseButton:(id)sender {
    
    self.pauseTapped = YES;
    self.pausedTime = self.seconds;
    
    [self.countdownTimer invalidate];
    //this stops the timer completely and when you click start again, the timer is reset
    
}

@end
