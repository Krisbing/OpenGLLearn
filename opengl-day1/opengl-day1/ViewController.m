//
//  ViewController.m
//  opengl-day1
//
//  Created by 贺兵 on 16/11/21.
//  Copyright © 2016年 贺兵. All rights reserved.
//

#import "ViewController.h"
typedef struct {
    
    GLKVector3 positionCoords;
    
} SceneVertex;

static const SceneVertex vertexs[] = {
    {{-0.5f, -0.5, 0.0}},
    {{0.5f, -0.5, 0.0}},
    {{-0.5f, 0.5, 0.0}}
};

@interface ViewController ()
{
    GLuint vertexBufferId;
}

@property (nonatomic, strong) GLKBaseEffect *baseEffect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

    [self createOpenGl];


}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    GLKView *view = (GLKView *)self.view;
    [EAGLContext setCurrentContext:view.context];
    
    if (0 != vertexBufferId) {
        
        glDeleteBuffers(1, &vertexBufferId);
        vertexBufferId = 0;
    }
    ((GLKView *)self.view).context = nil;
    [EAGLContext setCurrentContext:nil];
}
- (void)createOpenGl
{
    GLKView *view = (GLKView *)self.view;
    NSAssert([view isKindOfClass:[GLKView class]], @"controllers view is not GLKView");
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];//创建上下文实例
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    //RGBA
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);//设置图形显示的颜色
    
    glClearColor(0.0, 0.0, 0.0, 1.0f);//backgroundColor,上下文的清除颜色
    
    glGenBuffers(1, &vertexBufferId);//为缓存生成一个标识符
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferId);//为接下来的运算绑定缓存
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexs), vertexs, GL_STATIC_DRAW);//复制数据到缓存中
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    
    [self.baseEffect prepareToDraw];
    glClear(GL_COLOR_BUFFER_BIT);
    //启动
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL);
    //执行绘图
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

@end
