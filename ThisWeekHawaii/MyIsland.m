//
//  MyLocation.m
//  Thisweekhawai
//
//  Created by RISONGHO on 12/6/13.
//  Copyright (c) 2013 RISONGHO. All rights reserved.
//

#import "MyIsland.h"

@implementation MyIsland

- (id) initWithLat:(double)lat Lng:(double)lng Radius:(double)radius URL:(NSString *)strUrl {
    self = [super init];
    if (self) {
        m_lat = lat;
        m_lng = lng;
        m_radius = radius;
        m_strUrl = strUrl;
    }
    return self;
}

- (CGFloat) calculateDistanceBetweenSource:(CLLocation *)firstCoords andDestination:(CLLocation *)secondCoords
{
    double distance = [firstCoords distanceFromLocation:secondCoords]; //meters
    distance /= 1000; // kilo meters
    distance /= 1.609344; // miles
    return distance;
}

- (BOOL) isLocationInIslandWithLat:(double)lat Lng:(double)lng {
    CGFloat distance = [self calculateDistanceBetweenSource:[[CLLocation alloc] initWithLatitude:lat longitude:lng] andDestination:[[CLLocation alloc] initWithLatitude:m_lat longitude:m_lng]];
    return distance <= m_radius;
}

- (NSString *) getUrl {
    return m_strUrl;
}

@end
