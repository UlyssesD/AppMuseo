//
//  PrenotazioneTableViewController.m
//  MuseoAntropologia
//
//  Created by Ulysses D. on 25/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "PrenotazioneTableViewController.h"
#import "SWRevealViewController.h"
#import "Reachability.h"
@interface PrenotazioneTableViewController ()

@end

@implementation PrenotazioneTableViewController
@synthesize history = _history;

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
    
    self.title = @"Prenotazioni";
    CGRect frame = CGRectMake(0, 0, 100, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"STHeitiTC-Light" size:21.0f];
    label.textColor = [UIColor blackColor];
    label.text = self.navigationItem.title;
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    ////////////////////
    
    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [sysPaths objectAtIndex:0];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Prenotazioni.plist"];
    
    NSArray *dictionary;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        
    {
        dictionary = [[NSArray alloc] initWithContentsOfFile:filePath];
        
    }
    
    else
        
    {
        dictionary = [[NSArray alloc] init];
        
    }
    
    
    
    ////////
    
    /*NSArray *dictionary = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Prenotazioni" ofType:@"plist"]];
    */
    NSLog(@"count: %d", [dictionary count]);
    
    /*
    if([dictionary count] == 0){
        _history.userInteractionEnabled = NO;
        _history.textLabel.enabled = NO;
    }
     */
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (BOOL) isConnected{
//    char *hostname;
//    struct hostent *hostinfo;
//    hostname = "google.com";
//    hostinfo = gethostbyname (hostname);
//    if (hostinfo == NULL){
//        NSLog(@"-> no connection!\n");
//        // alert
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connessione assente" message:@"Controlla la tua connessione prima di continuare la prenotazione" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alert show];
//        return NO;
//        
//    }
//    else{
//        NSLog(@"-> connection established!\n");
//        return YES;
//    }
//
//}




//controllo connessione prima di prenotazione
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"prenotaora"]){
        //// Just use it ,Where you need it  (checking internet connection)
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus internetStatus = [reachability currentReachabilityStatus];
        
        if (internetStatus == NotReachable){
            NSLog(@"-> connection NOT established!\t\n");
            // alert
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connessione assente" message:@"Controlla la tua connessione prima di continuare la prenotazione" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            return NO;
            
        }
        else{
            // There is a internet connection
            /// Do,Whatever you want
            NSLog(@"-> connection established!\t\n");
            NSURL *url=[NSURL URLWithString:@"http://www.sapienzaapps.it/saccopastore/checkConnessione.php"];
            NSData *data = [NSData dataWithContentsOfURL:url];
            NSString *pp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            
            if(pp != nil){
                NSLog(@"-> connection established! YES\t\n");
                return YES;
            }
            else{
                NSLog(@"-> connection established! NO\t\n");// alert
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connessione assente" message:@"Controlla la tua connessione prima di continuare la prenotazione" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                return NO;
            }
        }
        
    }
    return YES;
}



/*- (void) aggiornaVista
{
    NSLog(@"Dentro aggiornaVista");
    [self.tableView reloadData];
}*/
/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
