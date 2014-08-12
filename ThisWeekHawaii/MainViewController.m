//
//  MainViewController.m
//  Thisweekhawai
//
//  Created by RISONGHO on 12/6/13.
//  Copyright (c) 2013 RISONGHO. All rights reserved.
//

#import "MainViewController.h"
#import "MyIsland.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *m_webview;
@end

@implementation MainViewController

#define BASE_URL    @"http://thisweekhawaii.com/"

#define KAUAI_LAT   22.096440
#define KAUAI_LNG   -159.526124
#define KAUAI_RAD   25
#define KAUAI_URL   @"kauai/"

#define OAHU_LAT    21.438912
#define OAHU_LNG    -158.000057
#define OAHU_RAD    30
#define OAHU_URL    @"oahu/"

#define MAUI_LAT    20.798363
#define MAUI_LNG    -156.331925
#define MAUI_RAD    30
#define MAUI_URL    @"maui/"

#define BIGISLAND_LAT   19.542915
#define BIGISLAND_LNG   -155.665857
#define BIGISLAND_RAD   50
#define BIGISLAND_URL   @"big-island/"

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
	// Do any additional setup after loading the view.
    [_m_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:BASE_URL]]];

    m_locationManager = [[CLLocationManager alloc] init];
    m_locationManager.delegate = self;
    m_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    m_locationManager.distanceFilter = kCLDistanceFilterNone;
    [m_locationManager startUpdatingLocation];

    m_aryIsland = [NSMutableArray new];
    [m_aryIsland addObject:[[MyIsland alloc] initWithLat:OAHU_LAT Lng:OAHU_LNG Radius:OAHU_RAD URL:OAHU_URL]];
    [m_aryIsland addObject:[[MyIsland alloc] initWithLat:MAUI_LAT Lng:MAUI_LNG Radius:MAUI_RAD URL:MAUI_URL]];
    [m_aryIsland addObject:[[MyIsland alloc] initWithLat:BIGISLAND_LAT Lng:BIGISLAND_LNG Radius:BIGISLAND_RAD URL:BIGISLAND_URL]];
    [m_aryIsland addObject:[[MyIsland alloc] initWithLat:KAUAI_LAT Lng:KAUAI_LNG Radius:KAUAI_RAD URL:KAUAI_URL]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //if the time interval returned from core location is more than two minutes we ignore it because it might be from an old session
    if ( abs([newLocation.timestamp timeIntervalSinceDate: [NSDate date]]) < 120) {
        m_locationManager.delegate = nil;
        int i;
        MyIsland *island = nil;
        for (i = 0; i < m_aryIsland.count; i ++) {
            island = m_aryIsland[i];
            CLLocationCoordinate2D location = [newLocation coordinate];
            if ([island isLocationInIslandWithLat:location.latitude Lng:location.longitude])
                break;
        }
        NSString *strUrl = BASE_URL;
        if (i < m_aryIsland.count)
            strUrl = [strUrl stringByAppendingString:[island getUrl]];
        NSLog(@"island index = %d", i);
        [_m_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]]];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
}
@end
