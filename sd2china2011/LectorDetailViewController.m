//
//  LectorDetailViewController.m
//  sd2china2011
//
//  Created by Yu Hao on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LectorDetailViewController.h"
#import "JsonDataSource.h"
#import "GTMBase64.h"

@implementation LectorDetailViewController

@synthesize forumID;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.forumID =@"1442";
    NSLog(@"%@",forumID);
    NSDictionary* allData = [[JsonDataSource jsonObjectWithFile:@"lecturer"]objectForKey:@"lecturer"];
    lectorData = [allData objectForKey:self.forumID];
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [lectorData count];
}

//subtitle style
-(UITableViewCell*) setCellDataM1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.detailTextLabel.numberOfLines = 0;
        
        //cell.indentationWidth = 25.0;
        //cell.indentationLevel = 1;
    }
  
    
    cell.textLabel.text = [[lectorData objectAtIndex:indexPath.row]objectForKey:@"title"];
    NSString* base64Img = [[lectorData objectAtIndex:indexPath.row]objectForKey:@"avatar"];
    NSData* dataImg = [GTMBase64 decodeString:base64Img];
    
    cell.imageView.frame = CGRectMake(0.0 ,0.0 , 20, 20);
    cell.imageView.center = CGPointMake(20.0, 20.0);
    [cell.imageView setImage:[UIImage imageWithData:dataImg]]; 
    
    
    //CGRect newFrame = cell.imageView.frame;
    /*
    newFrame.origin.x = 0; //CGRectGetMinX (cell.contentView.bounds);
    newFrame.origin.y = 0; // CGRectGetMinY (cell.contentView.bounds);
    
    newFrame = CGRectMake(0, 0, 47, 47);
    [cell.imageView setFrame: newFrame];
    */
    
    cell.detailTextLabel.text = [[lectorData objectAtIndex:indexPath.row]objectForKey:@"description"];
    
    CGAffineTransform translate = CGAffineTransformMakeTranslation(50.0, 0.0); 
    [cell.detailTextLabel setTransform:translate];
    return cell;
    
}

//custom
- (UITableViewCell *)setCellDataM2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
        CGRect frame;
        frame.origin.x = 10;
        frame.origin.y = 5;
        frame.size.height = 15;
        frame.size.width = 300;
        
        frame = CGRectMake(3, 10, 50, 50);
        UIImageView* image = [[UIImageView alloc]initWithFrame:frame];
        image.tag = 3;
        [cell.contentView addSubview:image];
        
        frame = CGRectMake(55 , 10, 260, 22);
        UILabel* titleLabel = [[UILabel alloc]initWithFrame:frame];
        titleLabel.tag = 1;
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        [cell.contentView addSubview:titleLabel];
        
        //frame = CGRectMake(55, 10, 200, 22);
        frame.origin.y += 18;
        UILabel* descLabel = [[UILabel alloc]initWithFrame:frame];
        descLabel.tag = 2;
        descLabel.lineBreakMode = UILineBreakModeWordWrap;
        descLabel.numberOfLines = 0;    
        descLabel.font = [UIFont systemFontOfSize:14.0];
        

        
        [cell.contentView addSubview:descLabel];
        
        //frame.origin.y = CGRectGetMaxY(titleLabel.frame);
        

        
    }
    UILabel* titleLabel = (UILabel*)[cell.contentView viewWithTag:1];
    UILabel* descLabel = (UILabel*)[cell.contentView viewWithTag:2];
    
    titleLabel.text = [[lectorData objectAtIndex:indexPath.row]objectForKey:@"title"];
    
    NSString* base64Img = [[lectorData objectAtIndex:indexPath.row]objectForKey:@"avatar"];
    NSData* dataImg = [GTMBase64 decodeString:base64Img];
    UIImageView* image = (UIImageView*) [cell.contentView viewWithTag:3];
    
    [image setImage:[UIImage imageWithData:dataImg]];     
    
    //[cell.imageView setImage:[UIImage imageWithData:dataImg]]; 
    
    descLabel.text = [[lectorData objectAtIndex:indexPath.row]objectForKey:@"description"];
    [descLabel sizeToFit];
    
    
    //    cell.detailTextLabel.frame = CGRectMake(cell.detailTextLabel.frame.origin.x, cell.detailTextLabel.frame.origin.y, cell.detailTextLabel.frame.size.width,labelSize.height);
    //    [cell.textLabel setText:[[lectorData objectAtIndex:indexPath.row]objectForKey:@"avatar"]
    //NSData* imgData = [[NSData datawithba
    // Configure the cell...
    //    CGRect cellFrame = [cell frame];
    //    cellFrame.origin = CGPointMake(0, 0);
    //    
    //    CGRect rect = CGRectInset(cellFrame, 2, 2);
    //    cell.detailTextLabel.frame = rect;
    //    [cell.detailTextLabel sizeToFit];
    //    
    //    cellFrame.size.height = cell.detailTextLabel.frame.size.height;
    //    
    //    NSLog(@"%@",cell.detailTextLabel.frame.size.height);
    //    //
    
    //    CGSize labelSize = [cell.detailTextLabel.text sizeWithFont:cell.detailTextLabel.font constrainedToSize:CGSizeMake(320, 140) lineBreakMode:cell.detailTextLabel.lineBreakMode];   
    //    cellFrame.size.height = 200;
    //    [cell setFrame:cellFrame];
    
    return cell;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.forumID isEqualToString:@"1443"])
        return [self setCellDataM1:tableView cellForRowAtIndexPath:indexPath];
    else
        return [self setCellDataM2:tableView cellForRowAtIndexPath:indexPath];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* description = [[lectorData objectAtIndex:indexPath.row]objectForKey:@"description"];
    NSString* title = [[lectorData objectAtIndex:indexPath.row]objectForKey:@"title"];    
//    CGSize size = [description sizeWithFont:[UIFont systemFontOfSize:17.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap];
//    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
//    NSLog(@"%@",cell.detailTextLabel.text);
    UIFont *cellFont = [UIFont systemFontOfSize:17.0];
    
    CGSize labelSize = [description sizeWithFont:cellFont  constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:UILineBreakModeWordWrap];    
 
    CGSize labelSize2 = [title sizeWithFont:cellFont  constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:UILineBreakModeWordWrap]; 
    
    
    return labelSize.height+labelSize2.height+10;
    
}
 

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
