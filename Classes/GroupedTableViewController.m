//
//  GroupedTableViewController.m
//  TableView
//
//  Created by Chaitanya Pandit on 2/5/10.
//  Copyright 2010 Expersis Software Inc. All rights reserved.
//

#import "GroupedTableViewController.h"


@implementation GroupedTableViewController


#pragma mark -
#pragma mark ViewController Life cycle
#pragma mark -

// --------------------------------------------------------------------------------
// viewDidLoad

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Left button is the edit button
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	// Set the title
	self.navigationItem.title = @"Grouped";
	
	titles1 = [[NSMutableArray alloc] initWithObjects:@"Beach Ball", @"Caduceus", @"Chalkboard", @"Chess", @"Cupcake",  @"Flippers", @"Fortune Cookie", @"Gear Knob", nil];
	
	titles2 = [[NSMutableArray alloc] initWithObjects: @"Gingerbread Man", @"Movie Star", @"Orange", @"Painter's Palette", @"Piza",  @"Robot", @"Rocket", @"Smack", nil];
	
	
	// Collect all the images in the images array
	images1 = [[NSMutableArray alloc] initWithCapacity:[titles1 count]];
	images2 = [[NSMutableArray alloc] initWithCapacity:[titles2 count]];
	
	NSFileManager *fm = [NSFileManager defaultManager];
	NSDirectoryEnumerator *fmEnum = [fm enumeratorAtPath:[[NSBundle mainBundle] bundlePath]];
	NSString *file;
	int i = 0;
	while (file = [fmEnum nextObject]) 
	{
		if ([[file pathExtension] isEqualToString: @"tif"]) 
		{
			// process the document
			UIImage *image = [UIImage imageNamed:file];
			if (image)
			{
				if (i<[titles1 count])
					[images1 addObject:image];
				else
					[images2 addObject:image];
				i++;
			}
		}
	}
}

#pragma mark -
#pragma mark Memory management
#pragma mark -

// --------------------------------------------------------------------------------
// dealloc

- (void) dealloc
{
	[titles1 release];
	[titles2 release];
	
	[images1 release];
	[images2 release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark Standard Overrides
#pragma mark

// --------------------------------------------------------------------------------
// setEditing: animated:
// 
// Overridden to edit the tableView when the edit button is pressed

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{	
	// Pass the editing state to the tableview as well
	[self.tableView setEditing:editing animated:animated];
	[super setEditing:editing animated:animated];
}

#pragma mark -
#pragma mark Table view methods
#pragma mark

// --------------------------------------------------------------------------------
// numberOfSectionsInTableView:

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 2;
}

// --------------------------------------------------------------------------------
// tableView: titleForHeaderInSection:

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *retVal = nil;
	if (section == 0)
		retVal = @"Section 1";
	else
		retVal = @"Section 2";
	
	return retVal;
}

// --------------------------------------------------------------------------------
// tableView: numberOfRowsInSection:

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	NSInteger retVal = 0;
	if (section == 0)
		retVal = [titles1 count];
	else
		retVal = [titles2 count];
	
    return retVal;
}

// --------------------------------------------------------------------------------
// tableView: heightForRowAtIndexPath:

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
	return 60.0;
}

// --------------------------------------------------------------------------------
// tableView: cellForRowAtIndexPath:

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"MyCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
	if (indexPath.section ==0)
	{
		cell.textLabel.text = [titles1 objectAtIndex:indexPath.row];
		cell.imageView.image = [images1 objectAtIndex:indexPath.row];	
	}
	else 
	{
		cell.textLabel.text = [titles2 objectAtIndex:indexPath.row];
		cell.imageView.image = [images2 objectAtIndex:indexPath.row];		
	}
	
	// Configure the cell.
    return cell;
}

#pragma mark -
#pragma mark TableView Editing
#pragma mark

// --------------------------------------------------------------------------------
// tableView: moveRowAtIndexPath: toIndexPath:

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath 
{
	NSMutableArray *sourceArray1 = nil;
	NSMutableArray *sourceArray2 = nil;
	NSMutableArray *destArray1 = nil;
	NSMutableArray *destArray2 = nil;
	
	if (sourceIndexPath.section == 0)
	{
		sourceArray1 = titles1;
		sourceArray2 = images1;
	}
	else 
	{
		sourceArray1 = titles2;
		sourceArray2 = images2;
	}
	
	if (destinationIndexPath.section == 0)
	{
		destArray1 = titles1;
		destArray2 = images1;
	}
	else 
	{
		destArray1 = titles2;
		destArray2 = images2;
	}
	
	
	if (sourceArray1 == destArray1)
	{
		[sourceArray1 exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
	}
	else 
	{
		id object = [[sourceArray1 objectAtIndex:sourceIndexPath.row] retain];
		[sourceArray1 removeObjectAtIndex:sourceIndexPath.row];
		[destArray1 insertObject:object atIndex:destinationIndexPath.row];
		[object release];
	}
	
	if (sourceArray2 == destArray2)
	{
		[sourceArray2 exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
	}
	else 
	{
		id object = [[sourceArray2 objectAtIndex:sourceIndexPath.row] retain];
		[sourceArray2 removeObjectAtIndex:sourceIndexPath.row];
		[destArray2 insertObject:object atIndex:destinationIndexPath.row];
		[object release];
	}
}

// --------------------------------------------------------------------------------
// tableView: commitEditingStyle: forRowAtIndexPath:

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		if (indexPath.section ==0)
		{
			[titles1 removeObjectAtIndex:indexPath.row];
			[images1 removeObjectAtIndex:indexPath.row];		
		}
		else 
		{
			[titles2 removeObjectAtIndex:indexPath.row];
			[images2 removeObjectAtIndex:indexPath.row];		
		}
		
		// Remove the title and the image for a specified row		
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
	}
}


@end
