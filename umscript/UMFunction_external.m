//
//  UMFunction_external.m
//  umscript
//
//  Created by Andreas Fink on 03.07.17.
//
//

#import "UMFunction_external.h"
#include <dlfcn.h>

@implementation UMFunction_external


- (UMFunction_external *)initWithFile:(NSString *)filename
{
    self = [super init];
    if(self)
    {
        _filename = filename;
    }
    return self;
}

- (int) open
{
    _dlhandle = dlopen(_filename.UTF8String,RTLD_NOW | RTLD_LOCAL);
    if(_dlhandle == NULL)
    {
        _error = @(dlerror());
        return -1;
    }
    
    init_func       = dlsym(_dlhandle, "umfunction_init");
    exit_func       = dlsym(_dlhandle, "umfunction_exit");
    name_func       = dlsym(_dlhandle, "umfunction_name");
    evaluate_func   = dlsym(_dlhandle, "umfunction_evaluate");
    
    if(!init_func)
    {
        _error = @"umfunction_init function not found";
        return -2;
    }
    
    if(!exit_func)
    {
        _error = @"umfunction_exit function not found";
        return -2;
    }
    
    if(!name_func)
    {
        _error = @"umfunction_name function not found";
        return -2;
    }
    const char *cname = (*name_func)();
    _name = @(cname);
    return 0;
}

- (int) close
{
    return(*exit_func)(_globals);
    _globals = NULL;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    CFArrayRef param_ref = (__bridge CFArrayRef)params;
    CFEnvironmentRef env_ref = (__bridge CFEnvironmentRef)env;
    CFDiscreteValueRef disc = (*evaluate_func)(_globals,param_ref,env_ref);
    UMDiscreteValue *r = (__bridge_transfer UMDiscreteValue *)disc;
    if(r==NULL)
    {
        return [UMDiscreteValue discreteNull];
    }
    return r;
}

@end
