JustTheMap
==========

A quick little app to get clean map screenshots

Sometimes, when you're designing an interface, you need a mapview to drop in to your screens - so you need a screenshot of a map.

Except: Maps.app displays points of interest, buildings, and other things - and it has a status bar and a few other tidbits on the map.

So, I made a suuuper tiny little universal app that works on iPhone and iPad. It just shows a big ol' map, without any status bar, points of interest, buildings, or the user's location:

![BEHOLD](http://clrk.it/image/2a1V0a3r382L/JustTheMap.png)

Of course, if you'd like to turn those annotations and UI elements back on, take a look at BJCMapViewController's viewDidLoad method:
```objectivec
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

-(BOOL)prefersStatusBarHidden
{
	// Return YES if you want the status bar hidden. Return NO if you'd like to see a status bar.
	return YES;
}
```
