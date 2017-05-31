//
//  BMWLocationViewControllerTests.m
//  BMWTask
//
//  Created by Toheed Khan on 27/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BMWLocationViewController.h"
#import "BMWGlobalConstants.h"
#import "BMWLocation.h"
#import "BMWUtility.h"
#import "BMWLocationService.h"

@interface BMWLocationViewControllerTests : XCTestCase

@property (nonatomic) BMWLocationViewController *bmwLocationVC;

@end

@interface BMWLocationViewController (Test)

@property (strong, nonatomic) NSArray *                locations;
@property (assign, nonatomic) BMWLocationSortingOption bmwLocationSortingOption;
@property (weak, nonatomic) IBOutlet UITableView *     locationsTableView;

- (void)sortLocations;

@end

@interface BMWLocationService (Test)
@property (strong, nonatomic, readwrite) CLLocation *        currentLocation;

@end

@implementation BMWLocationViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.bmwLocationVC = [[BMWLocationViewController alloc] init];

    [self loadLocationData];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)loadLocationData {
    NSBundle *myBundle = [NSBundle bundleForClass: [self class]];
    NSString *fileName = [myBundle pathForResource:@"locationResponse" ofType:@"json"];
    
   // NSString *fileName = [[NSBundle mainBundle] pathForResource:@"locationResponse" ofType:@"json"];

    NSMutableData *data = [[NSMutableData alloc]initWithContentsOfFile:fileName];
    
    NSArray *locationsArr = [BMWUtility parseJSONData:data];
    
    NSMutableArray * bmwLocations = [[NSMutableArray alloc] init];
    
    __block BMWLocation *bmwLocation;
    [locationsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        bmwLocation = [[BMWLocation alloc] initLocationWithDictionary:obj];
        
        [bmwLocations addObject:bmwLocation];
    }];
    XCTestExpectation
    self.bmwLocationVC.locations = bmwLocations;
}

- (void)testSortLocationsForSortByName {
    self.bmwLocationVC.bmwLocationSortingOption = BMWLocationSortingOptionName;
    
    BMWLocation *expectedFirstLocationAfterSorting = self.bmwLocationVC.locations[3];
    
    [self.bmwLocationVC sortLocations];

    XCTAssertEqualObjects(expectedFirstLocationAfterSorting, self.bmwLocationVC.locations[0], @"Location objects did not match after sorting by name");
}

- (void)testSortLocationsForSortByArrivalTime {
    self.bmwLocationVC.bmwLocationSortingOption = BMWLocationSortingOptionArrivalTime;
    
    BMWLocation *expectedLastLocationAfterSorting = self.bmwLocationVC.locations[2];
    
    [self.bmwLocationVC sortLocations];
    
    XCTAssertEqualObjects(expectedLastLocationAfterSorting, self.bmwLocationVC.locations[4], @"Location objects did not match after sorting by arrivalTime");
}

- (void)testSortLocationsForSortByDistance {
    self.bmwLocationVC.bmwLocationSortingOption = BMWLocationSortingOptionDistance;
    
    [BMWLocationService sharedInstance].currentLocation = [[CLLocation alloc] initWithLatitude:41.0000 longitude:87.0000];
    
    BMWLocation *expectedLastLocationAfterSorting = self.bmwLocationVC.locations[0];
    
    [self.bmwLocationVC sortLocations];
    
    XCTAssertEqualObjects(expectedLastLocationAfterSorting, self.bmwLocationVC.locations[4], @"Location objects did not match after sorting by distance");
}

- (void)testPerformanceSortLocationsForSortByName
{
    self.bmwLocationVC.bmwLocationSortingOption = BMWLocationSortingOptionName;
    [self measureBlock:^{
        [self.bmwLocationVC sortLocations];
    }];
}

- (void)testPerformanceSortLocationsForSortByArrivalTime
{
    self.bmwLocationVC.bmwLocationSortingOption = BMWLocationSortingOptionArrivalTime;
    [self measureBlock:^{
        [self.bmwLocationVC sortLocations];
    }];
}

- (void)testPerformanceSortLocationsForSortByDistance
{
    self.bmwLocationVC.bmwLocationSortingOption = BMWLocationSortingOptionDistance;
    [self measureBlock:^{
        [self.bmwLocationVC sortLocations];
    }];
}

#pragma mark - UITableView tests
- (void)testThatViewConformsToUITableViewDataSource
{
    XCTAssertTrue([self.bmwLocationVC conformsToProtocol:@protocol(UITableViewDataSource) ], @"BMWLocationViewController does not conform to UITableView datasource protocol");
}

@end
