//
//  BasicLauncherViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicLauncherViewController.h"
#import "Three20UI/UIViewAdditions.h"

@interface BasicLauncherViewController(Private)
- (TTLauncherItem *)launcherItemWithTitle:(NSString *)pTitle image:(NSString *)image URL:(NSString *)url;
@end

@implementation BasicLauncherViewController

#pragma mark -
#pragma mark NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Home";

    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}


#pragma mark -
#pragma mark UIView

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    NSLog(@"did loadview on launcher");
    [super loadView];
	
	launcherView = [[UELauncherView alloc] initWithFrame:CGRectMake(0, 0, 320, 385)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titlegray.png"]];
	launcherView.columnCount = 3;
    //	launcherView.rowCount = 4;
	launcherView.pages = [NSArray arrayWithObjects:
						  [NSArray arrayWithObjects:
						   [self launcherItemWithTitle:@"Weather" 
                                                 image:@"bundle://weather.png" 
                                                   URL:@"http://www.accuweather.com/m/en-us/US/CA/Davis/Quick-Look.aspx"
                            ],
						   [self launcherItemWithTitle:@"Map" 
                                                 image:@"bundle://maps.png" 
                                                   URL:@"ucde://map/"
                            ],
						   [self launcherItemWithTitle:@"Events" 
                                                 image:@"bundle://events.png" 
                                                   URL:@"ucde://events/"
                            ],
						   [self launcherItemWithTitle:@"Special Offers" 
                                                 image:@"bundle://deals.png" 
                                                   URL:@"ucde://offers/"
                            ],
						   [self launcherItemWithTitle:@"Restaurants" 
                                                 image:@"bundle://restaurants.png" 
                                                   URL:@"ucde://locationList/Restaurants/1"
                            ],
						   [self launcherItemWithTitle:@"Shopping" 
                                                 image:@"bundle://shopping.png" 
                                                   URL:@"http://maps.google.com/maps/place?cid=9237992642497654431&q=panda+express+davis+ca&hl=en&sll=38.560978,-121.766971&sspn=0.035357,0.058199&ie=UTF8&ll=38.686582,-121.81057&spn=0,0&z=12"
                            ],
						   [self launcherItemWithTitle:@"Hotels" 
                                                 image:@"bundle://hotels.png" 
                                                   URL:@""
                            ],
                           [self launcherItemWithTitle:@"Places" 
                                                 image:@"bundle://places.png" 
                                                   URL:@""
                            ],
						   [self launcherItemWithTitle:@"UC Davis" 
                                                 image:@"bundle://ucd.png" 
                                                   URL:@""
                            ],
                           nil],
                          nil];
	launcherView.delegate = self;
    

    
    TTButton *emergencyInfoButton = [TTButton buttonWithStyle:@"bottomBarButton:" title:@"Emergency Information"];
    [emergencyInfoButton addTarget:@"ucde://info/" action:@selector(openURLFromButton:) forControlEvents:UIControlEventTouchUpInside];
    [emergencyInfoButton setFrame:CGRectMake(0, 370, 320, 50)];
    
	[self.view addSubview:launcherView];
    [self.view addSubview:emergencyInfoButton];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    NSLog(@"viewdidload called on launcherview");
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark TTLauncherView

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:launcherView action:@selector(endEditing)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:launcherView action:@selector(endEditing)];
	self.navigationItem.rightBarButtonItem = editButton;
	[editButton release];
}

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
	[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:item.URL] applyAnimated:YES]];
}

-(TTLauncherItem *)launcherItemWithTitle:(NSString *)pTitle image:(NSString *)image URL:(NSString *)url {
	TTLauncherItem *launcherItem = [[TTLauncherItem alloc] initWithTitle:pTitle 
																   image:image 
																	 URL:url	
															   canDelete:NO];
	return [launcherItem autorelease];
}

- (void)infoButtonAction {
    [[TTNavigator navigator] openURLAction:
     [[TTURLAction actionWithURLPath:@"ucde://navbarInfoButton"] applyAnimated:YES]];
}

@end