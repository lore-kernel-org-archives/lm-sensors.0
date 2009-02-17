From: DB <Freddog_de@yahoo.co.uk>
Date: Tue, 17 Feb 2009 17:19:51 +0000
Subject: Re: [lm-sensors] [Bulk] Re:  Cannot make ver 3.0.3
Message-Id: <499AF1B7.5020703@yahoo.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Tue, 17 Feb 2009 16:36:35 +0100, DB wrote:
>   
>> Good afternoon,
>>
>> I've just tried to make lm_sensors ver 3.0.3, with the following result:
>> <snip>
>> prog/sensors/main.ro prog/sensors/chips.ro -Llib -lsensors
>> lib/libsensors.so: undefined reference to `sensors_yylex'
>> lib/libsensors.so: undefined reference to `sensors_lex_error'
>> lib/libsensors.so: undefined reference to `sensors_yylineno'
>> lib/libsensors.so: undefined reference to `sensors_scanner_exit'
>> lib/libsensors.so: undefined reference to `sensors_scanner_init'
>> collect2: ld returned 1 exit status
>> make: *** [prog/sensors/sensors] Error 1
>>
>> Any suggestions on how to deal with the 5 undefined references????
>>     
>
> Please do "make clean" and then "make" again. The above log lacks the
> beginning of the build, so I can't tell what went wrong.
>
>   
                         
[root@Fedora-Blue lm_sensors-3.0.3]# make 
all                                                                                                                     

Makefile:171: lib/data.ld: No such file or 
directory                                                                                                              

Makefile:171: lib/general.ld: No such file or 
directory                                                                                                           

Makefile:171: lib/error.ld: No such file or 
directory                                                                                                             

Makefile:171: lib/access.ld: No such file or 
directory                                                                                                            

Makefile:171: lib/init.ld: No such file or 
directory                                                                                                              

Makefile:171: lib/sysfs.ld: No such file or 
directory                                                                                                             

Makefile:171: lib/data.ad: No such file or 
directory                                                                                                              

Makefile:171: lib/general.ad: No such file or 
directory                                                                                                           

Makefile:171: lib/error.ad: No such file or 
directory                                                                                                             

Makefile:171: lib/access.ad: No such file or 
directory                                                                                                            

Makefile:171: lib/init.ad: No such file or 
directory                                                                                                              

Makefile:171: lib/sysfs.ad: No such file or 
directory                                                                                                             

Makefile:171: prog/sensors/main.rd: No such file or 
directory                                                                                                     

Makefile:171: prog/sensors/chips.rd: No such file or 
directory                                                                                                    

Makefile:171: prog/dump/util.rd: No such file or 
directory                                                                                                        

Makefile:171: prog/dump/isadump.rd: No such file or 
directory                                                                                                     

Makefile:171: prog/dump/isaset.rd: No such file or 
directory                                                                                                      

Makefile:171: prog/dump/superio.rd: No such file or 
directory                                                                                                     

gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  
prog/dump/superio.c | 
\                                                                                                              

        sed -e 's@^\(.*\)\.o:@prog/dump/superio.rd prog/dump/superio.ro: 
Makefile '`dirname prog/dump/superio.rd`/Module.mk' @' > 
prog/dump/superio.rd           
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  
prog/dump/isaset.c | 
\                                                                                                               

        sed -e 's@^\(.*\)\.o:@prog/dump/isaset.rd prog/dump/isaset.ro: 
Makefile '`dirname prog/dump/isaset.rd`/Module.mk' @' > 
prog/dump/isaset.rd               
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  
prog/dump/isadump.c | 
\                                                                                                              

        sed -e 's@^\(.*\)\.o:@prog/dump/isadump.rd prog/dump/isadump.ro: 
Makefile '`dirname prog/dump/isadump.rd`/Module.mk' @' > 
prog/dump/isadump.rd           
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  
prog/dump/util.c | 
\                                                                                                                 

        sed -e 's@^\(.*\)\.o:@prog/dump/util.rd prog/dump/util.ro: 
Makefile '`dirname prog/dump/util.rd`/Module.mk' @' > 
prog/dump/util.rd                       
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  
prog/sensors/chips.c | 
\                                                                                                             

        sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd 
prog/sensors/chips.ro: Makefile '`dirname 
prog/sensors/chips.rd`/Module.mk' @' > prog/sensors/chips.rd       
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  
prog/sensors/main.c | 
\                                                                                                              

        sed -e 's@^\(.*\)\.o:@prog/sensors/main.rd prog/sensors/main.ro: 
Makefile '`dirname prog/sensors/main.rd`/Module.mk' @' > 
prog/sensors/main.rd           
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  lib/sysfs.c | 
\                                                                                                                      

        sed -e 's@^\(.*\)\.o:@lib/sysfs.ad lib/sysfs.ao: Makefile 
'`dirname lib/sysfs.ad`/Module.mk' @' > 
lib/sysfs.ad                                           
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  lib/init.c | 
\                                                                                                                       

        sed -e 's@^\(.*\)\.o:@lib/init.ad lib/init.ao: Makefile 
'`dirname lib/init.ad`/Module.mk' @' > 
lib/init.ad                                               
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  lib/access.c 
| 
\                                                                                                                     

        sed -e 's@^\(.*\)\.o:@lib/access.ad lib/access.ao: Makefile 
'`dirname lib/access.ad`/Module.mk' @' > 
lib/access.ad                                       
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  lib/error.c | 
\                                                                                                                      

        sed -e 's@^\(.*\)\.o:@lib/error.ad lib/error.ao: Makefile 
'`dirname lib/error.ad`/Module.mk' @' > 
lib/error.ad                                           
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  lib/general.c 
| 
\                                                                                                                    

        sed -e 's@^\(.*\)\.o:@lib/general.ad lib/general.ao: Makefile 
'`dirname lib/general.ad`/Module.mk' @' > 
lib/general.ad                                   
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes 
-Wshadow -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  lib/data.c | 
\                                                                                                                       

        sed -e 's@^\(.*\)\.o:@lib/data.ad lib/data.ao: Makefile 
'`dirname lib/data.ad`/Module.mk' @' > 
lib/data.ad                                               
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/sysfs.c | 
\                                                                                                   

        sed -e 's@^\(.*\)\.o:@lib/sysfs.ld lib/sysfs.lo: Makefile 
'`dirname lib/sysfs.ld`/Module.mk' @' > 
lib/sysfs.ld                                           
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/init.c | 
\                                                                                                    

        sed -e 's@^\(.*\)\.o:@lib/init.ld lib/init.lo: Makefile 
'`dirname lib/init.ld`/Module.mk' @' > 
lib/init.ld                                               
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/access.c | 
\                                                                                                  

        sed -e 's@^\(.*\)\.o:@lib/access.ld lib/access.lo: Makefile 
'`dirname lib/access.ld`/Module.mk' @' > 
lib/access.ld                                       
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/error.c | 
\                                                                                                   

        sed -e 's@^\(.*\)\.o:@lib/error.ld lib/error.lo: Makefile 
'`dirname lib/error.ld`/Module.mk' @' > 
lib/error.ld                                           
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/general.c | 
\                                                                                                 

        sed -e 's@^\(.*\)\.o:@lib/general.ld lib/general.lo: Makefile 
'`dirname lib/general.ld`/Module.mk' @' > 
lib/general.ld                                   
gcc -M -MG -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  lib/data.c | 
\                                                                                                    

        sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.lo: Makefile 
'`dirname lib/data.ld`/Module.mk' @' > 
lib/data.ld                                               
gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c lib/data.c 
-o 
lib/data.ao                                                                                                                

gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c 
lib/general.c -o 
lib/general.ao                                                                                                          

gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c 
lib/error.c -o 
lib/error.ao                                                                                                              

gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c 
lib/access.c -o 
lib/access.ao                                                                                                            

gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c lib/init.c 
-o 
lib/init.ao                                                                                                                

gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c 
lib/sysfs.c -o 
lib/sysfs.ao                                                                                                              

bison -p sensors_yy -d lib/conf-parse.y -o 
lib/conf-parse.c                                                                                                       

gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -Wno-undef -c 
lib/conf-parse.c -o 
lib/conf-parse.ao                                                                                         

flex -Psensors_yy -t -Cfe -8 lib/conf-lex.l > 
lib/conf-lex.c                                                                                                      

gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -Wno-shadow 
-Wno-undef -Wno-unused -Wno-missing-prototypes -Wno-sign-compare -c 
lib/conf-lex.c -o lib/conf-lex.ao                          
rm -f 
lib/libsensors.a                                                                                                                                            

ar rcvs lib/libsensors.a lib/data.ao lib/general.ao lib/error.ao 
lib/access.ao lib/init.ao lib/sysfs.ao lib/conf-parse.ao 
lib/conf-lex.ao                        
a - 
lib/data.ao                                                                                                                                                   

a - 
lib/general.ao                                                                                                                                                

a - 
lib/error.ao                                                                                                                                                  

a - 
lib/access.ao                                                                                                                                                 

a - 
lib/init.ao                                                                                                                                                   

a - 
lib/sysfs.ao                                                                                                                                                  

a - 
lib/conf-parse.ao                                                                                                                                             

a - 
lib/conf-lex.ao                                                                                                                                               

gcc -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  -c lib/data.c -o 
lib/data.lo                                                                                             

gcc -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  -c lib/general.c -o 
lib/general.lo                                                                                       

gcc -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  -c lib/error.c -o 
lib/error.lo                                                                                           

gcc -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  -c lib/access.c -o lib/access.lo
gcc -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  -c lib/init.c -o lib/init.lo
gcc -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  -c lib/sysfs.c -o lib/sysfs.lo
gcc -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  -Wno-undef -c lib/conf-parse.c -o lib/conf-parse.lo
gcc -DETCDIR="\"/etc\"" -I.  -fpic -D_REENTRANT -Wall -O2 
-Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual -Wcast-align 
-Wwrite-strings -Wnested-externs -Winline -W -Wmissing-prototypes 
-Wundef  -Wno-shadow -Wno-undef -Wno-unused -Wno-missing-prototypes 
-Wno-sign-compare -c lib/conf-lex.c -o lib/conf-lex.lo
gcc -shared -Wl,-soname,libsensors.so.4 -o lib/libsensors.so.4.0.2 
lib/data.lo lib/general.lo lib/error.lo lib/access.lo lib/init.lo 
lib/sysfs.lo lib/conf-parse.lo lib/conf-lex.lo -lc -lm
rm -f lib/libsensors.so.4
ln -sf libsensors.so.4.0.2 lib/libsensors.so.4
rm -f lib/libsensors.so
ln -sf libsensors.so.4.0.2 lib/libsensors.so
gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c 
prog/sensors/main.c -o prog/sensors/main.ro
prog/sensors/main.c: In function ‘set_degstr’:
prog/sensors/main.c:128: warning: initialization discards qualifiers 
from pointer target type
prog/sensors/main.c:128: warning: initialization discards qualifiers 
from pointer target type
gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c 
prog/sensors/chips.c -o prog/sensors/chips.ro
gcc -Wl,-rpath,/usr/local/lib -o prog/sensors/sensors 
prog/sensors/main.ro prog/sensors/chips.ro  -Llib -lsensors
gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c 
prog/dump/isadump.c -o prog/dump/isadump.ro
gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c 
prog/dump/superio.c -o prog/dump/superio.ro
gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c 
prog/dump/util.c -o prog/dump/util.ro
gcc -Wl,-rpath,/usr/local/lib -o prog/dump/isadump prog/dump/isadump.ro 
prog/dump/superio.ro prog/dump/util.ro
gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c 
prog/dump/isaset.c -o prog/dump/isaset.ro
gcc -Wl,-rpath,/usr/local/lib -o prog/dump/isaset prog/dump/isaset.ro 
prog/dump/util.ro
gcc -DETCDIR="\"/etc\"" -I.  -Wall -O2 -Wstrict-prototypes -Wshadow 
-Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings 
-Wnested-externs -Winline -W -Wmissing-prototypes -Wundef  -c 
lib/test/test-scanner.c -o lib/test/test-scanner.ro
gcc -Wl,-rpath,/usr/local/lib -o lib/test/test-scanner 
lib/test/test-scanner.ro lib/conf-lex.ao lib/error.ao lib/general.ao -Llib


Thanks for the quick reply!  I assume(!) the above is a correct 
output?????  & that I should now have a working 3.0.3 lm_sensors.

Let's see what happens!

Dave

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
