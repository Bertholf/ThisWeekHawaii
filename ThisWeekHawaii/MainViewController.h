//
//  MainViewController.h
//  Thisweekhawai
//
//  Created by RISONGHO on 12/6/13.
//  Copyright (c) 2013 RISONGHO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MainViewController : UIViewController<CLLocationManagerDelegate> {
    CLLocationManager *m_locationManager;
    NSMutableArray *m_aryIsland;
}

@end
