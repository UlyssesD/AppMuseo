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
    @property BOOL firstLaunch;
@end

@implementation DataSetTableViewController
@synthesize pNumber = _pNumber;
@synthesize data = _data;
@synthesize slot = _slot;

@synthesize info = _info;
@synthesize submit = _submit;
@synthesize nome = _nome;
@synthesize cognome = _cognome;
@synthesize email = _email;
@synthesize cellulare = _cellulare;
@synthesize notes = _notes;





- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

        
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
    
    _notes.text = @"";
    
    /*UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancella" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Finito" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    _cellulare.inputAccessoryView = numberToolbar;*/
    
   [self addInfoMessage];
}

/*
-(void)cancelNumberPad{
    [_cellulare resignFirstResponder];
    _cellulare.text = @"";
}

-(void)doneWithNumberPad{
    [_cellulare resignFirstResponder];
}
*/

- (void) addInfoMessage{
    UIBarButtonItem *message = [[UIBarButtonItem alloc]initWithTitle:@"Trascina verso il basso per chiudere" style:UIBarButtonItemStylePlain target:self action:nil];
    message.enabled = NO;
    UIToolbar* infoToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    infoToolbar.barStyle = UIBarStyleDefault;
    infoToolbar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         message,
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         nil];
    [infoToolbar sizeToFit];
    //infoToolbar.alpha = 0.7;
    _nome.inputAccessoryView = infoToolbar;
    _cognome.inputAccessoryView = infoToolbar;
    _email.inputAccessoryView = infoToolbar;
    _cellulare.inputAccessoryView = infoToolbar;
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
        
        NSString* note;
        if ([_notes.text length] == 0) note = @"Nessuna nota inserita";
        else note = ([_notes.text length] >= 150) ? ([NSString stringWithFormat: @"Note: %@...", [_notes.text substringToIndex:147]]) : [NSString stringWithFormat: @"Note: %@", _notes.text];
        
        
        NSString* persone = ([_pNumber isEqualToString: @"Scolaresca"]) ? (@"Scolaresca") : ([NSString stringWithFormat: @"Persone: %@", _pNumber]);
        NSString *infos = [NSString stringWithFormat:@"Rivedi le informazioni:\n\nReferente: %@ %@\nCellulare: %@\nE-mail: %@\nData: %@ - %@\n%@\n\n%@",
                           _nome.text, _cognome.text, _cellulare.text, _email.text, fData, _slot, persone, note];
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle: infos
                                      delegate: self
                                      cancelButtonTitle:@"Indietro"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Conferma", nil];
        
        [actionSheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            
            [self performSegueWithIdentifier:@"Complete" sender:self];
            
            //codice aggiunto david
            NSInteger success = 0;
            
            
            NSDateFormatter *f2 = [[NSDateFormatter alloc] init];
            [f2 setDateFormat:@"yyyy-MM-dd"];
            NSString *fData2 = [f2 stringFromDate:_data];

            
            NSString *post =[[NSString alloc] initWithFormat:@"nome=%@&cognome=%@&email=%@&cellulare=%@&note=%@&data=%@&npersone=%@&mattinapomeriggio=%@",[self.nome text],[self.cognome text],[self.email text],[self.cellulare text],[self.notes text], fData2, _pNumber, _slot];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://www.sapienzaapps.it/saccopastore/insertReservation.php"];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            
            //////////////////
            NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,NSUserDomainMask, YES);
            
            NSString *documentsDirectory = [sysPaths objectAtIndex:0];
            
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Prenotazioni.plist"];
            
            NSLog(@"Plist File Path: %@", filePath);
            
            NSMutableArray *plistDict;
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
                
            {
                
                plistDict = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
                
            }
            else
                
            {
                
                plistDict = [[NSMutableArray alloc] init];
                
            }
            NSLog(@"plist data: %@", [plistDict description]);
            
            NSMutableDictionary *subArray=[[NSMutableDictionary alloc] init];
            
            [subArray setValue:_data forKey: @"data"];
            [subArray setValue:_slot forKey: @"slot"];
            [subArray setValue:_pNumber forKey: @"npersone"];
            
            [plistDict addObject:subArray];
    
            
            BOOL didWriteToFile = [plistDict writeToFile:filePath atomically:YES];
            if (didWriteToFile)
                
            {
                
                NSLog(@"Write to .plist file is a SUCCESS!");
                
            }
            
            else
                
            {
                
                NSLog(@"Write to .plist file is a FAILURE!");
                
            }
            
            
            
            //////////////////
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                success = [jsonData[@"success"] integerValue];
                NSLog(@"Success: %ld",(long)success);
                
                if(success == 1)
                {
                    NSLog(@"Inserimento effettuato ");
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Insermineto prenotazione fallita!" :0];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Prenotazione fallita" :@"Si è verificato un errore nella vostra prenotazione!" :0];
            }
            
           
            
            //fine codice david
            break;
            
    }
}

//metodo aggiunto david
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
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
            return [NSString stringWithFormat:@"  %@ - %@", [f stringFromDate:_data], _slot];
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
    
    if (![self isValidEmail:_email.text] && ![_email.text isEqual:@""]) {
        //allest malformed mail
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
        complete.general = [NSString stringWithFormat:@"Informazioni personali:\n%@ %@\n%@\n%@", _nome.text, _cognome.text, _email.text, _cellulare.text];
        
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"EEEE dd MMMM yyyy"];
        NSString *data = [[NSString stringWithFormat:@"%@ - %@", [f stringFromDate:_data], _slot] capitalizedString];
        
        complete.reservation = ([_pNumber isEqualToString:@"Scolaresca"]) ? [NSString stringWithFormat:@"Visita prenotata per il giorno %@ per una scolaresca", data] : [NSString stringWithFormat:@"Visita prenotata per il giorno %@ per gruppo di %@ persone", data, _pNumber];
    
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
