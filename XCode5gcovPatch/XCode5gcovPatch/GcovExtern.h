//
//  GcovExtern.h
//  XCode5gcovPatch
//
//  Created by Oleksandr Dodatko on 1/22/14.
//  Copyright (c) 2014 leroymattingly. All rights reserved.
//

#ifndef XCode5gcovPatch_GcovExtern_h
#define XCode5gcovPatch_GcovExtern_h

#ifdef __cplusplus
extern "C" {
#endif // C++ begin

#ifndef __cplusplus
extern
#endif // pure C
void __gcov_flush();
    
    
#ifdef __cplusplus
}
#endif // C++ end

#endif
