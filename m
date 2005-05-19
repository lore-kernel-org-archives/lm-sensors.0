From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: (from cvs) sensors binary compile probs on rh8
Message-Id: <3E0205E8.9090005@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DF93866.7070502@netroedge.com>
In-Reply-To: <3DF93866.7070502@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I don't have /lib listed in ld.so.conf, but it checks it first, followed 
by /usr/lib, then the paths I listed in /usr/lib.  This is rh8.0 with 
ldconfig (GNU libc) 2.2.93.  You probably know this, but you can check 
to see which libs are used by doing a 'ldd sensors', btw.  Mine says:

[root@drtheopolis afpd]# ldd /usr/local/bin/sensors
        libsensors.so.1 => /usr/local/lib/libsensors.so.1 (0x40024000)
        libc.so.6 => /lib/i686/libc.so.6 (0x42000000)
        libm.so.6 => /lib/i686/libm.so.6 (0x4004e000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000


Phil


Mark D. Studebaker wrote:

>my man page for ld.so clearly says that /usr/lib and /lib are last.
>You can also see this from the output of 'ldconfig -v'.
>
>Is yours different?
>
>Also note that the email we got a few days ago from the user,
>he was picking up the library in /usr/local/lib...
>so I'm really confused now...
>
>Philip Edelbrock wrote:
>  
>
>>(I can't remember if I've replied to this yet)
>>
>>I didn't have to add /usr/local/lib to it (I've added it a long time
>>ago), but it looks in /usr/lib first.  In fact, I think /lib and
>>/usr/lib are built into the lib search path and don't need to be in
>>ld.so.conf?
>>
>>I wonder if we can add a checking function in the include header to test
>>for the lib version (and call it when sensors is run).  The header
>>version and the lib version should always be indentical, right?
>>
>>Phil
>>
>>Mark Studebaker wrote:
>>
>>    
>>
>>>>From reading 'man ld.so' and 'man ldconfig', it's apparent that
>>>>/usr/lib and /lib are searched _after_ all
>>>>        
>>>>
>>>the libraries listed in /etc/ld.so.conf. So the only problem is if
>>>/usr/local/lib is not listed
>>>in /etc/ld.so.conf at all.
>>>
>>>Did you have /usr/local/lib/ in /etc/ld.so.conf or did you have to add
>>>it?
>>>
>>>If Redhat doesn't have /usr/local/lib in there, I think that's the
>>>check we need to have.
>>>
>>>
>>>Philip Edelbrock wrote:
>>>
>>>      
>>>
>>>>Ah, I found the trouble. I've got too many libsensors installed, and
>>>>when sensors is compiled, it will link against an old one. At some
>>>>point, we changed the default lib installation directory from
>>>>/usr/lib to /usr/local/lib. Bins get linked against
>>>>/usr/lib/libsensors.so instead of the newer /usr/local/libsensors.so.
>>>>
>>>>So, in essence, a newer include for the lib is used to link against
>>>>an old lib.
>>>>
>>>>Once I deleted the old libs from /usr/lib and got it linking to the
>>>>new lib, it worked fine.
>>>>
>>>>Should we have a check for an old lib? Or explicitly link against
>>>>libsensors.1.4.0.so (if this is possible?).
>>>>
>>>>
>>>>Phil
>>>>
>>>>
>>>>Mark Studebaker wrote:
>>>>
>>>>        
>>>>
>>>>>guess you saw the mail that it's a libc 2.3 thing...
>>>>>Can you recompile w/ -g (sensors and libsensors) and get a better bt?
>>>>>could be something I did to libsensors...
>>>>>
>>>>>Philip Edelbrock wrote:
>>>>>
>>>>>          
>>>>>
>>>>>>:'(
>>>>>>
>>>>>>[phil@drtheopolis phil]$ sensors -v
>>>>>>sensors version 2.7.0
>>>>>>
>>>>>>[phil@drtheopolis phil]$ sensors
>>>>>>Segmentation fault (core dumped)
>>>>>>
>>>>>>[phil@drtheopolis phil]$ gdb sensors
>>>>>>GNU gdb Red Hat Linux (5.2.1-4)
>>>>>>Copyright 2002 Free Software Foundation, Inc.
>>>>>>GDB is free software, covered by the GNU General Public License,
>>>>>>and you are
>>>>>>welcome to change it and/or distribute copies of it under certain
>>>>>>conditions.
>>>>>>Type "show copying" to see the conditions.
>>>>>>There is absolutely no warranty for GDB. Type "show warranty" for
>>>>>>details.
>>>>>>This GDB was configured as "i386-redhat-linux"...
>>>>>>(gdb) run
>>>>>>Starting program: /usr/local/bin/sensors
>>>>>>
>>>>>>Program received signal SIGSEGV, Segmentation fault.
>>>>>>0x4207931a in strcmp () from /lib/i686/libc.so.6
>>>>>>(gdb) bt
>>>>>>#0 0x4207931a in strcmp () from /lib/i686/libc.so.6
>>>>>>#1 0x40028bd9 in sensors_match_chip () from /usr/lib/libsensors.so.1
>>>>>>#2 0x08049171 in do_the_real_work ()
>>>>>>#3 0x08049073 in main ()
>>>>>>#4 0x420158d4 in __libc_start_main () from /lib/i686/libc.so.6
>>>>>>
>>>>>>
>>>>>>It's possible that it's just my strange computer. This isn't a RH8
>>>>>>install from scratch, but an upgrade. There could be a legacy lib
>>>>>>or something causing trouble which may not appear on another Athlon
>>>>>>running RH8.... has anybody else tried on an Athlon?
>>>>>>
>>>>>>
>>>>>>Phil
>>>>>>
>>>>>>
>>>>>>Mark Studebaker wrote:
>>>>>>
>>>>>>            
>>>>>>
>>>>>>>Phil, what processor are you compiling for? Or what's wrong with
>>>>>>><math.h>?
>>>>>>>It works for me, but gcc is generating floating point assembler
>>>>>>>instructions
>>>>>>>and so it doesn't need -lm.
>>>>>>>If we do add a -lm it should be added to lib/Module.mk for the
>>>>>>>library,
>>>>>>>not in prog/sensors/Module.mk for sensors.
>>>>>>>
>>>>>>>
>>>>>>>Jean Delvare wrote:
>>>>>>>
>>>>>>>              
>>>>>>>
>>>>>>>>>FYI-
>>>>>>>>>
>>>>>>>>>gcc -o prog/sensors/sensors prog/sensors/main.ro
>>>>>>>>>prog/sensors/chips.ro
>>>>>>>>>-Llib -lsensors
>>>>>>>>>lib/libsensors.so: undefined reference to `log'
>>>>>>>>>lib/libsensors.so: undefined reference to `exp'
>>>>>>>>>collect2: ld returned 1 exit stat
>>>>>>>>>                  
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>Looks like we need an extra "-lm" on the command line.
>>>>>>>>
>>>>>>>>                
>>>>>>>>
>>>>>>>              
>>>>>>>
>>>>>          
>>>>>
>
>  
>
