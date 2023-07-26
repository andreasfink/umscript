//
//  main.m
//  uexe
//
//  Created by Andreas Fink on 07.07.17.
//
// 

#import <umscript/umscript.h>
#import <stdlib.h>
#import <unistd.h>
#import <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>

#ifdef USE_STARTER
int umain(int argc,  const char * argv[]);
#else
int main(int argc, const char * argv[]);
#endif

#define ARGUMENTS_PRINT(argc,argv) {  \
fprintf(stderr,"------------------------\n"); \
fprintf(stderr,"ARGUMENTS-COUNT: %d\n",argc); \
for(int i=0;i< argc;i++) \
fprintf(stderr,"ARGUMENT[%d]: %s\n",i,argv[i]);  \
fprintf(stderr,"------------------------\n"); \
fflush(stderr); \
}

void help(void);

#ifdef USE_STARTER
int umain(int argc,  const char * argv[]);
#else
int main(int argc,  const char * argv[]);
#endif


NSString *input_data_file_name = NULL;
NSString *script_file_name = NULL;
BOOL g_debug = NO;

void help(void)
{
    fprintf(stderr,"uexe syntax:\n");
    fprintf(stderr," --input <filename>        the input variables (containing lines like $var=val)\n");
    fprintf(stderr," --script <filename>       the script to execute\n");
    fprintf(stderr," --debug                   be verbose on what the script is doing\n");
}

#ifdef USE_STARTER
int umain(int argc,  const char * argv[])
#else
int main(int argc, const char * argv[])
#endif
{
    time_t	tim;
    char	state_array[16];

    [NSUserDefaults standardUserDefaults];

    time(&tim);
    initstate((unsigned  int)tim,  state_array,  16);

    for(int i=1;i<argc;i++)
    {
        if(0==strcmp(argv[i],"--input"))
        {
            if((i+1)<argc)
            {
                input_data_file_name = @(argv[i+1]);
                i++;
            }
            else
            {
                fprintf(stderr,"Error: the option --input requires a parameter, the file name");
                exit(-1);
            }
        }
        else if(0==strcmp(argv[i],"--script"))
        {
            if((i+1)<argc)
            {
                script_file_name = @(argv[i+1]);
                i++;
            }
            else
            {
                fprintf(stderr,"Error: the option --script requires a parameter, the file name");
                exit(-1);
            }
        }
        else if(0==strcmp(argv[i],"--debug"))
        {
            g_debug = YES;
        }
        else if((0==strcmp(argv[i],"--help")) || (0==strcmp(argv[i],"-?")))
        {
            help();
            exit(0);
        }
    }


    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
#pragma unused(runLoop)

    if(script_file_name==NULL)
    {
        help();
        exit(0);
    }
    @autoreleasepool
    {
        UMScriptDocument *doc;
        UMEnvironment *env;
        if(input_data_file_name)
        {
            env = [[UMEnvironment alloc]initWithVarFile:input_data_file_name];
        }
        else
        {
            env = [[UMEnvironment alloc]init];
        }
        if(g_debug)
        {
            env._traceExecutionFlag = YES;
            env._traceTreeBuildupFlag = YES;
        }
        @try
        {
            doc = [[UMScriptDocument alloc]initWithFilename:script_file_name];
        }
        @catch(NSException *ex)
        {
            NSError *err = ex.userInfo[@"err"];
            fprintf(stderr,"Error while opening script document'%s': %s",script_file_name.UTF8String,err.description.UTF8String);
            exit(-1);
        }
        NSString *r =  [doc compileSource];
        if(r)
        {
            fprintf(stdout,"%s",r.UTF8String);
        }

		UMDiscreteValue *result = [doc runScriptWithEnvironment:env continueFrom:NULL];

        NSString *s = [NSString stringWithFormat:@"ReturnValue: %@",result.description];
        fprintf(stdout,"%s\n",s.UTF8String);
    }
    return 0;
}


