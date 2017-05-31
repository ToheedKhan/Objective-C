//
//  BMWLocationDetailViewController.m
//  BMWTask
//
//  Created by Toheed Khan on 26/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "BMWLocationDetailViewController.h"
#import "BMWLocation.h"
#import "BMWLocationService.h"
#import "NSDate+BMWExtension.h"

@import MapKit;

@interface BMWLocationDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *  locantionName;
@property (weak, nonatomic) IBOutlet UILabel *  distance;
@property (weak, nonatomic) IBOutlet UILabel *  address;
@property (weak, nonatomic) IBOutlet UILabel *  arrivalTime;
@property (weak, nonatomic) IBOutlet MKMapView *locationMapView;


//@property (strong, nonatomic) BMWLocation *   selectedBMWLocation;

@end

@implementation BMWLocationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    self.locantionName.text = self.selectedBMWLocation.name;
    self.address.text = self.selectedBMWLocation.address;
    self.arrivalTime.text = [NSDate dateStringFromDateInDefaultTimeZone:self.selectedBMWLocation.arrivalTime];
    
    CLLocationDistance distance = [[[BMWLocationService sharedInstance] currentLocation] distanceFromLocation:[[CLLocation alloc] initWithLatitude:self.selectedBMWLocation.latitude longitude:self.selectedBMWLocation.longitude]];
    
    self.distance.text = [NSString stringWithFormat:@"%.2f meters", distance];
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{   //Calculate distance when user location changes.
    CLLocationDistance distance = [userLocation.location distanceFromLocation:[[CLLocation alloc] initWithLatitude:self.selectedBMWLocation.latitude longitude:self.selectedBMWLocation.longitude]];
    
    self.distance.text = [NSString stringWithFormat:@"%.2f meters", distance];

}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        self.locationMapView.showsUserLocation = YES;
        
    }
    
    CLLocationCoordinate2D coord = {.latitude = self.selectedBMWLocation.latitude, .longitude =  self.selectedBMWLocation.longitude};
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 800, 800);
//        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([[BMWLocationService sharedInstance] currentLocation].coordinate, 800, 800);
    
    [self.locationMapView setRegion:[self.locationMapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coord;
    point.title = self.selectedBMWLocation.address;
    //    point.subtitle = @"";
    [self.locationMapView addAnnotation:point];
    
}

@end
