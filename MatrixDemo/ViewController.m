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
//    self.mxRestClient s
    // 创建一个矩阵会话
//    self.mxSession = [[MXSession alloc] initWithMatrixRestClient:self.mxRestClient];
    /// 检测用户名是否可用
//    [self.mxRestClient isUsernameAvailable:@"james668" success:^(MXUsernameAvailability *availability) {
//        MXLogDebug(@"The availability are: %d", availability.available);
//
//    } failure:^(NSError *error) {
//        MXLogDebug(@"The availability error are: %ld", error.code);
//    }];

//    [mxRestClient publicRoomsOnServer:HomeServer limit:10 since:@"0" filter:nil thirdPartyInstanceId:@"" includeAllNetworks:true success:^(MXPublicRoomsResponse *publicRoomsResponse) {
//        MXLogDebug(@"The publicRoomsResponse are: %@", publicRoomsResponse);
//
//    } failure:^(NSError *error) {
//        NSLog(@"Error >>> %@",error);
//    }];
//    [mxRestClient publicRooms:^(NSArray *rooms) {
//
//        // rooms is an array of MXPublicRoom objects containing information like room id
//        MXLogDebug(@"The public rooms are: %@", rooms);
//
//    } failure:^(MXError *error) {
//    }];*
}


- (IBAction)loginAction:(id)sender {
    [self.mxRestClient loginWithLoginType:kMXLoginFlowTypePassword username:@"james668" password:@"646724452" success:^(MXCredentials *credentials) {
        self.credent = credentials;
        self.textView.text = [NSString stringWithFormat:@"%@\n loginAction >>> \n%@",self.textView.text, credentials.mj_JSONObject];
        MXLogDebug(@"loginWithLoginType are: %@", credentials.mj_JSONObject);
        
    } failure:^(NSError *error) {
        
    }];
}

@end
