//
//  TourVirtualeTableViewController.m
//  MuseoAntropologia
//
//  Created by Andrea Novelli on 20/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "TourVirtualeTableViewController.h"
#import "SWRevealViewController.h"
#import "CraniViewController.h"
#import "Constants.h"
#import "CranioTableViewCell.h"
#import "AppDelegate.h"

@interface TourVirtualeTableViewController ()
{
    NSUserDefaults *def;
    BOOL lock1;
    BOOL lock2;
    BOOL lock3;
    BOOL lock4;
    BOOL lock5;
}


@property (nonatomic, strong) NSArray *historyItems;



@end

@implementation TourVirtualeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    def = appDelegate.defaults;
    
    _historyItems = @[@"n1", @"ceprano", @"saccop1", @"saccop2", @"guattari", @"maiella"];
    
    self.title = @"Linea del tempo";
    
    CGRect frame = CGRectMake(0, 0, 100, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"STHeitiTC-Light" size:21.0f];
    label.textColor = [UIColor blackColor];
    label.text = self.navigationItem.title;
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    
    lock1 = [def boolForKey:@"locked1"];
    lock2 = [def boolForKey:@"locked2"];
    lock3 = [def boolForKey:@"locked3"];
    lock4 = [def boolForKey:@"locked4"];
    lock5 = [def boolForKey:@"locked5"];
    
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    refreshControl.tintColor = [UIColor redColor];
    
    [refreshControl addTarget:self action:@selector(changeLock) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.historyItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.historyItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    /*
     *  Gestione dello sblocco del cranio. da implementare usando il beacon
     */
    
    if ([CellIdentifier isEqualToString:self.historyItems[1]] && !lock1)
    {
        CranioTableViewCell *cell2 = (CranioTableViewCell*)cell;
        cell2.lockImg.image = [UIImage imageNamed:@"done.png"];
    }
    if ([CellIdentifier isEqualToString:self.historyItems[2]] && !lock2)
    {
        CranioTableViewCell *cell2 = (CranioTableViewCell*)cell;
        cell2.lockImg.image = [UIImage imageNamed:@"done.png"];
    }
    if ([CellIdentifier isEqualToString:self.historyItems[3]] && !lock3)
    {
        CranioTableViewCell *cell2 = (CranioTableViewCell*)cell;
        cell2.lockImg.image = [UIImage imageNamed:@"done.png"];
    }
    if ([CellIdentifier isEqualToString:self.historyItems[4]] && !lock4)
    {
        CranioTableViewCell *cell2 = (CranioTableViewCell*)cell;
        cell2.lockImg.image = [UIImage imageNamed:@"done.png"];
    }
    if ([CellIdentifier isEqualToString:self.historyItems[5]] && !lock5)
    {
        CranioTableViewCell *cell2 = (CranioTableViewCell*)cell;
        cell2.lockImg.image = [UIImage imageNamed:@"done.png"];
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ancora non puoi!" message:@"Per sbloccare il modello 3D di questo cranio devi recarti al museo e posizionarti davanti alla teca" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    if (indexPath.row == 1 && lock1)
    {
        [alert show];
    }
    if (indexPath.row == 2 && lock2)
    {
        [alert show];
    }
    if (indexPath.row == 3 && lock3)
    {
        [alert show];
    }
    if (indexPath.row == 4 && lock4)
    {
        [alert show];
    }
    if (indexPath.row == 5 && lock5)
    {
        [alert show];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//invio d'identificativo della cella (nome del cranio) alla prossima view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        CraniViewController *cvc = segue.destinationViewController;
        cvc.skullName = segue.identifier;
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
    if ([identifier isEqualToString:Ceprano] && !lock1)
    {
        return YES;
    }
    if ([identifier isEqualToString:Saccop1] && !lock2)
    {
        return YES;
    }
    if ([identifier isEqualToString:Saccop2] && !lock3)
    {
        return YES;
    }
    if ([identifier isEqualToString:Guattari] && !lock4)
    {
        return YES;
    }
    if ([identifier isEqualToString:Maiella] && !lock5)
    {
        return YES;
    }
    
    return NO;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //dimensione personalizzata delle celle della timeline
    if (indexPath.row == 0) {
        return 40;
    }
    if (indexPath.row == 1) {
        return 150;
    }
    if (indexPath.row == 2 || indexPath.row == 3) {
        return 65;
    }
    return 80;
}


//aggiorna la tabella
- (void) changeLock
{
    [self performSelector:@selector(updateTable:) withObject:self.tableView
               afterDelay:1];
}


//metodo per aggiornare lo stato dei crani bloccati/non bloccati e li rende cliccabili o meno
//la variabile locked è in AppDelegate 
- (void)updateTable:(UITableView *)tableView
{
    //Decomentare per riattivare sblocco dei crani
//    for (int i=1; i<=5; i++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        CranioTableViewCell *cell = (CranioTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//        cell.lockImg.image = [UIImage imageNamed:@"done.png"];
//    }
    
//    lock1 = lock2 = lock3 = lock4 = lock5 =false;
    
    [self.tableView reloadData];
    
    [self.refreshControl endRefreshing];
}

//- (void)unclock:(UITableView *)tableView unlock:(int *)identifier
//{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: *identifier inSection:0];
//    CranioTableViewCell *cell = (CranioTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//    cell.lockImg.image = [UIImage imageNamed:@"done.png"];
//}


@end
