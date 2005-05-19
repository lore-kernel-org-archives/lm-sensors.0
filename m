From: gene.heskett@verizon.net (Gene Heskett)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: sensors vs 2.6, sensors 0 kernel 1
Message-Id: <200401030643.57877.gene.heskett@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040103105038.632ee305.khali@linux-fr.org>
In-Reply-To: <20040103105038.632ee305.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Saturday 03 January 2004 04:50, Jean Delvare wrote:
>Hi Gene,
>
>You really want to contact the mailing-list to report problems. More
>readers, more chance to get your problem solved.
>
>> I'm currently running the 2.6.1-rc1-mm1 kernel, and have followed
>> the instruction in lm_sensors-2.8.2, doing only a make user and
>> make user-install, and nothing in the ic2-2.8.2 dir.
>
>As a general rule, 2.6.0 is best supported by lm_sensors-2.8.2 and
>2.6.1-rc1 and next are better supported by lm_sensors2-CVS (or will
> be soon).
>
>> Everything required for a 2.4 kernel to read all my hardware is
>> turned on in the 2.6 config.
>
>As modules or into the kernel?

Was in the kernel, is now all modules with the last reboot
>
>> ISTR being told that everything has been moved from the /proc
>> virtual dir to the /sys virtual dir, but while a bunch of stuffs
>> from the bttv and gforce2 card show up there, none of the hardware
>> stuff for temps, voltages and fans seems to have survived the
>> trip.
>
>What are you using for the geforce2 card? Rivatv? Is that something
>present in the kernel or some additional patch?

rivefb, in the kernel.

