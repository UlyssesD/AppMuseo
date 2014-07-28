//
//  CreditsViewController.m
//  MuseoAntropologia
//
//  Created by Andrea Novelli on 25/06/14.
//  
//

#import "CreditsViewController.h"
#import "SWRevealViewController.h"

@interface CreditsViewController (){
    NSDictionary *array;
    NSArray *sectionTitles;
}


@end

@implementation CreditsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Credits";
    CGRect frame = CGRectMake(0, 0, 100, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"STHeitiTC-Light" size:21.0f];
    label.textColor = [UIColor blackColor];
    label.text = self.navigationItem.title;
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    
    
    sectionTitles = [[NSArray alloc]initWithObjects:@"Supervisore", @"Programmatori", @"User Researchers", @"Contatta gli autori", nil];
    
    array = @{@"Supervisore" : @[@"Prof. Emanuele Panizzi"],
            @"Programmatori" : @[@"Andrea Novelli", @"Tommaso Pasini", @"Daniele Scarfini"],
              @"User Researchers" : @[@"Giorgia Di Tommaso", @"Daniele Scarfini", @"Agnese Trozzo"],
              @"Contatta gli autori" : @[@""]
            };
    
    
    
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [sectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [sectionTitles objectAtIndex:section];
    NSArray *sectionArray = [array objectForKey:sectionTitle];
    return [sectionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section != 3){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        // Configure the cell...
        NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
        NSArray *sectionArray = [array objectForKey:sectionTitle];
        NSString *a = [sectionArray objectAtIndex:indexPath.row];
        cell.textLabel.text = a;
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:18.0f];
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    
        
        UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(30.0, 0.0, 245.0, 45.0)];
        [cell.contentView addSubview:photo];
        photo.image = [UIImage imageNamed:@"sapienzaapps.png"];
        
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionArray = [array objectForKey:sectionTitle];
    NSString *a = [sectionArray objectAtIndex:indexPath.row];
    if([a isEqualToString:@""]){
        [self showEmail];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showEmail {
    NSString *emailTitle = @"MuseoAntropologia supporto iOS";
    NSArray *toRecipents = [NSArray arrayWithObject:@"sapienzaapps@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancellata");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail salvata");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail inviata");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Invio mail fallito: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
