//
//  DataSetTableViewController.m
//  ariProva
//
//  Created by Ulysses D. on 22/07/14.
//  Copyright (c) 2014 Ulysses D. All rights reserved.
//

#import "CompleteViewController.h"
#import "DataSetTableViewController.h"
#import "NotesTableViewController.h"

@interface DataSetTableViewController ()
@end

@implementation DataSetTableViewController

@synthesize pNumber = _pNumber;
@synthesize data = _data;
@synthesize slot = _slot;

@synthesize submit = _submit;
@synthesize nome = _nome;
@synthesize cognome = _cognome;
@synthesize email = _email;
@synthesize cellulare = _cellulare;
@synthesize notes = _notes;
bool oneAlert = YES;

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
    _nome.delegate = self;
    _cognome.delegate = self;
    _email.delegate = self;
    _cellulare.delegate = self;
    NSLog(@"Passed: %@, %@, %@", _pNumber, _data, _slot);
    
    _submit.enabled = NO;
    _submit.userInteractionEnabled = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _notes.text = @"Ciao";
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    _cellulare.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad{
    [_cellulare resignFirstResponder];
    _cellulare.text = @"";
}

-(void)doneWithNumberPad{
    [_cellulare resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;
}
- (IBAction)checkData:(id)sender {
    NSLog(@"Enabled: %hhd", _submit.isEnabled);
    if(_submit.isEnabled){
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"dd MMMM yyyy"];
        NSString* fData = [f stringFromDate:_data];
        
        NSString* persone = ([_pNumber isEqualToString: @"scolaresca"]) ? (@"Scolaresca") : ([NSString stringWithFormat: @"Persone: %@", _pNumber]);
        NSString *infos = [NSString stringWithFormat:@"Rivedi le informazioni: \nReferente: %@ %@\nCellulare: %@\nE-mail: %@\nData: %@\n%@",
                           _nome.text, _cognome.text, _cellulare.text, _email.text, fData, persone];
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle: infos
                                      delegate: self
                                      cancelButtonTitle:@"Annulla"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Salva", nil];
        
        [actionSheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self performSegueWithIdentifier:@"Complete" sender:self];
            break;
            
    }
}


#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}
*/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd MMMM yyyy"];
    switch (section){
        case 0:
            return [NSString stringWithFormat:@"  %@", [f stringFromDate:_data]];
            break;
        default:
            break;
    }
    return @"";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        switch(indexPath.row){
            case 0:
                [self.nome becomeFirstResponder];
                break;
            case 1:
                [self.cognome becomeFirstResponder];
                break;
            case 2:
                [self.email becomeFirstResponder];
                break;
            case 3:
                [self.cellulare becomeFirstResponder];
                break;
        }

}


- (IBAction)checkInput:(id)sender {
    
    
    
    if ( [_cellulare.text isEqual:@""] || [_cognome.text isEqual:@""] || [_email.text isEqual:@""] || [_nome.text isEqual:@""] || ![self isValidEmail:_email.text]) {
        //not ok
        
        _submit.enabled = NO;
        _submit.userInteractionEnabled = NO;
        
        
    } else {
        //ok
        _submit.enabled = YES;
        _submit.userInteractionEnabled = YES;
        
    }
    
    
    }

- (IBAction)checkMailInput:(id)sender {
    
    if (oneAlert || (![self isValidEmail:_email.text] && ![_email.text isEqual:@""])) {
        //TODO : allest malformed mail
        oneAlert = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Formato email non corretto" message:@"Inserisci una mail valida per continuare" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }

}

-(BOOL)isValidEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:email];
}

/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"Complete"]) {
        CompleteViewController *complete = segue.destinationViewController;
        complete.controller = self.navigationController;
    
    }
    else{
        NotesTableViewController * notesView = segue.destinationViewController;
        notesView.delegate=self; // protocol listener
        notesView.text = _notes.text;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(void)sendDataToA:(NSString *)text
{
    _notes.text = text;
    // data will come here inside of ViewControllerA
}

@end
