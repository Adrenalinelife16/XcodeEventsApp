//
//  FilterViewController.m
//  Adrenaline Life
//
//  Created by Michael Cather on 8/11/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import "FilterViewController.h"
#import "ProgramViewController.h"


@interface FilterViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *pickerNames;
@property (nonatomic, copy) NSString* selectedCellText;

@property (strong, nonatomic) IBOutlet UITextField *filterDay;



@end

@implementation FilterViewController
@synthesize selectedCellText;




- (void)viewDidLoad {

     [super viewDidLoad];
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;     //#2
    self.pickerView.dataSource = self;   //#2
    
    /*
    self.filterDay= [[UITextField alloc] initWithFrame:CGRectMake(0, 110, 250, 30)];
    self.filterDay.borderStyle = UITextBorderStyleLine;
    self.filterDay.placeholder = @"Filter by day of the week";
    self.filterDay.backgroundColor = [UIColor whiteColor];
    self.filterDay.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.filterDay.textAlignment = NSTextAlignmentCenter;
    */
    self.filterDay.inputView = self.pickerView;
    
    self.pickerNames = @[ @"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"];
    
    [self.view addSubview:self.filterDay];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.tabBarController.tabBar setHidden:YES];
    
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    [self.navigationItem setTitle:@"Filter"];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    
    [[UIBarButtonItem appearance] setTintColor:COMMON_COLOR_RED];
    
    [toolBar setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.filterDay.inputAccessoryView = toolBar;
    
}

- (void)doneTouched:(UIBarButtonItem *)sender {

    [self.filterDay resignFirstResponder];
    
}

#pragma mark - UIPickerViewDataSource

// #3
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.pickerView) {
        return 1;
    }
    
    return 0;
}

// #4
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        return [self.pickerNames count];
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate

// #5
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        return self.pickerNames[row];
    }
    
    return nil;
}

// #6
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        self.filterDay.text = self.pickerNames[row];
    }
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [daysOfWeek count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"DaysofWeek";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    cell.textLabel.text = [daysOfWeek objectAtIndex:indexPath.row];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCellText = cell.textLabel.text;
    
    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dismissFilter:(id)sender {
    
         [self performSegueWithIdentifier:@"filterDays" sender:sender];
    
}
/*

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"filterDays"]) {
        ProgramViewController *destinationView = [segue destinationViewController];
        NSIndexPath *selectedIndexPath = [self.tblPopup indexPathForSelectedRow];
        UITableViewCell *cell = [self.tblPopup cellForRowAtIndexPath:selectedIndexPath];
        destinationView.filterText = cell.textLabel.text;
      //  [destinationView filterProgramArray];

    }
}
*/



@end
