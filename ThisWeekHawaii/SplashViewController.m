//
//  SplashViewController.m
//  Thisweekhawai
//
//  Created by RISONGHO on 12/10/13.
//  Copyright (c) 2013 RISONGHO. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *m_imgSplash;
@end

@implementation SplashViewController

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
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([UIScreen mainScreen].bounds.size.height == 568)
            _m_imgSplash.image = [UIImage imageNamed:@"splash_5.png"];
        else
            _m_imgSplash.image = [UIImage imageNamed:@"splash.png"];
    }
    [self performSelector:@selector(goToMainVC) withObject:nil afterDelay:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) goToMainVC {
    [self performSegueWithIdentifier:@"splashtomain" sender:self];
}

@end
