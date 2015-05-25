//
//  TicTacTowViewController.m
//  Tic-Tac-Tow
//
//  Created by Vijay Pratap Singh on 21/05/15.
//  Copyright (c) 2015 thoughtworks. All rights reserved.
//

#import "TicTacTowViewController.h"
#import "WelcomeViewController.h"

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

-(BOOL)checkStraightLines:(NSString*)playerMark rowMultiplyer:(NSInteger) rowMultiplyer columnMultiplyer:(NSInteger)columnMultiplyer{
    for(int row = 0; row < 3; row++){
        BOOL won = YES;
        for (int col = 0; col < 3; col++) {
            won = won && ([self.fillMark[row * rowMultiplyer + col * columnMultiplyer] isEqualToString:playerMark]);
        }
        if (won)
            return YES;
    }
    return NO;
}

-(BOOL)checkDiognals : (NSString *)playerMark{
    BOOL leftDiognal = YES;
    BOOL rightDiognal = YES;

    for (int i = 0; i < [_fillMark count]; i = i + 4) {
        rightDiognal = rightDiognal && ([self.fillMark[i] isEqualToString:playerMark]);
        leftDiognal = leftDiognal && ([self.fillMark[(i + 4)/2] isEqualToString:playerMark]);
    }
    if (leftDiognal || rightDiognal) {
        return YES;
    }
    return NO;
}

-(BOOL)isWin :(NSString*)playerMark{
    return [self checkStraightLines : playerMark rowMultiplyer: 3 columnMultiplyer: 1] ||
    [self checkStraightLines : playerMark rowMultiplyer: 1 columnMultiplyer: 3] ||
    [self checkDiognals : playerMark];
}

- (void) afterTabbingActions: (NSArray *)mark{
    NSString *player = @"Player . tern";
    self.count++;
    [self.showNameOfUser setText:[player stringByReplacingOccurrencesOfString:@"." withString:mark[self.count%2]]];
}

-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0){
        [[self navigationController] popViewControllerAnimated:YES];
//        [self viewDidLoad];
    }
}

-(void)gameResult:(NSString*)currentMark{
    if ([self isWin:currentMark]) {
        UIAlertView *winMassage = [[UIAlertView alloc] initWithTitle:nil message:[[@"Player " stringByAppendingString:currentMark]stringByAppendingString:@" win"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play Again", nil];
        [winMassage show];
    }
    if (self.count == 8 && ![self isWin:currentMark]) {
        UIAlertView *winMassage = [[UIAlertView alloc] initWithTitle:nil message:@"Match Tie" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play Again", nil];
        [self.showNameOfUser setText:@"Match Tie"];
        [winMassage show];
    }
}

- (IBAction)buttonTabbed:(id)sender {
    NSArray *mark = @[@"X",@"O"];
    NSString *currentMark = mark[self.count%2];
    [sender setTitle:currentMark forState:UIControlStateNormal];
    [sender setEnabled:NO];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.fillMark replaceObjectAtIndex:[sender tag] withObject:currentMark];
    if (self.count >= 4) {
        [self gameResult:currentMark];
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
