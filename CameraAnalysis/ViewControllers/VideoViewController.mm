//
//  VideoViewController.m
//  CameraAnalysis
//
//  Created by ChenWei on 2018/3/22.
//  Copyright © 2018年 ChenWei. All rights reserved.
//

#import "VideoViewController.h"
#import "SettingView.h"

#include <opencv2/opencv.hpp>
#include <opencv2/imgcodecs/ios.h>


using namespace std;
@interface VideoViewController () {
    CVHandler *_handler;
    SettingView *_settingView;
    map<string, string> _settingMap;
}

@end

@implementation VideoViewController
@synthesize videoView = _videoView, session = _session;

#pragma mark- Initialize
- (instancetype)initWithTitleName:(NSString *)name{
    self = [super init];
    self.title = name;
    return self;
}

- (instancetype)initWithHandler:(CVHandler *)handler {
    self = [super init];
    _handler = handler;
    self.title =  [NSString stringWithUTF8String:_handler->get_name()];
    
    _settingView = [[SettingView alloc] initWithFrame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width-100, 400) Style:FilterStyle1];
    _settingMap.insert(pair<string, string>("dx","1"));
    _settingMap.insert(pair<string, string>("dy","1"));
    _settingMap.insert(pair<string, string>("ksize","3"));
    _handler->set_setting(_settingMap);
    
    [_settingView setHidden:YES];
    [self.view addSubview:_settingView];

    return self;
}

- (void)configureSession {
    NSError *error = nil;
    [self.session beginConfiguration];
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
//     AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if ( ![self.session canAddInput:videoDeviceInput] ) {
        NSLog(@"Session can't add deviceInput for error: %@",error);
        [self.session commitConfiguration];
        return;
    }
    else {
        [self.session addInput:videoDeviceInput];
        self.videoDevice = videoDevice;
        self.videoDeviceInput = videoDeviceInput;
    }

    AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    videoDataOutput.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    [videoDataOutput setSampleBufferDelegate:self queue:self.sessionQueue];

    if ( ![self.session canAddOutput:videoDataOutput] ) {
        NSLog(@"The session can't add videoDataOutput");
        [self.session commitConfiguration];
        return;
    }
    else {
        [self.session addOutput:videoDataOutput];
        self.videoDataOutput = videoDataOutput;
    }

    AVCaptureConnection *videoCaptureConnection = [videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
    [videoCaptureConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];

    [self.session commitConfiguration];
    if ( [self.session isRunning] ) {
        NSLog(@"Video is Running");
    }
    else {
        [self.session startRunning];
    }
    
}

#pragma mark- ViewController Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    
    self.sessionQueue = dispatch_queue_create("session queue", NULL);
    
    // Check video authorization status. Video access is required and audio access is optional.
    // If audio access is denied, audio is not recorded during movie recording.
    switch ( [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] )
    {
        case AVAuthorizationStatusAuthorized:
        {
            // The user has previously granted access to the camera
            break;
        }
        case AVAuthorizationStatusNotDetermined:
        {
            // The user has not yet been presented with the option to grant video access.
            // We suspend the session queue to delay session running until the access request has completed.
            // Note that audio access will be implicitly requested when we create an AVCaptureDeviceInput for audio during session setup.
//            dispatch_suspend( self.sessionQueue );
//            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^( BOOL granted ) {
//                if ( ! granted ) {
//
//                }
//                dispatch_resume( self.sessionQueue );
//            }];
            break;
        }
        default:
        {
            // The user has previously denied access
            
            break;
        }
    }
    
    dispatch_async(self.sessionQueue, ^{
        [self configureSession];
    });
    
    if ( ![UIDevice currentDevice].isGeneratingDeviceOrientationNotifications ) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    UIBarButtonItem *settinfItem = [[UIBarButtonItem alloc] initWithTitle:@"Setting" style:UIBarButtonItemStylePlain target:self action:@selector(handleSetting:)];
    self.navigationItem.rightBarButtonItem = settinfItem;
    [self addKVO];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.session stopRunning];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self removeKVO];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (BOOL)shouldAutorotate {
    [super shouldAutorotate];
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    [super supportedInterfaceOrientations];
    return UIInterfaceOrientationMaskAll;
}

