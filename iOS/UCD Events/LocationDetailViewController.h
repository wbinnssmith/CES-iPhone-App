//
//  LocationDetailViewController.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "LocationItemJSONDataSource.h"
#import "LocationItem.h"

@protocol LocationDetailViewControllerDelegate;

@interface LocationDetailViewController : TTTableViewController {
    NSString* _locationId;
    
    LocationItemJSONDataModel* _locationItemDataModel;
    
   id<LocationDetailViewControllerDelegate> _delegate;
}

-(id)initWithLocationId:(NSString *)locationId;

@property (nonatomic, retain) id<LocationDetailViewControllerDelegate> delegate;

@property (nonatomic, retain) LocationItem *viewingLocation;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *typeLabel;
@property (nonatomic, retain) IBOutlet UIButton *phoneButton;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UITableView *contactTable;

@end
