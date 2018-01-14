//
//  LocationTracker.m
//  Location
//
//  Created by Dhruv Govila
//  Copyright (c) 2016 Location All rights reserved.
//

#import "LocationManager.h"
#define LATITUDE @"latitude"
#define LONGITUDE @"longitude"
#define ACCURACY @"theAccuracy"

@interface LocationTracker()

@end
static LocationTracker *locationtracker;
@implementation LocationTracker
{
    
}
@synthesize delegate;

/**
 * Global Class method to get a shared instance of the class
 */
+ (id)sharedInstance {
    if (!locationtracker) {
        locationtracker  = [[self alloc] init];
    }
    
    return locationtracker;
}


+ (CLLocationManager *)sharedLocationManager {
    static CLLocationManager *_locationManager;
    
    @synchronized(self) {
        if (_locationManager == nil) {
            _locationManager = [[CLLocationManager alloc] init];
            
            _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                
                [_locationManager requestAlwaysAuthorization];
            }
            
            if([_locationManager respondsToSelector:@selector(allowsBackgroundLocationUpdates)]){
                [_locationManager setAllowsBackgroundLocationUpdates:YES];
            }
        }
    }
    return _locationManager;
}

- (id)init {
    if (self==[super init]) {
        //Get the share model and also initialize myLocationArray
        
    }
    return self;
}

/**
 * Global Method used to start getting the Location Updates
 */
- (void)startLocationTracking {
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
        
    } else {
        CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
        
        if(authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted){
        }
        else
        {
            CLLocationManager *locationManager = [LocationTracker sharedLocationManager];
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            locationManager.distanceFilter = kCLDistanceFilterNone;
            [locationManager startUpdatingLocation];
            [locationManager startUpdatingHeading];
        }
    }
}

/**
 * Global Method used to stop getting the Location Updates
 */
- (void)stopLocationTracking
{
    CLLocationManager *locationManager = [LocationTracker sharedLocationManager];
    [locationManager stopUpdatingLocation];
    [locationManager stopUpdatingHeading];
}

#pragma mark - CLLocationManagerDelegate Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    float heading = newHeading.trueHeading;
    [self.delegate didUpdateHeadingTo:heading];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * newLocation2 = [locations objectAtIndex:0];
    CLLocationCoordinate2D theLocation2 = newLocation2.coordinate;
    [self.delegate didUpdateLocationWithLatitude:theLocation2.latitude andLongitude:theLocation2.longitude];
}


- (void)locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error
{
    switch([error code])
    {
        case kCLErrorNetwork: // general, network-related error
        {
            NSLog(@"Network Error Occured");
        }
            break;
        case kCLErrorDenied:{
            NSLog(@"Access Denied");
        }
            break;
        default:
            break;
    }
}
@end

