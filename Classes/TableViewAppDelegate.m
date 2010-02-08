//
//  TableViewAppDelegate.m
//  TableView
//
//  Created by Chaitanya Pandit on 2/5/10.
//

#import "TableViewAppDelegate.h"
#import "PlainTableViewViewController.h"
#import "SectionedPlainTableViewController.h"
#import "GroupedTableViewController.h"

@implementation TableViewAppDelegate

@synthesize window;
@synthesize tabBarController;


#pragma mark -
#pragma mark Application lifecycle
#pragma mark -

// --------------------------------------------------------------------------------
// applicationDidFinishLaunching:

- (void)applicationDidFinishLaunching:(UIApplication *)application
{    
    UITabBarItem *item;
	
    // Override point for customization after app launch    
	PlainTableViewViewController *plainTableViewCon = [[PlainTableViewViewController alloc] initWithNibName:@"PlainTableView" bundle:nil];
	UINavigationController *plainNavCon = [[UINavigationController alloc] initWithRootViewController:plainTableViewCon];
	[plainTableViewCon release];
	item = [[UITabBarItem alloc] initWithTitle:@"Plain" image:[UIImage imageNamed:@"tabbarPlain.png"] tag:0];
	plainNavCon.tabBarItem = item;
	[item release];
	
	SectionedPlainTableViewController *sectionPlainViewCon = [[SectionedPlainTableViewController alloc] initWithNibName:@"SectionedPlainTableView" bundle:nil];
	UINavigationController *sectionedPlainNavCon = [[UINavigationController alloc] initWithRootViewController:sectionPlainViewCon];
	[sectionPlainViewCon release];
	item = [[UITabBarItem alloc] initWithTitle:@"Sectioned" image:[UIImage imageNamed:@"tabbarSectioned.png"] tag:1];
	sectionedPlainNavCon.tabBarItem = item;
	[item release];
	
	GroupedTableViewController *groupedViewCon = [[GroupedTableViewController alloc] initWithNibName:@"GroupedTableView" bundle:nil];
	UINavigationController *groupedNavCon = [[UINavigationController alloc] initWithRootViewController:groupedViewCon];
	[groupedViewCon release];
	item = [[UITabBarItem alloc] initWithTitle:@"Grouped" image:[UIImage imageNamed:@"tabbarGrouped.png"] tag:2];
	groupedNavCon.tabBarItem = item;
	[item release];
	
	tabBarController.viewControllers = [NSArray arrayWithObjects:plainNavCon, sectionedPlainNavCon, groupedNavCon, nil];
	[plainNavCon release];
	[sectionedPlainNavCon release];
	[groupedNavCon release];
	
	[window addSubview:[tabBarController view]];
    [window makeKeyAndVisible];
}

// --------------------------------------------------------------------------------
// applicationWillTerminate:
// Save data if appropriate

- (void)applicationWillTerminate:(UIApplication *)application 
{
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management
#pragma mark -

// --------------------------------------------------------------------------------
// dealloc:

- (void)dealloc 
{
	[tabBarController release];
	[window release];
	[super dealloc];
}


@end

