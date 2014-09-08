//
//  DataSetTableViewController.h
//  ariProva
//
//  Created by Ulysses D. on 22/07/14.
//  Copyright (c) 2014 Ulysses D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataSetTableViewController : UITableViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *info;
    @property (weak, nonatomic) IBOutlet UIButton *submit;
    @property (strong, nonatomic) IBOutlet UITextField *nome;
    @property (strong, nonatomic) IBOutlet UITextField *cognome;
    @property (strong, nonatomic) IBOutlet UITextField *email;
    @property (strong, nonatomic) IBOutlet UITextField *cellulare;

    //Variabili di prenotazione
    @property (strong, nonatomic) NSString* pNumber;
    @property (strong, nonatomic) NSDate* data;
    @property (strong, nonatomic) IBOutlet UILabel *notes;
    @property (strong, nonatomic) NSString* slot;
@end
