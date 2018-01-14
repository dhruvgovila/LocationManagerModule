//
//  LocationTracker.h
//  Location
//
//  Created by Dhruv Govila
//  Copyright (c) 2016 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationTrackerDelegates
@required
-(void)didUpdateLocationWithLatitude:(float)latitude andLongitude:(float)longitude;
-(void)didUpdateHeadingTo:(float)heading;
@end

@interface LocationTracker : NSObject <CLLocationManagerDelegate>

@property (strong,nonatomic) id <LocationTrackerDelegates> delegate;

@property(nonatomic,strong)CLLocation *lastLocaiton;
@property (nonatomic) CLLocationCoordinate2D myLastLocation;
@property (nonatomic) CLLocationAccuracy myLastLocationAccuracy;
@property (nonatomic) CLLocationCoordinate2D myLocation;
@property (nonatomic) CLLocationAccuracy myLocationAccuracy;
@property(nonatomic,assign) BOOL isMannualBooking;

+ (CLLocationManager *)sharedLocationManager;
+ (id)sharedInstance;
- (void)startLocationTracking;
- (void)stopLocationTracking;
@end


