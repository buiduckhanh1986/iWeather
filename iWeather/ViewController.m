//
//  ViewController.m
//  iWeather
//
//  Created by Bui Duc Khanh on 6/15/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnTemperature;
@property (weak, nonatomic) IBOutlet UILabel *lblTemperatureType;
@property (weak, nonatomic) IBOutlet UIImageView *imgWeather;
@property (weak, nonatomic) IBOutlet UILabel *lblMotto;

@end

@implementation ViewController
{
    NSArray* mottos;
    NSArray* locations;
    NSArray* iconWeathers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // Generate data
    mottos = @[@"Trên con đường thành công không có dấu chân kẻ lười biếng"
               , @"Có công mài sắt có ngày nên kim"
               , @"Học học nữa học mãi"
               , @"Đi một ngày đàng học một sàng khôn"
               , @"Ngủ dậy muộn thì phí cả ngày, tuổi thanh niên không học tập thì phí mất cả cuộc đời"];
    
    locations = @[@"Ha Noi, Viet Nam"
               , @"TP.HCM, Viet Nam"
               , @"Quang Ninh, Viet Nam"
               , @"Hue, Viet Nam"
               , @"Da Nang, Viet Nam"];
    
    iconWeathers = @[@"Cold"
                  , @"Rain"
                  , @"Sunny"
                  , @"Shower"
                  , @"Thunder"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Change temperature type
- (IBAction)onBtnTemperatureTouchUpInside:(id)sender {
    float temperature = [_btnTemperature.titleLabel.text floatValue];
    
    if ([self.lblTemperatureType.text isEqualToString:@"C"]){
        temperature = temperature*1.8 + 32;
        
        self.lblTemperatureType.text = @"F";
    }
    else{
        temperature = (temperature-32)/1.8;
        
        self.lblTemperatureType.text = @"C";
    }
    
    [_btnTemperature setTitle:[NSString stringWithFormat:@"%.1f", temperature] forState:UIControlStateNormal];
    
}

// Update Weather information by random generate data
- (IBAction)onBtnUpdateTouchUpInside:(id)sender {
    float temperature = [self generateTemperature];
    
    NSString* temperatureLabel = [NSString stringWithFormat:@"%2.1f", temperature];
    [_btnTemperature setTitle:temperatureLabel forState:UIControlStateNormal];
    
    
    // Check temperature and set icon
    if(temperature < 10){
        [self.imgWeather setImage:[UIImage imageNamed:@"Cold"]];
    }
    else if(temperature < 15){
        [self.imgWeather setImage:[UIImage imageNamed:@"Thunder"]];
    }
    else if(temperature < 20){
        [self.imgWeather setImage:[UIImage imageNamed:@"Rain"]];
    }
    else if(temperature < 25){
        [self.imgWeather setImage:[UIImage imageNamed:@"Shower"]];
    }
    else
        [self.imgWeather setImage:[UIImage imageNamed:@"Sunny"]];
    
    
    // Location
    int locationIndex = arc4random_uniform((u_int32_t)locations.count);
    
    self.lblLocation.text = locations[locationIndex];
    
    
    // Motto
    int mottoIndex = arc4random_uniform((u_int32_t)mottos.count);
    
    self.lblMotto.text = mottos[mottoIndex];
        
    
}

- (float) generateTemperature{
    return arc4random_uniform(40) + (float)arc4random()/(float)INT32_MAX;
}

@end
