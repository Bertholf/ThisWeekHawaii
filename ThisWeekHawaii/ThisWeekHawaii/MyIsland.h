//
//  MyLocation.h
//  Thisweekhawai
//
//  Created by RISONGHO on 12/6/13.
//  Copyright (c) 2013 RISONGHO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyIsland : NSObject {
    double m_lat;
    double m_lng;
    double m_radius; // miles
    NSString *m_strUrl;
}

- (NSString *)getUrl;
- (id) initWithLat:(double)lat Lng:(double)lng Radius:(double)radius URL:(NSString *) strUrl;
- (BOOL) isLocationInIslandWithLat:(double)lat Lng:(double)lng;

@end
