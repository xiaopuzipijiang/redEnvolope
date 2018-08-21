//
//  WalletIncomingChartCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/15.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WalletIncomingChartCell.h"
#import "TrendInfo.h"
#import <XJYChart/XJYChart.h>

@interface WalletIncomingChartCell ()

//@property (nonatomic, strong) AAChartView *chart;

@property (nonatomic, strong) UIImageView *backView;

@end

@implementation WalletIncomingChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        self.chart = [[AAChartView alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 300.0)];
//        self.chart.backgroundColor = [UIColor yellowColor];
//        self.chart.userInteractionEnabled = NO;
        self.backView = [[UIImageView alloc] init];
//        self.backView.backgroundColor = HEXCOLOR(0xb6b6b6);
        
        [self.contentView addSubview:self.backView];

        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            make.height.mas_equalTo(300);
        }];
    }
    
    return self;
}

- (void)setTrendInfo:(TrendInfo *)trendInfo
{
//
//
//    AAChartModel *aaChartModel= AAObject(AAChartModel)
//    .chartTypeSet(AAChartTypeAreaspline)//图表类型
//    .titleSet(@"")//图表主标题
//    .subtitleSet(@"")//图表副标题
////    .yAxisLineWidthSet(@-1)//Y轴轴线线宽为0即是隐藏Y轴轴线
////    .colorsThemeSet(@[@"#fe117c",@"#ffc069",@"#06caf4",@"#7dffc0"])//设置主体颜色数组
//    .categoriesSet(trendInfo.dataArray)
//    .yAxisTitleSet(@"")//设置 Y 轴标题
////    .invertedSet(YES)
////    .tooltipEnabledSet(NO)
////    .tooltipValueSuffixSet(@"℃")//设置浮动提示框单位后缀
//    .legendEnabledSet(NO)
//    .backgroundColorSet(@"#b6b6b6")
////    .yAxisGridLineWidthSet(@(trendInfo.max))//y轴横向分割线宽度为0(即是隐藏分割线)
////    .xAxisGridLineWidthSet(@(trendInfo.min))
//    .seriesSet(@[
//                 AAObject(AASeriesElement)
//                 .dataSet(trendInfo.trendArray)
//                 ]
//               );
////    [self configureTheStyleForDifferentTypeChart];//为不同类型图表设置样式
//
//    /*配置 Y 轴标注线,解开注释,即可查看添加标注线之后的图表效果(NOTE:必须设置 Y 轴可见)*/
//    //    [self configureTheYAxisPlotLineForAAChartView];
//
//    [self.chart aa_drawChartWithChartModel:aaChartModel];
    XLineChart *view = [self.contentView viewWithTag:110];
    
    if (view || !trendInfo) {
        return;
    }
    
    NSMutableArray* itemArray = [[NSMutableArray alloc] init];
    NSMutableArray* numberArray = [NSMutableArray new];
    numberArray = [trendInfo.trendArray mutableCopy];
    
    XLineChartItem* item = [[XLineChartItem alloc] initWithDataNumberArray:numberArray
                                              color:XJYPinkGrey];
    [itemArray addObject:item];
    
    XAreaLineChartConfiguration* configuration =
    [[XAreaLineChartConfiguration alloc] init];
//    configuration.isShowPoint = YES;
    configuration.lineMode = CurveLine;
    configuration.ordinateDenominator = 6;
//    configuration.isEnableNumberLabel = YES;
    configuration.chartBackgroundColor = HEXCOLOR(0xfbfbfb);
    CGFloat top = trendInfo.max + 0.000001;
    XLineChart* lineChart =
    [[XLineChart alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 280)
                        dataItemArray:itemArray
                    dataDiscribeArray:[NSMutableArray arrayWithArray:trendInfo.dataArray]
                            topNumber:@(top)
                         bottomNumber:@(trendInfo.min)
                            graphMode:AreaLineGraph
                   chartConfiguration:configuration];
    lineChart.isAllowGesture = YES;
    lineChart.tag = 110;
    lineChart.userInteractionEnabled = NO;
    [self.contentView addSubview:lineChart];
}


@end
