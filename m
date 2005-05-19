From: ephtman@netscape.net (Ed Harrison)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: Fwd: Error on Compiling latest CVS i2c-Second Request
Message-Id: <3E3DCF0B.30106@netscape.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030201045230.BSNF1680.pop018.verizon.net@linux.local>
In-Reply-To: <20030201045230.BSNF1680.pop018.verizon.net@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



phil@netroedge.com wrote:

>
> It looks like there needs to be a:
>
> #include <asm/errno.h>
>
> Either at the top of i2c.h or i2c-velleman.c.  Try putting it at the 
> top of i2c.h and try again.

I put it in i2c.h and i2c compiled and installed, BUT I updated 
lm_sensors and with "make" I get the following:

gcc -M -MG  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer 
-I. -Ikernel/include -I/usr/local/include/linux 
-I/lib/modules/2.4.20/build/include   -O2   kernel/busses/i2c-ali1535.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1535.d 
kernel/busses/i2c-ali1535.o: Makefile '`dirname 
kernel/busses/i2c-ali1535.d`/Module.mk' @' > kernel/busses/i2c-ali1535.d
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. 
-Ikernel/include -I/usr/local/include/linux 
-I/lib/modules/2.4.20/build/include   -O2   -c 
kernel/busses/i2c-ali1535.c -o kernel/busses/i2c-ali1535.o
kernel/busses/i2c-ali1535.c:559: unknown field `owner' specified in 
initializer
kernel/busses/i2c-ali1535.c:559: warning: initialization makes integer 
from pointer without a cast
kernel/busses/i2c-ali1535.c:559: initializer element is not computable 
at load time
kernel/busses/i2c-ali1535.c:559: (near initialization for 
`ali1535_adapter.name[0]')
kernel/busses/i2c-ali1535.c:560: initializer element is not constant
kernel/busses/i2c-ali1535.c:560: (near initialization for 
`ali1535_adapter.name')
make: *** [kernel/busses/i2c-ali1535.o] Error 1

and it exits the process.


>
> Phil
>
> Ed Harrison wrote:
>
>> ** Forwarding message from "Ed Harrison" <ed.tman@verizon.net> on 
>> Thu, 30 Jan 2003 11:42:38 -0500
>>
>>
>> During "make" in i2c, I get an error in "kernel/i2c/i2c.h"
>>
>> gcc -I/lib/modules/2.4.19-4GB/build/include -O2 -DLM_SENSORS 
>> -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -c 
>> kernel/i2c-velleman.c -o kernel/i2c-velleman.o
>> In file included from kernel/i2c-velleman.c:28:
>> kernel/i2c.h: In function `i2c_client_command':
>> kernel/i2c.h:327: `EINVAL' undeclared (first use in this function)
>> kernel/i2c.h:327: (Each undeclared identifier is reported only once
>> kernel/i2c.h:327: for each function it appears in.)
>> make: *** [kernel/i2c-velleman.o] Error 1
>>
>>
>>
>> I do not use i2c-velleman.o, but I can't compile until I know what 
>> this means and how to fix it.
>>
>>
>> Ed Harrison, broadcasting on:
>>        L I N U X
>> by SuSE (8.1), Kernel 2.4.19-4GB,
>> X-server 4.2, PolarBarMailer 1.25rc3
>>
>>
>> Ed Harrison, broadcasting on:
>>        L I N U X
>> by SuSE (8.1), Kernel 2.4.19-4GB,
>> X-server 4.2, PolarBarMailer 1.25rc3
>>
>>  
>>
>

