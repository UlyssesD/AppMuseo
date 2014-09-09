//
//  ContattiViewController.m
//  MuseoAntropologia
//
//  Created by Andrea Novelli on 10/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ContattiViewController.h"
#import "SWRevealViewController.h"
#import "Constants.h"

@interface ContattiViewController (){
    NSDictionary *array;
    NSArray *sectionTitles;
}

@end

@implementation ContattiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Contatti";
    CGRect frame = CGRectMake(0, 0, 100, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"STHeitiTC-Light" size:21.0f];
    label.textColor = [UIColor blackColor];
    label.text = self.navigationItem.title;
    label.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = label;
    
    
    
    sectionTitles = [[NSArray alloc]initWithObjects:@"Direttore Prof. G. Manzi", @"Contatta il museo", nil];
    
    array = @{@"Direttore Prof. G. Manzi" : @[contatti],
              @"Contatta il museo" : @[@"06-49912495", @"museo-antropologia@uniroma1.it"],
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
    // Dispose of any resources that can be recreated.
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
    
    NSString *CellIdentifier = @"Cell";
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
    cell.textLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:15.0f];
    
    if (indexPath.section==0) {
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:12.0f];
    }
    [cell.textLabel setNumberOfLines:10];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1 && indexPath.row==0)   {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Chiamare il museo?" message:@"" delegate:self cancelButtonTitle:@"Indietro" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    if (indexPath.row == 1){
        [self showEmail];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]]];
        NSLog(@"Telefonata inviata!");
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //dimensione personalizzata delle celle della timeline
    if (indexPath.section == 0) {
        return 150;
    }
    else
        return 44;
}




- (void)showEmail {
    NSString *emailTitle = @"MuseoAntropologia supporto iOS";
    NSArray *toRecipents = [NSArray arrayWithObject:@"museo-antropologia@uniroma1.it"];
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

/*
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [[UIApplication sharedApplication] openURL:
            [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]];
            break;
        case 1:
            [self showEmail];
            break;
    } 
}

*/


@end
