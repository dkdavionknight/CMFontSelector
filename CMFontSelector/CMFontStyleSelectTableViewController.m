//
//  CMFontStyleSelectTableViewController.m
//  CMTextStylePicker
//
//  Created by Chris Miles on 20/10/10.
//  Copyright (c) Chris Miles 2010.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CMFontStyleSelectTableViewController.h"

#define kSelectedLabelTag		1001
#define kFontNameLabelTag		1002

static const CGFloat contentWidthForViewInPopover = 321;
static const CGFloat contentHeightForViewInPopover = 414;

@implementation CMFontStyleSelectTableViewController {
    NSString *_baseFontName;
}

@synthesize delegate;
@synthesize fontFamilyName;
@synthesize fontNames, selectedFont;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	assert(self.fontFamilyName != nil);

    CGSize preferredContentSize = CGSizeMake(contentWidthForViewInPopover, contentHeightForViewInPopover);
    if ([self respondsToSelector:@selector(preferredContentSize)]) {
        self.preferredContentSize = preferredContentSize;
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.contentSizeForViewInPopover = preferredContentSize;
#pragma clang diagnostic pop
    }
    self.navigationItem.title = self.fontFamilyName;
	self.fontNames = [[UIFont fontNamesForFamilyName:self.fontFamilyName]
					  sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    for (NSString *fontName in self.fontNames) {
        if ([fontName rangeOfString:@"-"].location == NSNotFound) {
            _baseFontName = fontName;
            break;
        }
    }
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.fontNames count];
}

- (NSString *)fontNameToDisplayName:(NSString *)fontName {
    if ([fontName isEqualToString:_baseFontName]) {
        return @"Regular";
    }
    else {
        NSArray *components = [fontName componentsSeparatedByString:@"-"];
        NSString *displayName;
        if (components.count == 1) {
            displayName = [fontName substringFromIndex:_baseFontName.length];
        }
        else {
            displayName = components[1];
        }
        NSMutableString *str = [[displayName substringWithRange:NSMakeRange(0, 1)] mutableCopy];
        BOOL previouslySpaced = YES;
        for (NSInteger i = 1; i < displayName.length; i++){
            NSString *ch = [displayName substringWithRange:NSMakeRange(i, 1)];
            if ([ch rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound) {
                if (!previouslySpaced) {
                    [str appendString:@" "];
                    previouslySpaced = YES;
                }
            }
            else {
                previouslySpaced = NO;
            }
            [str appendString:ch];
        }
        return [str copy];
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FontStyleSelectTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		
		CGRect frame = CGRectMake(10.0, 5.0, 25.0, cell.frame.size.height-5.0);
		UILabel *selectedLabel = [[UILabel alloc] initWithFrame:frame];
		selectedLabel.tag = kSelectedLabelTag;
		selectedLabel.font = [UIFont systemFontOfSize:24.0];
		[cell.contentView addSubview:selectedLabel];
		
		frame = CGRectMake(35.0, 5.0, cell.frame.size.width-70.0, cell.frame.size.height-5.0);
		UILabel *fontNameLabel = [[UILabel alloc] initWithFrame:frame];
		fontNameLabel.tag = kFontNameLabelTag;
		[cell.contentView addSubview:fontNameLabel];
    }
    
    // Configure the cell...
	NSString *fontName = [self.fontNames objectAtIndex:indexPath.row];
	
	UILabel *fontNameLabel = (UILabel *)[cell viewWithTag:kFontNameLabelTag];
	fontNameLabel.text = [self fontNameToDisplayName:fontName];
	fontNameLabel.font = [UIFont fontWithName:fontName size:16.0];
	
	UILabel *selectedLabel = (UILabel *)[cell viewWithTag:kSelectedLabelTag];
	if ([self.selectedFont.fontName isEqualToString:fontName]) {
		selectedLabel.text = @"✔";
	}
	else {
		selectedLabel.text = @"";
	}
	
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *fontName = [self.fontNames objectAtIndex:indexPath.row];
	self.selectedFont = [UIFont fontWithName:fontName size:self.selectedFont.pointSize];
	
	[delegate fontStyleSelectTableViewController:self didSelectFont:self.selectedFont];
	[tableView reloadData];
}

@end

