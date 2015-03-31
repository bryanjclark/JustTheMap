//
//  BJCMapViewController.m
//  JustTheMap
//
//  Created by Bryan Clark on 4/4/14.
//  Copyright (c) 2014 bryanjclark. All rights reserved.
//

#import "BJCMapViewController.h"
#import <MapKit/MapKit.h>
#import <Tweaks/FBTweakInline.h>

@interface BJCMapViewController () <CLLocationManagerDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation BJCMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];


    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self updateMap];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)updateMap
{
    // Use these properties to toggle the appearance of things on your map.
    self.mapView.showsBuildings = FBTweakValue(@"Map View", @"Annotations", @"Buildings", NO);
    self.mapView.showsPointsOfInterest = FBTweakValue(@"Map View", @"Annotations", @"Points of Interest", NO);
    
    BOOL shouldShowUserLocation = FBTweakValue(@"Map View", @"Annotations", @"User Location", NO);
    if (shouldShowUserLocation) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
    }
    self.mapView.showsUserLocation = shouldShowUserLocation;

}

#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden
{
    // Return YES if you want the status bar hidden. Return NO if you'd like to see a status bar.
    BOOL showStatusBar = FBTweakValue(@"Status Bar", @"Status Bar", @"Show Status Bar", NO);
    return !showStatusBar;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    BOOL showDarkStatusBar = FBTweakValue(@"Status Bar", @"Status Bar", @"Dark Status Bar", YES);
    return showDarkStatusBar ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    } else if (status == kCLAuthorizationStatusDenied) {
        NSLog(@"Location services denied");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Not Authorized" message:@"If you want to see your location on the map, you'll need to grant access in Settings." delegate:nil cancelButtonTitle:@"D'oh!" otherButtonTitles:nil];
        alert.delegate = self;
        [alert show];
    } else {
        [self updateMap];
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //It's the not-authorized alertview, yo.
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:url];
}

@end
