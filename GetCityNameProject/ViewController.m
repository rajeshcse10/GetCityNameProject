//
//  ViewController.m
//  GetCityNameProject
//
//  Created by Rajesh's MacBook Pro  on 12/3/17.
//  Copyright © 2017 MacBook Pro Retina. All rights reserved.
//

#import "ViewController.h"
#define URL(lat,lon) [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=false&key=AIzaSyBHE7RslaK3kI9h041US0_Y9101cJcUZ_0&language=en",lat,lon];
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self getCityFromLatitude:36.106016 Longitude:128.412466];
    [self getCityName];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) getCityFromLatitude:(double) latitude Longitude:(double) longitude{
    __block NSString *cityName = nil;
    NSString *urlString = URL(latitude, longitude);
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString]completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil){
            NSError *jsonError;
            NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            NSLog(@"Your JSON Object: %@", json);
            NSArray *resultList = (NSArray *) [json objectForKey:@"results"];
            if(resultList.count > 0){
                NSDictionary *dict = [resultList objectAtIndex:0];
                NSArray *addressCompList = [dict objectForKey:@"address_components"];
                if(addressCompList.count > 2){
                    cityName = [[addressCompList objectAtIndex:2] objectForKey:@"long_name"];
                }
            }
            
        }
        if(cityName == nil){
            NSLog(@"NO CITY NAME FOUND");
        }
        else{
            NSLog(@"CityName : %@",cityName);
        }
    }] resume];
}
-(void)getCityName{
    NSString *cityName = nil;
    NSString *urlString = URL(36.106016,128.412466);
    NSError *error;
    NSStringEncoding encoding;
    NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] usedEncoding:&encoding error:&error];
    if(error == nil){
        NSData *data = [locationString dataUsingEncoding:encoding];
        if(data != nil){
            NSError *error;
            NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:
                                                  NSJSONReadingMutableContainers error:&error];
            NSLog(@"Your JSON Object: %@", json);
            NSArray *resultList = (NSArray *) [json objectForKey:@"results"];
            if(resultList.count > 0){
                NSDictionary *dict = [resultList objectAtIndex:0];
                NSArray *addressCompList = [dict objectForKey:@"address_components"];
                if(addressCompList.count > 2){
                    cityName = [[addressCompList objectAtIndex:2] objectForKey:@"long_name"];
                }
            }
        }
    }
    if(cityName == nil){
        NSLog(@"NO CITY NAME FOUND");
    }
    else{
        NSLog(@"CityName : %@",cityName);
    }

}
@end
