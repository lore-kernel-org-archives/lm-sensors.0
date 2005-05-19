From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: (from cvs) sensors binary compile probs on rh8
Message-Id: <3DFE32BB.4030108@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DF93866.7070502@netroedge.com>
In-Reply-To: <3DF93866.7070502@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

guess you saw the mail that it's a libc 2.3 thing...
Can you recompile w/ -g (sensors and libsensors) and get a better bt?
could be something I did to libsensors...

Philip Edelbrock wrote:
> :'(
> 
> [phil@drtheopolis phil]$ sensors -v
> sensors version 2.7.0
> 
> [phil@drtheopolis phil]$ sensors
> Segmentation fault (core dumped)
> 
> [phil@drtheopolis phil]$ gdb sensors
> GNU gdb Red Hat Linux (5.2.1-4)
> Copyright 2002 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you 
> are
> welcome to change it and/or distribute copies of it under certain 
> conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "i386-redhat-linux"...
> (gdb) run
> Starting program: /usr/local/bin/sensors
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x4207931a in strcmp () from /lib/i686/libc.so.6
> (gdb) bt
> #0  0x4207931a in strcmp () from /lib/i686/libc.so.6
> #1  0x40028bd9 in sensors_match_chip () from /usr/lib/libsensors.so.1
> #2  0x08049171 in do_the_real_work ()
> #3  0x08049073 in main ()
> #4  0x420158d4 in __libc_start_main () from /lib/i686/libc.so.6
> 
> 
> It's possible that it's just my strange computer.  This isn't a RH8 
> install from scratch, but an upgrade.  There could be a legacy lib or 
> something causing trouble which may not appear on another Athlon running 
> RH8.... has anybody else tried on an Athlon?
> 
> 
> Phil
> 
> 
> Mark Studebaker wrote:
> 
>> Phil, what processor are you compiling for? Or what's wrong with 
>> <math.h>?
>> It works for me, but gcc is generating floating point assembler 
>> instructions
>> and so it doesn't need -lm.
>> If we do add a -lm it should be added to lib/Module.mk for the library,
>> not in prog/sensors/Module.mk for sensors.
>>
>>
>> Jean Delvare wrote:
>>
>>>> FYI-
>>>>
>>>> gcc -o prog/sensors/sensors prog/sensors/main.ro prog/sensors/chips.ro
>>>> -Llib -lsensors
>>>> lib/libsensors.so: undefined reference to `log'
>>>> lib/libsensors.so: undefined reference to `exp'
>>>> collect2: ld returned 1 exit stat
>>>
>>>
>>>
>>>
>>> Looks like we need an extra "-lm" on the command line.
>>>
>>
>>
> 

