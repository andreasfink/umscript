#!/bin/sh
/usr/local/bin/flex   --outfile language/_generated_umscript.l.m language/umscript.l
/usr/local/bin/bison  --defines=language/_generated_umscript.y.h --output-file language/_generated_umscript.y.m language/umscript.y --warnings=none
