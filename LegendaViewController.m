//
//  LegendaViewController.m
//  MuseoAntropologia
//
//  Created by Ulysses D. on 03/09/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "LegendaViewController.h"

@interface LegendaViewController ()

@end

@implementation LegendaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"Create Legenda");
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Load Legenda");
    
    UIView *green = [[UIView alloc] initWithFrame:CGRectMake(8, 18.5, 16, 16)];
    green.backgroundColor = [UIColor colorWithRed:(156/255.0) green:(229/255.0) blue:(92/255.0) alpha:1.0];
    [self.view addSubview:green];
    
    UILabel *free = [[UILabel alloc]initWithFrame:CGRectMake(28, 5, 200, 40)];
    [free setBackgroundColor:[UIColor clearColor]];
    [free setText:@"- entrambi gli slot disponibili;"];
    free.font = [UIFont systemFontOfSize:14.0];
    [[self view] addSubview:free];
    
    UIView *yellow = [[UIView alloc] initWithFrame:CGRectMake(8, 38.5, 16, 16)];
    yellow.backgroundColor = [UIColor colorWithRed:(249/255.0) green:(205/255.0) blue:(54/255.0) alpha:1.0];
    [self.view addSubview:yellow];
    
    UILabel *semi = [[UILabel alloc]initWithFrame:CGRectMake(28, 25, 200, 40)];
    [semi setBackgroundColor:[UIColor clearColor]];
    [semi setText:@"- un solo slot disponibile;"];
    semi.font = [UIFont systemFontOfSize:14.0];
    [[self view] addSubview:semi];
    
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(8, 58.5, 16, 16)];
    red.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(83/255.0) blue:(60/255.0) alpha:1.0];
    [self.view addSubview:red];
    
    UILabel *full = [[UILabel alloc]initWithFrame:CGRectMake(28, 45, 200, 40)];
    [full setBackgroundColor:[UIColor clearColor]];
    [full setText:@"- prenotazione non disponibile;"];
    full.font = [UIFont systemFontOfSize:14.0];
    [[self view] addSubview:full];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
