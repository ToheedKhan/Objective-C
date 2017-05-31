//
//  BMWLocationViewController.m
//  BMWTask
//
//  Created by Toheed Khan on 25/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "BMWLocationViewController.h"
#import "BMWLocationManager.h"
#import "BMWGlobalConstants.h"
#import "BMWLocationDetailViewController.h"
#import "BMWLocationService.h"
#import "NSDate+BMWExtension.h"
#import "BMWLocation.h"
#import "BMWLoadingView.h"
#import "BMWLoadingView.h"

@interface BMWLocationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *                locations;
@property (assign, nonatomic) BMWLocationSortingOption bmwLocationSortingOption;
@property (strong, nonatomic) BMWLoadingView *         loadingView;
@property (weak, nonatomic) IBOutlet UITableView *     locationsTableView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem * defaultSelectedBarButton;
@property (weak, nonatomic) UIBarButtonItem *          currentSelectedBarButton;

@end

@implementation BMWLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.bmwLocationSortingOption = BMWLocationSortingOptionName;
    
    [self setupUI];
    [self setupLocationUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)unregisterForChangeNotification {
    @try {
      [[BMWLocationService sharedInstance] removeObserver:self forKeyPath:@"currentLocation"];
    }
    @catch (NSException * __unused exception) {}

}

- (void)dealloc {
    [self unregisterForChangeNotification];
}

#pragma mark - Helper
- (void)setupLocationUpdates {
    [[BMWLocationService sharedInstance] addObserver:self forKeyPath:@"currentLocation" options:NSKeyValueObservingOptionNew context:nil];
    [[BMWLocationService sharedInstance] startUpdatingLocation];
 
}

- (void)refresh {
    double delayInSeconds = 0.3;
    
    __weak BMWLocationViewController *weakSelf = self;

    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [[BMWLocationManager sharedInstance] fetchNearByLocationsWithCompletionHandler:^(NSArray *locations, NSError *error) {
            weakSelf.locations = locations;
            
            if (locations.count) {

                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:2.0
                                          delay:2.0
                                        options: UIViewAnimationOptionCurveEaseInOut
                                     animations:^{
                                         [self.loadingView hideLoadingView];
                                         
                                     }
                                     completion:^(BOOL finished){
                                         [self.loadingView removeFromSuperview];
                                     }];

//                    [weakSelf.locationsTableView reloadData];
                    [weakSelf sortLocations];
                });
            }
        }];
    });
}

- (void)setupUI {
    
    self.loadingView = [[BMWLoadingView alloc] initBMWLoadingView];
    self.loadingView.center = self.view.center;
    [self.view addSubview:self.loadingView];
    [self.loadingView showLoadingView];
    
    self.currentSelectedBarButton = self.defaultSelectedBarButton;

    [self refresh];
}

- (void)sortLocations {
    NSMutableArray *locationsArr = [self.locations mutableCopy];

    switch (self.bmwLocationSortingOption) {
        case BMWLocationSortingOptionName:
            [locationsArr sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES], nil]];
        
            self.locations = locationsArr;
            break;
        case BMWLocationSortingOptionArrivalTime:
             [locationsArr sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"arrivalTime" ascending:YES], nil]];
            
            self.locations = locationsArr;
            break;
        case BMWLocationSortingOptionDistance:
        {
            CLLocation *currentLocation = [[BMWLocationService sharedInstance] currentLocation];
            self.locations = [locationsArr sortedArrayUsingComparator:^(BMWLocation *loc1, BMWLocation *loc2) {
                CLLocation *location1 = [[CLLocation alloc] initWithLatitude:loc1.latitude longitude:loc1.longitude];
                CLLocation *location2 = [[CLLocation alloc] initWithLatitude:loc2.latitude longitude:loc2.longitude];
                CLLocationDistance distance1 = [location1 distanceFromLocation:currentLocation];
                CLLocationDistance distance2 = [location2 distanceFromLocation:currentLocation];

                if (distance1 < distance2) {
                    return NSOrderedAscending;
                } else if (distance1 > distance2) {
                    return NSOrderedDescending;
                } else {
                    return NSOrderedSame;
                }

            }];
        }
            break;
            
        default:
            break;
    }
    
    NSRange range = NSMakeRange(0, [self numberOfSectionsInTableView:self.locationsTableView]);
    NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.locationsTableView reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)updateSortingOptionsToolbarOnTapOfOption:(UIBarButtonItem *)selectedOption {
    
    selectedOption.tintColor = [UIColor greenColor];
    self.currentSelectedBarButton.tintColor = nil;
    //[UIColor colorWithRed:0.0 green:122.0/255 blue:255.0/255 alpha:1.0];
    //[UIColor colorWithHue:0.6 saturation:0.33 brightness:0.69 alpha:1];
    self.currentSelectedBarButton = selectedOption;
}

#pragma mark - Notification Handler

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object  change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"currentLocation"]) {
        if (self.bmwLocationSortingOption == BMWLocationSortingOptionDistance) {
            [self sortLocations];
        }
    }
}

#pragma mark - IBActions
#pragma mark - Sort Options (Toolbar)

- (IBAction)sortLocationsBySelectedOptionItem:(UIBarButtonItem *)sender {
    if (sender == self.currentSelectedBarButton) {
        return;
    }
    
    //Button tags are correspond to Enum values
    
    self.bmwLocationSortingOption = sender.tag;
    
    [self sortLocations];
    
    [self updateSortingOptionsToolbarOnTapOfOption:sender];
}
//
//- (IBAction)sortLocationByArrivalTime:(UIBarButtonItem*)sender {
//    self.bmwLocationSortingOption = BMWLocationSortingOptionArrivalTime;
//    [self sortLocations];
//    [self updateSortingOptionsToolbarOnTapOfOption:sender];
//}
//
//- (IBAction)sortLocationByDistance:(UIBarButtonItem*)sender {
//    self.bmwLocationSortingOption = BMWLocationSortingOptionDistance;
//    [self sortLocations];
//    [self updateSortingOptionsToolbarOnTapOfOption:sender];
//}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell Identifier" forIndexPath:indexPath];
    
    BMWLocation *bmwLocation = self.locations[indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = bmwLocation.name;
    cell.detailTextLabel.text = [NSDate dateStringFromDateInDefaultTimeZone:bmwLocation.arrivalTime];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (![segue.identifier isEqualToString:kBMWLocationDetailSegue]) {
        return;
    }
    
    UIViewController *destinationVC = segue.destinationViewController;
    
    if ([destinationVC respondsToSelector:@selector(setSelectedBMWLocation:)]) {
        NSIndexPath *selectedIndexPath = [self.locationsTableView indexPathForCell:sender];
        
        [destinationVC setValue:self.locations[selectedIndexPath.row] forKey:@"selectedBMWLocation"];
    }
    
}

@end
