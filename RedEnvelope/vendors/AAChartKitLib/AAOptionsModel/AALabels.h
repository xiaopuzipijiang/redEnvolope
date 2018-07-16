//
//  AALabels.h
//  AAChartKit
//
//  Created by An An on 17/3/1.
//  Copyright © 2017年 An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * 🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/7842508/codeforu
 * JianShu       : http://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import <Foundation/Foundation.h>

@class AAStyle;
@interface AALabels : NSObject

AAPropStatementAndPropSetFuncStatement(assign, AALabels, BOOL, enabled);
AAPropStatementAndPropSetFuncStatement(assign, AALabels, NSString *, fontSize);
AAPropStatementAndPropSetFuncStatement(assign, AALabels, NSString *, fontColor);
AAPropStatementAndPropSetFuncStatement(assign, AALabels, NSString *, fontWeight);
AAPropStatementAndPropSetFuncStatement(strong, AALabels, AAStyle  *, style);
AAPropStatementAndPropSetFuncStatement(strong, AALabels, NSString *, format);


@end
