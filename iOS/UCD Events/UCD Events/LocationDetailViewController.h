//
//  LocationDetailViewController.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "LocationItem.h"

@interface LocationDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

}

-(id)initWithLocation:(LocationItem *)theLocation;
-(IBAction) message;
-(NSString *) formatPhoneString:(NSString *) rawString;

@property (nonatomic, retain) LocationItem *viewingLocation;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *typeLabel;
@property (nonatomic, retain) IBOutlet UIButton *phoneButton;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UITableView *contactTable;

@property (nonatomic, retain) NSString *locationName;
@property (nonatomic, retain) NSString *locationCategory;
@property (nonatomic, retain) NSString *locationPhone;
@property (nonatomic, retain) UIImage *locationImage;

@property (nonatomic, retain) NSString *locationAddress;
@property (nonatomic, retain) NSString *locationCity;
@property (nonatomic, retain) NSString *locationCountry;

@end
