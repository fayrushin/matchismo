//
//  HistoryViewController.m
//  matchismo
//
//  Created by Равил Файрушин on 18.08.15.
//  Copyright (c) 2015 Равил Файрушин. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

- (void)setHistory:(NSArray *)history
{
    _history = history;
    if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateUI
{
    if ([[self.history firstObject] isKindOfClass:[NSAttributedString class]]) {
        NSMutableAttributedString *historyText = [[NSMutableAttributedString alloc] init];
        int i = 1;
        for (NSAttributedString *line in self.history) {
            [historyText appendAttributedString:[[NSAttributedString alloc]
                                                 initWithString:[NSString stringWithFormat:@"%2d: ", i++]]];
            [historyText appendAttributedString:line];
            [historyText appendAttributedString:[[NSAttributedString alloc]
                                                 initWithString:@"\n\n" ]];
        }
        UIFont *font = [self.historyTextView.textStorage attribute:NSFontAttributeName
                                                           atIndex:0
                                                    effectiveRange:NULL];
        [historyText addAttribute:NSFontAttributeName value:font
                            range:NSMakeRange(0, historyText.length)];
        self.historyTextView.attributedText = historyText;
    } else {
        NSString *historyText = @"";
        int i = 1;
        for (NSString *line in self.history) {
            historyText = [NSString stringWithFormat:@"%@%2d: %@\n\n", historyText, i++, line];
        }
        self.historyTextView.text = historyText;
    }
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
