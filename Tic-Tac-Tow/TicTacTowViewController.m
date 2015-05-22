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
- (IBAction)buttonTabbed:(id)sender {
    NSArray *mark = @[@"X",@"O"];
    [sender setTitle:mark[self.count%2] forState:UIControlStateNormal];
    [self.fillMark replaceObjectAtIndex:[sender tag] withObject:mark[self.count%2]];
    [sender setEnabled:NO];
    self.count++;
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
