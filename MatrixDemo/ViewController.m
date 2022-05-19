//
//  ViewController.m
//  MatrixDemo
//
//  Created by James on 2022/5/17.
//

#import "ViewController.h"
#import <MatrixSDK/MatrixSDK.h>
#import <MJExtension/MJExtension.h>
@interface ViewController ()
/// mxRestClient
@property(nonatomic,strong) MXRestClient *mxRestClient;
/// mxSession
@property(nonatomic,strong) MXSession *mxSession;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property(nonatomic,strong) MXCredentials *credent;

@property(nonatomic,strong) NSArray<MXRoom *> *rooms;

@end

static NSString  *HomeServer = @"https://matrix.org";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = @"============= MatrixDemo =============";
    [self initMatrix];
}

-(void)initMatrix{
    self.mxRestClient = [[MXRestClient alloc] initWithHomeServer:HomeServer andOnUnrecognizedCertificateBlock:nil];
}


- (IBAction)loginAction:(id)sender {
    [self.mxRestClient loginWithLoginType:kMXLoginFlowTypePassword username:@"james668" password:@"646724452" success:^(MXCredentials *credentials) {
        self.credent = credentials;
        [self setTextViewWithAction:@"loginAction" text:credentials.mj_JSONObject];
        MXLogDebug(@"loginWithLoginType are: %@", credentials.mj_JSONObject);
        
    } failure:^(NSError *error) {
        
    }];
}

/// 获取用户与之交互的房间
- (IBAction)getRooms:(id)sender {
    MXCredentials *credentials = [[MXCredentials alloc] initWithHomeServer:self.credent.homeServer
                                                                    userId:self.credent.userId
                                                               accessToken:self.credent.accessToken];

    // 创建矩阵客户端
    MXRestClient *mxRestClient = [[MXRestClient alloc] initWithCredentials:credentials andOnUnrecognizedCertificateBlock:nil];

    // 创建一个矩阵会话
    MXSession *mxSession = [[MXSession alloc] initWithMatrixRestClient:mxRestClient];

    // 启动 mxSession：它将首先与主服务器进行初始同步
    // 然后它会监听新的即将到来的事件并更新它的数据
    [mxSession start:^{
        // mxSession 已准备好使用
        // 现在我们可以得到所有房间：
        self.rooms = mxSession.rooms;
        [self setTextViewWithAction:@"getRooms" text:self.rooms.mj_JSONObject];
        MXLogDebug(@"rooms length: %ld", self.rooms.count);

        for (MXRoom *item in self.rooms) {
            [self setTextViewWithAction:@"Rooms item roomId" text:item.roomId];
            [self setTextViewWithAction:@"room partialTextMessage" text:item.partialTextMessage];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)sendMessage:(id)sender {
    [self.mxRestClient sendTextMessageToRoom:self.rooms.firstObject.roomId threadId:nil text:@" 哈哈、、、测试一下" success:^(NSString *eventId) {
        MXLogDebug(@"sendMessage eventId: %@", eventId);

    } failure:^(NSError *error) {
        MXLogDebug(@"sendMessage eventId error: %@", error);

    }];
}

-(void)setTextViewWithAction:(NSString *)action text:(NSString *)text{
    
    self.textView.text = [NSString stringWithFormat:@"%@\n  %@ >>>>> \n%@",self.textView.text, action ,text];

}

@end
