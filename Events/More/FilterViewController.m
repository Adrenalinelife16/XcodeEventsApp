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
    
    self.pickerView = [[UIPickerView alloc]init];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
   
    
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

    
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneTouched:)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
  
    doneBtn.tintColor = [UIColor whiteColor];

    self.filterDay.inputAccessoryView = toolBar;
    
}

- (void)doneTouched:(UIBarButtonItem *)sender {

    [self.filterDay resignFirstResponder];
    
}

#pragma mark - UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.pickerView) {
        return 1;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        return [self.pickerNames count];
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        return self.pickerNames[row];
    }
    
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        self.filterDay.text = self.pickerNames[row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return (40.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dismissFilter:(id)sender {
    
         [self performSegueWithIdentifier:@"filterDays" sender:sender];
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
     NSString *filteredDay = [_filterDay text];
    
    
    
    if ([[segue identifier] isEqualToString:@"filterDays"]) {
        ProgramViewController *destinationView = [segue destinationViewController];
        destinationView.filterText = filteredDay;
        
    }
}

@end
