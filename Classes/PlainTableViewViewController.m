//
//  PlainTableViewController.m
//  TableView
//
//  Created by Chaitanya Pandit on 2/5/10.
//

#import "PlainTableViewViewController.h"

@implementation PlainTableViewViewController

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
	self.navigationItem.title = @"Plain";
	
	titles = [[NSMutableArray alloc] initWithObjects:@"Beach Ball", @"Caduceus", @"Chalkboard", @"Chess", @"Cupcake", @"Flippers", 
			  @"Fortune Cookie", @"Gear Knob", @"Gingerbread Man", @"Movie Star", @"Orange", @"Painter's Palette", @"Piza",
			  @"Robot", @"Rocket", @"Smack", nil];
	
	// Collect all the images in the images array
	images = [[NSMutableArray alloc] initWithCapacity:[titles count]];
	NSFileManager *fm = [NSFileManager defaultManager];
	NSDirectoryEnumerator *fmEnum = [fm enumeratorAtPath:[[NSBundle mainBundle] bundlePath]];
	NSString *file;
	while (file = [fmEnum nextObject]) 
	{
		if ([[file pathExtension] isEqualToString: @"tif"]) 
		{
			// process the document
			UIImage *image = [UIImage imageNamed:file];
			if (image)
				[images addObject:image];
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
	[titles release];
	[images release];
	
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
    return 1;
}

// --------------------------------------------------------------------------------
// tableView: numberOfRowsInSection:

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [titles count];
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
    
	cell.textLabel.text = [titles objectAtIndex:indexPath.row];
	cell.imageView.image = [images objectAtIndex:indexPath.row];
	
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
	[titles exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
	[images exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

// --------------------------------------------------------------------------------
// tableView: commitEditingStyle: forRowAtIndexPath:

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		// Remove the title and the image for a specified row
		[titles removeObjectAtIndex:indexPath.row];
		[images removeObjectAtIndex:indexPath.row];
		
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
	}
}

@end

