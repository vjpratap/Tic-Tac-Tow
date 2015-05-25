//
//  TicTacTowViewController.m
//  Tic-Tac-Tow
//
//  Created by Vijay Pratap Singh on 21/05/15.
//  Copyright (c) 2015 thoughtworks. All rights reserved.
//

#import "TicTacTowViewController.h"

@interface TicTacTowViewController ()

//@property(strong, nonatomic) NSArray *indexingForArray;
@property(strong, nonatomic) NSMutableArray *fillMark;
@property NSInteger count;
@property (weak, nonatomic) IBOutlet UILabel *showNameOfUser;

@end

@implementation TicTacTowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fillMark = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
//    self.fillMark = [NSArray arrayWithObjects:@"", nil];
    self.count = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)checkColumn:(NSString*)playerMark{
    for(int row = 0; row < 3; row++){
        BOOL won = YES;
        for (int col = 0; col < 3; col++) {
            won = won && ([self.fillMark[row * 3 + col] isEqualToString:playerMark]);
        }
        if (won)
            return YES;
    }
    return NO;
}

-(BOOL)isWin :(NSString*)playerMark{
    return [self checkColumn : playerMark];
}

- (void) afterTabbingActions: (NSArray *)mark{
    NSString *player = @"Player . term";
    self.count++;
    [self.showNameOfUser setText:[player stringByReplacingOccurrencesOfString:@"." withString:mark[self.count%2]]];
}

- (IBAction)buttonTabbed:(id)sender {
    NSArray *mark = @[@"X",@"O"];
    [sender setTitle:mark[self.count%2] forState:UIControlStateNormal];
    [sender setEnabled:NO];
    [self.fillMark replaceObjectAtIndex:[sender tag] withObject:mark[self.count%2]];
    if ([self isWin:mark[self.count%2]]) {
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil message:@"You Won" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [toast show];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
        
    }
    
    [self afterTabbingActions : mark];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
