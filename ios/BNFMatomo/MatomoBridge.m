#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(Matomo, NSObject)

+(BOOL)requiresMainQueueSetup {
    return YES;
}

RCT_EXTERN_METHOD(initTracker:(NSString*)url id:(NSNumber* _Nonnull) id dimension:(NSString* _Nullable) dimension);
RCT_EXTERN_METHOD(setUserId:(NSString* _Nonnull)userID);
RCT_EXTERN_METHOD(setCustomDimension: (NSNumber* _Nonnull)index value: (NSString* _Nullable)value);
RCT_EXTERN_METHOD(trackScreen: (NSString* _Nonnull)path title: (NSString* _Nullable)title);
RCT_EXTERN_METHOD(trackGoal: (NSNumber* _Nonnull)goal values:(NSDictionary* _Nonnull) values);
RCT_EXTERN_METHOD(trackEvent:(NSString* _Nonnull)category action:(NSString* _Nonnull) action values:(NSDictionary* _Nonnull) values);
RCT_EXTERN_METHOD(trackCampaign:(NSString* _Nullable)name keyboard:(NSString* _Nullable)keyboard);
RCT_EXTERN_METHOD(trackContentImpression:(NSString* _Nonnull)name values:(NSDictionary* _Nonnull)values);
RCT_EXTERN_METHOD(trackContentInteraction:(NSString* _Nonnull)name values:(NSDictionary* _Nonnull)values);
RCT_EXTERN_METHOD(trackSearch:(NSString* _Nonnull)query values:(NSDictionary* _Nonnull) values);
RCT_EXTERN_METHOD(trackAppDownload);
RCT_EXTERN_METHOD(setAppOptOut:(BOOL _Nonnull) optOut);

@end
