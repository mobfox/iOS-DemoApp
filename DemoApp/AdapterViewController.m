//
//  AdapterViewController.m
//  DemoApp
//
//  Created by ofirkariv on 26/09/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "AdapterViewController.h"

@interface AdapterViewController ()

@end

@implementation AdapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.invh.length == 0)
    [self setInvh:ADMOB_HASH_GAD_BANNER];
    self.loadTextField.placeholder = self.invh;
    self.loadTextField.text = self.invh;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(dismissKeyboard)]];
}

-(void)dismissKeyboard {
    [self.loadTextField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"adMobToScan"]){
        ScanHashViewController *vc = [segue destinationViewController];
        vc.vcType = [segue identifier];
        vc.segueIdentify = @"scanToAdMob";
    }
}


@end
