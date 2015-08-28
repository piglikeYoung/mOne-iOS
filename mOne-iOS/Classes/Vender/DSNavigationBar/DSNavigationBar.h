//
//  DSNavigationBar.h
//  DSTranparentNavigationBar
//
//  Created by Diego Serrano on 10/13/14.
//  Copyright (c) 2014 Diego Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DSNavigationBar : UINavigationBar

@property (strong, nonatomic) UIColor *color;

-(void)setNavigationBarWithColor:(UIColor *)color;
-(void)setNavigationBarWithColors:(NSArray *)colours;

@end
