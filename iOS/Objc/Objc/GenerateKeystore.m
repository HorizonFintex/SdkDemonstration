//
//  ViewController.m
//  Objc
//
//  Created by Shilei Mao on 03/08/2021.
//

#import "GenerateKeystore.h"
#import <HorizonFintexSDK/HorizonFintexSDK.h>

@interface GenerateKeystore ()
@property(strong, nonatomic) HGEthereumOperator *ethOperator;
@end

@implementation GenerateKeystore

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JSWebview *webview = [[JSWebview alloc] initWithHandlers: nil];
    
    self.ethOperator = [[HGEthereumOperator alloc] initWithJsEvaluator:webview attachedView:self.view];
    
}

-(IBAction) btGenerateKeystoreTapped:(id)sender {
    NSString *pwdStr = self.tfPassword.text;
    if (pwdStr == nil || [pwdStr length] == 0) {
        [self showErrorWithMessage:@"Please enter password"];
        return;
    }
    
    [self showProgress];
    [self.ethOperator generateKeystoreWithPwd:pwdStr completion:^(EthereumKeystore * _Nullable keystore, NSError * _Nullable error) {
        [self dismissProgress];
        self.tvKeystore.text = [keystore keystoreStr];
        NSLog(@"result: %@", keystore);
    }];
}


- (void)showErrorWithMessage:(NSString *)message {
    UIAlertController *alertView = [UIAlertController
                                    alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    
    [alertView addAction:cancelAction];
    
    [self presentViewController:alertView animated:true completion:nil];
}

- (void)showProgress {
    UIViewController *progressView = [self.storyboard instantiateViewControllerWithIdentifier:@"ProgressView"];
    [progressView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [progressView setModalPresentationStyle:UIModalPresentationOverFullScreen];
    
    [self presentViewController:progressView animated:true completion:nil];
}

- (void)dismissProgress {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