>> Here is a tree of that dir:
>> [root@coyote i2c]# pwd
>> /sys/bus/i2c
>> [root@coyote i2c]# tree
>> .
>>
>> |-- devices
>> |
>> |   |-- 0-0050 ->
>>
>> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0050
>>
>> |   |-- 0-0051 ->
>>
>> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0051
>>
>> |   |-- 0-0052 ->
>>
>> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0052
>>
>> |   |-- 0-0053 ->
>>
>> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0053
>>
>> |   |-- 0-0054 ->
>>
>> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0054
>>
>> |   |-- 0-0055 ->
>>
>> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0055
>>
>> |   |-- 0-0056 ->
>>
>> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0056
>>
>> |   |-- 0-0057 ->
>>
>> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0057
>>
>> |   |-- 0-0061 ->
>>
>> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0061
>>
>> |   |-- 1-0050 ->
>>
>> ../../../devices/pci0000:00/0000:00:11.0/i2c-1/1-0050
>>
>> |   `-- 1-0051 ->
>>
>> ../../../devices/pci0000:00/0000:00:11.0/i2c-1/1-0051
>> `-- drivers
>>
>>     |-- dev_driver
>>     |-- eeprom
>>     |
>>     |   |-- 0-0050 ->
>>
>> ../../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0050
>>
>>     |   |-- 0-0051 ->
>>
>> ../../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0051
>>
>>     |   |-- 0-0052 ->
>>
>> ../../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0052
>>
>>     |   |-- 0-0053 ->
>>
>> ../../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0053
>>
>>     |   |-- 0-0054 ->
>>
>> ../../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0054
>>
>>     |   |-- 0-0055 ->
>>
>> ../../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0055
>>
>>     |   |-- 0-0056 ->
>>
>> ../../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0056
>>
>>     |   |-- 0-0057 ->
>>
>> ../../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0057
>>
>>     |   |-- 1-0050 ->
>>
>> ../../../../devices/pci0000:00/0000:00:11.0/i2c-1/1-0050
>>
>>     |   `-- 1-0051 ->
>>
>> ../../../../devices/pci0000:00/0000:00:11.0/i2c-1/1-0051
>>
>>     |-- generic i2c audio drive
>>     |-- i2c TV tuner driver
>>     |   `-- 0-0061 ->
>>
>> ../../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0061
>>
>>     |-- i2c msp3400 driver
>>     |-- i2c tda7432 driver
>>     |-- i2c tda9875 driver
>>     |-- i2c tda9887 driver
>>     |-- i2c_adapter
>>     |-- tv card mixer drive
>>
>>     `-- w83781d
>>
>> 35 directories, 0 files
>
>I suspect that tree doesn't follow symlinks. What if you "cd
>/sys/bus/i2c/devices/1-0050" and list the files in there?

With the last reboot, /sys/bus/i2c doesn't exist.

I also have lost the ability to insmod/modprobe anything after the 
reboot.

I did modify that one line 337 in rc.sysinit because there doesn't 
seem to be a /proc/ksims directory anymore.  And of course since I 
can't insmod anything a cat of /proc/modules is a linefeed only, on 
the cli.

For every attempt to modprobe something during the boot, I get a 
failed report along with a modprobe: QM_MODULES not implemented.
I've done the modprobe-conversion thing, so I have an 
/etc/modprobe.conf, possibly out of date because I haven't used 
modules in over a year.

After putting in the module-init-tools-3.0-pre4, I have this in 
/usr/local/sbin:
-----------------
-rwxr-xr-x 1 root root  95675 Jan 3 03:49 depmod
lrwxr-xr-x 1 root root     12 Jan 3 03:48 depmod.old -> /sbin/depmod
-rwxr-xr-x 1 root root  30179 Jan 3 03:49 insmod
lrwxr-xr-x 1 root root     12 Jan 3 03:48 insmod.old -> /sbin/insmod
-rwxr-xr-x 1 root root 478763 Jan 3 03:49 insmod.static
-rwxr-xr-x 1 root root  78876 Jan 3 03:49 modprobe
lrwxr-xr-x 1 root root   14 Jan 3 03:48 modprobe.old -> /sbin/modprobe
-rwxr-xr-x 1 root root  33986 Jan 3 03:49 rmmod
lrwxr-xr-x 1 root root    11 Jan  3 03:48 rmmod.old -> /sbin/rmmod
------------
I took some whitespace out above in case it looks odd.

$PATH is a mess, but /usr/local/sbin is in front of /usr/sbin 
according to an echo of it.

>> I've just this week upgraded my atk, pango, glib and gtk+- to the
>> latest versions, running into version hell for a while, and
>> gkrellm is now 2.1.24.  Everybody who will bother to answer the
>> questions says it "just works"  except that it doesn't.  The only
>> thing related to i2c that shows up in dmesg is this:
>>
>> Linux version 2.6.1-rc1-mm1 (root@coyote.coyote.den) (gcc version
>> 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Fri Jan 2 19:25:06 EST
>> 2004 [...]
>> i2c /dev entries driver
>
>I'd expect messages like "1-0050 registered" too (can't tell you the
>exact message, I'm not under 2.6). Don't you see them?
>
>> running sensors-detect, it appears its still looking in the /proc
>> dir, and bails out when it cannot find it:
>>  We are now going to do the adapter probings. Some adapters may
>> hang halfway through; we can't really help that. Also, some chips
>> will be double detected; we choose the one with the highest
>> confidence value in that case.
>>  If you found that the adapter hung after probing a certain
>> address, you can specify that address to remain unprobed. That
>> often includes address 0x69 (clock chip).
>> Couldn't open /proc/bus/i2c?!? at /usr/local/sbin/sensors-detect
>> line 3184, <STDIN> line 9.
>> [root@coyote i2c]#
>
>Strange. It is supposed to work and was tested to, too. What does
> "type -a i2cdetect" return?
>
>> Now, I've just wander through /usr/local/sbin/sensors-detect,
>> changeing all the /proc to /sys, and the script at least runs and
>> generates a sample lm_sensors to be copied in /etc/init.d.
>> I copied that, and rebooted again, but there isn't anything in the
>> logs or available to gkrellm from the w83781d device.
>>
>> Am I doing something wrong yet?
>
>No, it seems correct. I suspect that the w83781d driver doesn't
> detect you chip correctly, but I can't tell why. Please provide the
> output of "lsmod" so that we can take a look at your modules stack
> (if you used modules). If you did not use module, please try to do
> so (for the i2c stuff at least) and see it it is any better. I
> admit that we all mostly use modules because it makes debugging
> much easier, so the in-kernel method isn't too well tested.

The w83781d module worked fine, under say 2.4.23-pre3...  When built 
into the kernel too.

Aha!  That rc.sysinit script is still foobar, where it uses an 
absolute path, its running the old modutils versions in /usr/sbin!  
I'm going to run thru it giving it the absolute path for modprobe, 
reboot and see if anything works, BRB

Well, that took a while, I forgot to set a chmod +x on the new 
rc.sysinit, and of course the thing defaults to ro when you do a 
single.  So I set the option line to rw and rescue, which let me fix 
that.  But, now there are no modprobe related messages whatsoever in 
/var/log/dmesg or messages.

I saved the old rc.sysinit of course :-), so I might as well move it 
back into position in the line of fire.

I suspect the real problem is the module-init-tools install, but I 
can't see the trees for all that forest right now.

So, no sound, or sensors.  OTOH, tvtime shows its usual great picture!
Odd.  Puzzling even.  I need some sleep, this up all night crap ain't 
what it was 60 years ago.

-- 
Cheers Jean, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