#pragma mark- Button Action
- (IBAction)handleSetting:(id)sender {
    _settingView.hidden = !_settingView.hidden;
}

#pragma mark- Key-Value-Observer
- (void)addKVO {
    [_settingView addObserver:self forKeyPath:@"dxSlider.value" options:NSKeyValueObservingOptionNew context:nil];
    [_settingView addObserver:self forKeyPath:@"dySlider.value" options:NSKeyValueObservingOptionNew context:nil];
    [_settingView addObserver:self forKeyPath:@"ksizeSlider.value" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeKVO {
    [_settingView removeObserver:self forKeyPath:@"dxSlider.value"];
    [_settingView removeObserver:self forKeyPath:@"dySlider.value"];
    [_settingView removeObserver:self forKeyPath:@"ksizeSlider.value"];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ( [keyPath isEqualToString:@"dxSlider.value"] ) {
        int newValue = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        _settingMap["dx"] = [[NSString stringWithFormat:@"%d", newValue] UTF8String];
    }
    else if ( [keyPath isEqualToString:@"dySlider.value"] ) {
        int newValue = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        _settingMap["dy"] = [[NSString stringWithFormat:@"%d", newValue] UTF8String];
    }
    else if ( [keyPath isEqualToString:@"ksizeSlider.value"] ) {
        int newValue = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        _settingMap["ksize"] = [[NSString stringWithFormat:@"%d", newValue] UTF8String];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark- Notification method
- (void)handleDeviceOrientationChange:(NSNotification *)notification {
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
        {
            [self.navigationController.navigationBar setHidden:YES];
            break;
        }
        default:
        {
            [self.navigationController.navigationBar setHidden:NO];
            break;
        }
    }
}



#pragma mark- AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    cv::Mat src = [self covertSampleBufferToMat:sampleBuffer];
    cv::Mat dst;
    _handler->ProcessFrame(src, dst);
//    UIImage *image = [self covertSampleBufferToUIImage:sampleBuffer];
    UIImage *image1 = MatToUIImage(dst);
    dispatch_sync( dispatch_get_main_queue(),^{
        self.videoView.image = image1;
    });
}

#pragma mark- Covert sample buffer tools
- (UIImage *)covertSampleBufferToUIImage:(CMSampleBufferRef)sampleBuffer {
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width  = CVPixelBufferGetWidth (imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress,                      // Pointer to  data
                                                 width,                            // Width of bitmap
                                                 height,                           // Height of bitmap
                                                 8,                                // Bits per component
                                                 bytesPerRow,                      // Bytes per row
                                                 colorSpace,                       // Colorspace
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst); // Bitmap info flags
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    
    // Create an image object from the Quartz image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(quartzImage);
    return image;
}

- (cv::Mat)covertSampleBufferToMat:(CMSampleBufferRef)sampleBuffer {
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    CVPixelBufferLockBaseAddress( pixelBuffer, 0 );
    
    
    //Processing here
    size_t bufferWidth = CVPixelBufferGetWidth(pixelBuffer);
    size_t bufferHeight = CVPixelBufferGetHeight(pixelBuffer);
    unsigned char *pixel = (unsigned char *)CVPixelBufferGetBaseAddress(pixelBuffer);
    
    // put buffer in open cv, no memory copied
    cv::Mat mat = cv::Mat((int)bufferHeight, (int)bufferWidth,CV_8UC4,pixel,CVPixelBufferGetBytesPerRow(pixelBuffer));
    cvtColor(mat, mat, CV_BGRA2RGBA);
    
    //End processing
    CVPixelBufferUnlockBaseAddress( pixelBuffer, 0 );
    return mat;
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
