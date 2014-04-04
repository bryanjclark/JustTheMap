//
//  BJCMapViewController.m
//  JustTheMap
//
//  Created by Bryan Clark on 4/4/14.
//  Copyright (c) 2014 bryanjclark. All rights reserved.
//

#import "BJCMapViewController.h"
#import <MapKit/MapKit.h>

@interface BJCMapViewController ()
@property (nonatomic, strong) MKMapView *mapView;
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
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    
    // Use these properties to toggle the appearance of things on your map.
    _mapView.showsBuildings = NO;
    _mapView.showsPointsOfInterest = NO;
    _mapView.showsUserLocation = NO;
    
    [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)prefersStatusBarHidden
{
    // Return YES if you want the status bar hidden. Return NO if you'd like to see a status bar.
    return YES;
}

@end
