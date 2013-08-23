//
//  TraktrTabBarController.m
//  Traktr for iPhone
//
//  Created by Atharv Vaish on 8/23/13.
//  Copyright (c) 2013 Atharv Vaish. All rights reserved.
//

#import "TraktrTabBarController.h"

@interface TraktrTabBarController ()

@end

@implementation TraktrTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  if (standardUserDefaults) {
    [standardUserDefaults setObject:@"f3e95f55151b1dda8fe286d9da6feca5"
                             forKey:@"apikey"];
    [standardUserDefaults synchronize];
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
