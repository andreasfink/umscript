//
//  UMFunction_external.h
//  umscript
//
//  Created by Andreas Fink on 03.07.17.
//
//

#import <umscript/umscript.h>
#import <umscript/UMFunction_CGlue.h>

typedef int             (* umfunction_init_func)(void **globals);
typedef int             (* umfunction_exit_func)(void *globals);
typedef const char *    (* umfunction_name_func)(void);
typedef CFDiscreteValueRef (* umfunction_evaluate_func)(void *globals,CFArrayRef params, CFEnvironmentRef env);

@interface UMFunction_external : UMFunction
{
    NSString    *_filename;
    void        *_dlhandle;
    NSString    *_error;
    
    void *_globals;
    umfunction_init_func init_func;
    umfunction_exit_func exit_func;
    umfunction_name_func name_func;
    umfunction_evaluate_func evaluate_func;
}

@end
