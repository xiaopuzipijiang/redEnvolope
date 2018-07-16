//
//  WalletIncomingChartCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/15.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WalletIncomingChartCell.h"

@interface WalletIncomingChartCell ()

@property (nonatomic, strong) AAChartView *chart;

@end

@implementation WalletIncomingChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.chart = [[AAChartView alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 300.0)];
        self.chart.backgroundColor = [UIColor yellowColor];
//        self.chart.userInteractionEnabled = NO;
        [self.contentView addSubview:self.chart];

        [self.chart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            make.height.mas_equalTo(300);
        }];
    }
    
    return self;
}

- (void)setupData
{

    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeAreaspline)//图表类型
    .titleSet(@"")//图表主标题
    .subtitleSet(@"")//图表副标题
//    .yAxisLineWidthSet(@-1)//Y轴轴线线宽为0即是隐藏Y轴轴线
    .colorsThemeSet(@[@"#fe117c",@"#ffc069",@"#06caf4",@"#7dffc0"])//设置主体颜色数组
    .categoriesSet(@[@"7.1", @"7.2", @"7.3", @"7.4", @"7.5", @"7.6", @"7.7", @"7.8"])
    .yAxisTitleSet(@"")//设置 Y 轴标题
//    .invertedSet(YES)
//    .tooltipEnabledSet(NO)
//    .tooltipValueSuffixSet(@"℃")//设置浮动提示框单位后缀
    .legendEnabledSet(NO)
    .backgroundColorSet(@"#4b2b7f")
    .yAxisGridLineWidthSet(@0.5)//y轴横向分割线宽度为0(即是隐藏分割线)
    .xAxisGridLineWidthSet(@0.5)
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2017")
                 .dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5])
                 ]
               );
//    [self configureTheStyleForDifferentTypeChart];//为不同类型图表设置样式
    
    /*配置 Y 轴标注线,解开注释,即可查看添加标注线之后的图表效果(NOTE:必须设置 Y 轴可见)*/
    //    [self configureTheYAxisPlotLineForAAChartView];
    
    [self.chart aa_drawChartWithChartModel:aaChartModel];}


@end
