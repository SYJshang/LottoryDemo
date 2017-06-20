//
//  coreTextView.m
//  富文本
//
//  Created by 韩天旭 on 16/4/5.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import "coreTextView.h"
#import <CoreText/CoreText.h>
@implementation coreTextView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self coreText];
}

- (void)coreText{
    /**
     CoreText 框架中最常用的几个类：
     有兴趣的请查阅资料
     
     
     CTFont
     CTFontCollection
     CTFontDescriptor
     CTFrame
     CTFramesetter
     CTGlyphInfo
     CTLine
     CTParagraphStyle
     CTRun
     CTTextTab
     CTTypesetter
     
     
     //kCTFontAttributeName 这个键是字体的名称 必须传入CTFont对象
     //kCTKernAttributeName 这个键设置字体间距 传入必须是数字对象 默认为0
     //kCTLigatureAttributeName  这个键设置连字方式 必须传入CFNumber对象
     //kCTParagraphStyleAttributeName  段落对其方式
     //kCTForegroundColorAttributeName 字体颜色 必须传入CGColor对象
     //kCTStrokeWidthAttributeName 笔画宽度 必须是CFNumber对象
     //kCTStrokeColorAttributeName 笔画颜色
     //kCTSuperscriptAttributeName 控制垂直文本定位 CFNumber对象
     //kCTUnderlineColorAttributeName 下划线颜色
     */
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    //开始编辑
    [text beginEditing];
    
    //设置字体属性
    //参数1.字体的名字 参数2.字体的大小 参数3.字体的变换矩阵。在大多数情况下,将该参数设置为NULL。
    CTFontRef font = CTFontCreateWithName(CFSTR("Optima-Regular"),16, NULL);
    [text addAttribute:(id)kCTFontAttributeName value:(__bridge id _Nonnull)(font) range:NSMakeRange(0, text.length)];
    
    
    //设置字体间隔
    long number = 5;
    
    //参数1.allocator:通过NULL或kCFAllocatorDefault使用默认的分配器。
    //参数2.theType:通过CFNumber用来显示一个值的数据类型
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    
    //kCTKernAttributeName:字距调整
    [text addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(37, 6)];
    
    //设置字体颜色
    //kCTForegroundColorAttributeName:文本的前景颜色。该属性的值必须是一个CGColor对象。默认值是黑色
    [text addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, text.length)];

    //设置空心字
    long number2 = 3;
    CFNumberRef num2 = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number2);
    [text addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id) num2 range:NSMakeRange(0, text.length)];
    
    //设置空心字颜色
//    [text addAttribute:(id)kCTStrokeColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(16, 16)];
    
//    //设置斜体字
    CTFontRef font2 = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:25].fontName, 30, NULL);
    [text addAttribute:(id)kCTFontAttributeName value:(__bridge id _Nonnull)(font2) range:NSMakeRange(0, 5)];
    
    //下划线
    [text addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] range:NSMakeRange(0, 5)];
    
    //下划线颜色
    [text addAttribute:(id)kCTUnderlineColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, 5)];
    
    //对同一段字体进行多属性设置
    //黑色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(id)[UIColor blackColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
    //斜体
    CTFontRef font3 = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 20, NULL);
    [attributes setObject:(__bridge id)font3 forKey:(id)kCTFontAttributeName];
//    //下划线
//    [attributes setObject:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] forKey:(id)kCTUnderlineStyleAttributeName];
    
    [text addAttributes:attributes range:NSMakeRange(0, 5)];
//
//    //结束编辑
    [text endEditing];

    
    
    //绘图,渲染
    
    //设置绘制文字区域
    CGMutablePathRef Path = CGPathCreateMutable();
    
    CGPathAddRect(Path, NULL ,self.bounds);
    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)text);
    
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, text.length), Path, NULL);
    
    //获取当前(View)上下文以用于之后的绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Flip the coordinate system
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    
    //x，y轴方向移动
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    //绘制
    CTFrameDraw(frame,context);
    
    //清理资源
    CGPathRelease(Path);
    CFRelease(framesetter);
}


@end
