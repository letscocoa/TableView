//
//  TableViewAppDelegate.h
//  TableView
//
//  Created by Chaitanya Pandit on 2/5/10.
//

@interface TableViewAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

