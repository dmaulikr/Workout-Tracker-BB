//
//  StoreListTVC.m
//  90 DWT BB
//
//  Created by Grant, Jared on 9/16/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "StoreListTVC.h"
#import "StoreListTVCCell.h"
#import "90DWTBBIAPHelper.h"
#import "IAPProduct.h"
@import StoreKit;

@interface StoreListTVC ()

@end

@implementation StoreListTVC {
    
    NSArray * _products;
    NSNumberFormatter * _priceFormatter;
}

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
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Store";
    
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self reload];
    [self.refreshControl beginRefreshing];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)reload {
    
    _products = nil;
    [self.tableView reloadData];
    [[_0DWTBBIAPHelper sharedInstance]
     
     requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
         
         if (success) {
             _products = products;
             [self.tableView reloadData];
         }
         
         [self.refreshControl endRefreshing];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreListTVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    IAPProduct *product = _products[indexPath.row];
    cell.titleLabel.text = product.skProduct.localizedTitle;
    cell.descriptionLabel.text = product.skProduct.localizedDescription;
    [_priceFormatter setLocale:product.skProduct.priceLocale];
    cell.priceLabel.text = [_priceFormatter stringFromNumber:product.skProduct.price];
    
    cell.priceLabel.textColor = [UIColor colorWithRed:48/255.0f green:137/255.0f blue:210/255.0f alpha:1];
    
    return cell;
    
    /*
    SKProduct * product = (SKProduct *) _products[indexPath.row];
    [_priceFormatter setLocale:product.priceLocale];
    
    cell.titleLabel.text = product.localizedTitle;
    cell.descriptionLabel.text = product.localizedDescription;
    cell.priceLabel.text = [_priceFormatter stringFromNumber:product.price];
    
    cell.priceLabel.textColor = [UIColor colorWithRed:48/255.0f green:137/255.0f blue:210/255.0f alpha:1];
    
    if ([[_0DWTBBIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.buyButton.hidden = YES;
        
    } else {
        
        [cell.buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // Configure tableview.
    NSArray *tableCell = @[cell];
    NSArray *accessoryIcon = @[@NO];
    NSArray *cellColor = @[@NO];
    
    [self configureStoreTableView:tableCell :accessoryIcon :cellColor];
    */
    
    return cell;
}

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
