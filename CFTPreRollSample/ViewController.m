//
//  ViewController.m
//  CFTPreRollSample
//
//  Created by CF-NB on 2023/11/5.
//

#import "ViewController.h"

NSString *const kContentURLString =
    @"https://v.holmesmind.com/1151/video/output/s_f96434d0f311f12bdcf5145796985719.mp4";


@interface ViewController ()
@property(nonatomic) AVPlayerViewController *contentPlayerViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupContentPlayer];
    [self setPreRoll];
}

- (void)setPreRoll{
    [self hideContentPlayer];
    preroll = [[MFPreRollView alloc] initWithView:self.view];
    [preroll setZoneID:@"18379" getViewController:self];
    preroll.delegate = self;
    [preroll setPlayer];
}


- (void)readyPlayVideo{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"Ad play done.");
    
    [self showContentPlayer];
}


- (void)onFailedToVast{
    NSLog(@"%s",__FUNCTION__);
}

- (void)setupContentPlayer {
    // Create a content video player.
    NSURL *contentURL = [NSURL URLWithString:kContentURLString];
    AVPlayer *player = [AVPlayer playerWithURL:contentURL];
    self.contentPlayerViewController = [[AVPlayerViewController alloc] init];
    self.contentPlayerViewController.player = player;
    self.contentPlayerViewController.view.frame = self.view.bounds;

    // Attach content video player to view hierarchy.
    [self showContentPlayer];
}

// Add the content video player as a child view controller.
- (void)showContentPlayer {
    [self addChildViewController:self.contentPlayerViewController];
    self.contentPlayerViewController.view.frame = self.view.bounds;
    [self.view insertSubview:self.contentPlayerViewController.view atIndex:0];
    [self.contentPlayerViewController didMoveToParentViewController:self];
    [self.contentPlayerViewController.player play];
}

// Remove and detach the content video player.
- (void)hideContentPlayer {
    // The whole controller needs to be detached so that it doesn't capture events from the remote.
    [self.contentPlayerViewController willMoveToParentViewController:nil];
    [self.contentPlayerViewController.view removeFromSuperview];
    [self.contentPlayerViewController removeFromParentViewController];
    [self.contentPlayerViewController.player pause];
}

@end
