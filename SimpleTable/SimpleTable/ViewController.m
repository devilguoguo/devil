//
//  ViewController.m
//  Simple Table
//
//  Created by devil on 15/9/15.
//  Copyright (c) 2015年 devil. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"

static NSString *CellTableIdentifier = @"CellTableIdentifier";
BOOL isResultShow = NO;
@interface ViewController ()

@property (copy, nonatomic) NSArray *dwarves;
@property (copy, nonatomic) NSArray *computers;
@property (copy, nonatomic) NSDictionary *names;
@property (copy, nonatomic) NSArray *keys;
@property (strong, nonatomic) NSMutableArray *filteredNames;
@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation ViewController

//加载完视图做一些额外的处理
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dwarves = @[@"测试数据1",@"测试数据2",@"测试数据3",@"测试数据4",@"测试数据5",@"测试数据6",@"测试数据7",@"测试数据8",@"测试数据9",@"测试数据10",@"测试数据11",@"测试数据12",@"测试数据13",@"测试数据14",@"测试数据15",@"测试数据16",@"测试数据17",@"测试数据18",@"测试数据19",@"测试数据20"];
    self.computers = @[@{@"Name":@"MacBook Air",@"Color":@"silver"},
                       @{@"Name":@"MacBook Pro",@"Color":@"silver"},
                       @{@"Name":@"iMac",@"Color":@"silver"},
                       @{@"Name":@"Mac Mini",@"Color":@"silver"},
                       @{@"Name":@"Mac Pro",@"Color":@"Black"}];
    
    UITableView *tableView = (id)[self.view viewWithTag:1];
//    [tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:CellTableIdentifier];
    tableView.rowHeight = 65;
    //自定义的表单元 重用标识符
    UINib *nib = [UINib nibWithNibName:@"MyTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    //数据模型 属性列表
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
    self.keys = [[self.names allKeys] sortedArrayUsingSelector:@selector(compare:)];//选取器 响应消息

//    if (tableView.style == UITableViewStylePlain) {
//        UIEdgeInsets contentInset = tableView.contentInset;
//        contentInset.top = 20;
//        [tableView setContentInset:contentInset];
//        
//        UIView *barBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
//        barBackground.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
//        [self.view addSubview:barBackground];
//    }
    
    self.filteredNames = [NSMutableArray array];
    //搜索控件添加
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    tableView.tableHeaderView = searchBar;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    self.searchController.searchBar.tintColor = [UIColor orangeColor];  //设置渲染颜色
//    self.searchController.searchBar.barTintColor = [UIColor orangeColor];    //设置状态条颜色
    self.searchController.dimsBackgroundDuringPresentation = NO;    //设置开始搜索时背景显示与否（很重要）
    [self.searchController.searchBar sizeToFit];    //适应整个屏幕
    self.searchController.searchResultsUpdater = self;  //设置显示搜索结果的控制器
//    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x,
//                                                       self.searchController.searchBar.frame.origin.y,
//                                                       self.searchController.searchBar.frame.size.width, 44);
    //将搜索控制器的搜索条设置为页眉视图
    tableView.tableHeaderView = self.searchController.searchBar;
    
    //设置分区索引的颜色
//    tableView.sectionIndexBackgroundColor = [UIColor blackColor];
//    tableView.sectionIndexTrackingBackgroundColor = [UIColor darkGrayColor];
//    tableView.sectionIndexColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark TableView Data Source Methods
//数据源协议方法
//分区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!isResultShow) {
        return [self.keys count];
    } else {
        return 1;
    }
}

//每个分区对应的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!isResultShow) {
        NSString *key = self.keys[section];
        NSArray *nameSection = self.names[key];
        return [nameSection count];
    } else {
        return [self.filteredNames count];
    }
}

//分区的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!isResultShow) {
        return self.keys[section];
    } else {
        return nil;
    }
}

//每一条表单元的内容配置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
//    }
//    UIImage *image = [UIImage imageNamed:@"star"];
//    cell.imageView.image = image;
//    cell.textLabel.text = self.dwarves[indexPath.row];
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:50];
//    if (indexPath.row < 7) {
//        cell.detailTextLabel.text = @"前排";
//    } else {
//        cell.detailTextLabel.text = @"后排";
//    }
    //通过队列重用表单元的标识符来添加单元格
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    if (!isResultShow) {
        NSString *key = self.keys[indexPath.section];
        NSArray *nameSection = self.names[key];
        //    NSDictionary *rowData = self.computers[indexPath.row];
        cell.name = nameSection[indexPath.row];//rowData[@"Name"];
    } else {
        cell.name = self.filteredNames[indexPath.row];
    }
    
    cell.color = @"Silver";//rowData[@"Color"];
    return cell;
}

#pragma mark TableView Delegate Methods
//代理协议方法
//设置缩进
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row;
}
//设置选中与否
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowValue = self.names[self.keys[indexPath.section]][indexPath.row];//self.dwarves[indexPath.row];
    NSString *message = [[NSString alloc] initWithFormat:@"你选择的是：%@",rowValue];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"选中的行" message:message delegate:nil cancelButtonTitle:@"好的，我知道了" otherButtonTitles:nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        return nil;
    } else {
        return indexPath;
    }
}
//选中某行触发消息
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
//行高
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 70;
//}

//右侧添加一个索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!isResultShow) {
        return self.keys;
    } else {
        return nil;
    }
}

#pragma mark UISearchResultsUpdating Delegate Methods
//代理协议方法
//当搜索框称为第一响应者时触发
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.filteredNames removeAllObjects];
    NSString *searchingString = self.searchController.searchBar.text;
    if (searchingString.length > 0) {
        isResultShow = YES;
        //谓词，判断名字与搜索字符串是否匹配
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *name,NSDictionary *b){
            //如果能够在名字中找到搜索字符串到起始位置，就说明这个名字与搜索字符串匹配  条件是：不区分大小写
            NSRange range = [name rangeOfString:searchingString options:NSCaseInsensitiveSearch];
            return range.location != NSNotFound;
        }];
        for (NSString *key in self.keys) {
            //对于每一个键都适用这个谓词进行测试，并将匹配对名字添加到filterdNames数组中
            NSArray *matches = [self.names[key] filteredArrayUsingPredicate:predicate];
            [self.filteredNames addObjectsFromArray:matches];
        }
    }
    else {
        isResultShow = NO;
    }
    //重新加载数据
    UITableView *tableView = (id)[self.view viewWithTag:1];
    [tableView reloadData];
}

@end
