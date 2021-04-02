//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<geolocation/GeolocationPlugin.h>)
#import <geolocation/GeolocationPlugin.h>
#else
@import geolocation;
#endif

#if __has_include(<hexcolor/HexcolorPlugin.h>)
#import <hexcolor/HexcolorPlugin.h>
#else
@import hexcolor;
#endif

#if __has_include(<streams_channel/StreamsChannelPlugin.h>)
#import <streams_channel/StreamsChannelPlugin.h>
#else
@import streams_channel;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [GeolocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"GeolocationPlugin"]];
  [HexcolorPlugin registerWithRegistrar:[registry registrarForPlugin:@"HexcolorPlugin"]];
  [StreamsChannelPlugin registerWithRegistrar:[registry registrarForPlugin:@"StreamsChannelPlugin"]];
}

@end
