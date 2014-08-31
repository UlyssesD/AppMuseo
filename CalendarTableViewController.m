//
//  CalendarTableViewController.m
//  ariProva
//
//  Created by Ulysses D. on 22/07/14.
//  Copyright (c) 2014 Ulysses D. All rights reserved.
//

#import "CalendarTableViewController.h"
#import "DSLCalendarView.h"
#import "DataSetTableViewController.h"



@interface CalendarTableViewController () <DSLCalendarViewDelegate>
@property (strong, nonatomic) IBOutlet DSLCalendarView *calendar;
@property (weak, nonatomic) NSString* turn;
@property (strong, nonatomic) NSDate* date;

@end


@implementation CalendarTableViewController

NSMutableArray *jsonArray;

@synthesize pNumber = _pNumber;



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
    
    
    self.calendar.delegate = self;
    
    NSLog(@"Passed: %@", _pNumber);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSURL *url=[NSURL URLWithString:@"http://www.sapienzaapps.it/saccopastore/retrieveReservation.php"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calendarView:(DSLCalendarView *)calendarView didSelectRange:(DSLCalendarRange *)range {
    if (range != nil) {
        NSLog( @"Selected %d/%d - %d/%d", range.startDay.day, range.startDay.month, range.endDay.day, range.endDay.month);
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"dd MMMM"];
        _date = range.startDay.date;

        NSDateFormatter *f2 = [[NSDateFormatter alloc] init];
        [f2 setDateFormat:@"yyyy-MM-dd"];
        NSString *fData2 = [f2 stringFromDate:_date];
        
        NSString *controlla = [self checkData :fData2];
        NSString *testo = [NSString stringWithFormat:@"%@", [f stringFromDate:range.startDay.date]];

        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle: testo
                                      delegate: self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles: nil];
        
        if ([controlla isEqual:@"full"])
        {
            
            [actionSheet addButtonWithTitle:@"Annulla"];
            
            actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1;
        }
        else if ([controlla isEqual:@"Mattina"])
        {
            [actionSheet addButtonWithTitle:@"Pomeriggio"];
            [actionSheet addButtonWithTitle:@"Annulla"];
            
            actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1;
        }
        else if ([controlla isEqual:@"Pomeriggio"])
        {
            [actionSheet addButtonWithTitle:@"Mattina"];
            [actionSheet addButtonWithTitle:@"Annulla"];
            
            actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1;
        }
        else
        {
            [actionSheet addButtonWithTitle:@"Mattina"];
            [actionSheet addButtonWithTitle:@"Pomeriggio"];
            [actionSheet addButtonWithTitle:@"Annulla"];
            
            actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1;
        }
        
        
        

        [actionSheet showInView:self.view];
    }
    else {
        NSLog( @"No selection" );
    }
}

-(NSString *)checkData: (NSString *) dataSelected{

    NSString *ritorno=@"libero";

    for (int i=0;i<jsonArray.count;i++)
    {
        
        NSString *dataJson = [[jsonArray objectAtIndex:i] objectForKey:@"data"];
        NSString *slotJson = [[jsonArray objectAtIndex:i] objectForKey:@"mattinapomeriggio"];

        if([dataSelected isEqual:dataJson])
        {
            
            if ([slotJson  isEqual: @"full"])
            {
                ritorno=slotJson;
                break;
            }
            else if([slotJson  isEqual: @"Mattina"] || [slotJson  isEqual: @"Pomeriggio"])
            {
                ritorno=slotJson;
                break;
            }
            
        }
        
        
    }
    return ritorno;

}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSDateFormatter *f2 = [[NSDateFormatter alloc] init];
    [f2 setDateFormat:@"yyyy-MM-dd"];
    NSString *fData2 = [f2 stringFromDate:_date];
    NSString *controlla = [self checkData :fData2];
    
    if ([controlla isEqual:@"full"]) {

    }
    else if ([controlla isEqual:@"Mattina"]){
            switch (buttonIndex) {
                case 0:
                    NSLog(@"Clicked Mattina");
                    _turn = @"Mattina";
                    [self performSegueWithIdentifier:@"Passo3" sender:self];
                    break;
            }
    }
    else if ([controlla isEqual:@"Pomeriggio"]){
        switch (buttonIndex) {
            case 0:
                NSLog(@"Clicked Pomeriggio");
                _turn = @"Pomeriggio";
                [self performSegueWithIdentifier:@"Passo3" sender:self];
                break;
        }
    }
    else if ([controlla isEqual:@"libero"]){
        switch (buttonIndex) {
            case 0:
                NSLog(@"Clicked Mattina");
                _turn = @"Mattina";
                [self performSegueWithIdentifier:@"Passo3" sender:self];
                break;
            case 1:
                NSLog(@"Clicked Pomeriggio");
                _turn = @"Pomeriggio";
                [self performSegueWithIdentifier:@"Passo3" sender:self];
                break;
        }
    }


    
}

- (DSLCalendarRange*)calendarView:(DSLCalendarView *)calendarView didDragToDay:(NSDateComponents *)day selectingRange:(DSLCalendarRange *)range {
    if (YES) { // Only select a single day
        return [[DSLCalendarRange alloc] initWithStartDay:day endDay:day];
    }
    else if (YES) { // Don't allow selections before today
        NSDateComponents *today = [[NSDate date] dslCalendarView_dayWithCalendar:calendarView.visibleMonth.calendar];
        
        NSDateComponents *startDate = range.startDay;
        NSDateComponents *endDate = range.endDay;
        
        if ([self day:startDate isBeforeDay:today] && [self day:endDate isBeforeDay:today]) {
            return nil;
        }
        else {
            if ([self day:startDate isBeforeDay:today]) {
                startDate = [today copy];
            }
            if ([self day:endDate isBeforeDay:today]) {
                endDate = [today copy];
            }
            
            return [[DSLCalendarRange alloc] initWithStartDay:startDate endDay:endDate];
        }
    }
    
    return range;
}

- (void)calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration {
    NSLog(@"Will show %@ in %.3f seconds", month, duration);
}

- (void)calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents *)month {
    NSLog(@"Now showing %@", month);
}

- (BOOL)day:(NSDateComponents*)day1 isBeforeDay:(NSDateComponents*)day2 {
    return ([day1.date compare:day2.date] == NSOrderedAscending);
}



#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
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
    DataSetTableViewController *stepThree = segue.destinationViewController;
    stepThree.pNumber = _pNumber;
    stepThree.data = _date;
    stepThree.slot = _turn;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
