From: ukessler@uni-bonn.de (=?ISO-8859-1?Q?Ulrich_Ke=DFler?=)
Date: Fri, 15 Dec 2006 15:58:30 +0000
Subject: [lm-sensors] CPU temperature(s) of Conroe
Message-Id: <4582C626.5010600@uni-bonn.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20061123T125301-366@post.gmane.org>
In-Reply-To: <loom.20061123T125301-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Christian, hi, Rudolf,

>>What do I have to do now to load the new module? (modprobe -r w83627ehf
>>and then modprobe w83627ehf does not work: no such device)
>>I think I have  recompiled only a module so I do not need to change the
>>whole
>>    
>>
>
>the redy made "w83627ehf.ko" needs to be copied to 
>to /lib/modules/<kernel-version>/kernel/drivers/hwmon/w83627ehf.ko   (of 
>course replace <kernel version> by your kernel version)
>you can say "depmod -a" afterwards to sort out module linkages but this might 
>not even necessary (doesn?t hurt either).
>
>Afterwards, "modprobe w83627ehf"  should work, start "tail 
>-f /var/log/messages" in another window first to observe whats happening. 
>use lsmod to confirm presence among modules.
>confirm appearance of a bunch of devices in /sys (in my system 
>its /sys/devices/platform/i2c-9191/9191-0290/ ): lots of fan*, in* and pwm* 
>etc
>
>BR
>Christian
>
>
>  
>
I did this and I got the same error (no such device again).

I checked if I really had compiled the new w83627ehf.c by compiling it 
again (make clean, make cloneconfig, make menuconfig, make). 
Unfortunately, I got the error messages again when compiling the new 
w83627ehf.c. So I obviously compiled the old version in the run that had 
no problems.

So now I need help to figure out where the compile problems come from. 
The error messages are things like "initializer element is not constant" 
or "... undeclared her (not in a function)" or "missing braces around 
initializer" (this is only a warning).
I took a look at the include list at the beginning of w83627ehf.c. In 
the new version there are two additional files to be included: 
hwmon-sysfs.h and mutex.h. They can be found in the directory 
/usr/src/linux/include/linux. Do I have to tell the compiler something 
about that e. g. in a Makefile?

Sorry that I answer only today but the last days our mail server was down.

Thanks for your help.

Uli

