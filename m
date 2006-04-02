From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Sun, 02 Apr 2006 18:18:59 +0000
Subject: [lm-sensors] Question on my mainboard
Message-Id: <200604022018.59547.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603282150.16130.dieter.jurzitza@t-online.de>
In-Reply-To: <200603282150.16130.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Rudolf, dear listmembers,
unfortunately it was not the problem that both drivers (w83781d and w83627hf) 
are running (apparently). Today the same thing happened again even though the 
83627hf is not loaded any more.

The "D"-state:
fred/Downloads> ps ax | grep sensors
 2980 ?        D      0:00 /usr/bin/sensors -c /etc/sensors.tempconf

and cat hangs when trying a
fred/Downloads> cat /sys/bus/i2c/devices/0-002c/alarms 
but only for a while, then comes back with -257
(strange value, isn't it?)

fred/Downloads> cat /sys/bus/i2c/devices/0-002c/temp1_input
hangs for a while too, then comes back with -1000 

The same happens for the devices named 0-002d/XXX. 

By the way, this directory looks like:
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 0-002c 
-> ../../../devices/pci0000:00/0000:00:07.3/i2c-0/0-002c
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 0-002d 
-> ../../../devices/pci0000:00/0000:00:07.3/i2c-0/0-002d
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 0-0048 
-> ../../../devices/pci0000:00/0000:00:07.3/i2c-0/0-0048
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 0-0049 
-> ../../../devices/pci0000:00/0000:00:07.3/i2c-0/0-0049
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 0-004a 
-> ../../../devices/pci0000:00/0000:00:07.3/i2c-0/0-004a
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 0-004b 
-> ../../../devices/pci0000:00/0000:00:07.3/i2c-0/0-004b
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 0-0050 
-> ../../../devices/pci0000:00/0000:00:07.3/i2c-0/0-0050
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 0-0051 
-> ../../../devices/pci0000:00/0000:00:07.3/i2c-0/0-0051
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 0-0052 
-> ../../../devices/pci0000:00/0000:00:07.3/i2c-0/0-0052
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 0-0054 
-> ../../../devices/pci0000:00/0000:00:07.3/i2c-0/0-0054
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 1-0050 
-> ../../../devices/pci0000:00/0000:00:0c.0/i2c-1/1-0050
lrwxrwxrwx  1 root root 0 2006-04-02 11:20 1-0061 
-> ../../../devices/pci0000:00/0000:00:0c.0/i2c-1/1-0061

By the way: what is preempt? How would it show?

There is one thing I found in addition: /usr/bin/sensors does not really hang 
"forever". It only hangs for a certain time, than comes back - but the values 
returned are meaningless. Just like cat <one of the values in /sys/XXX> hangs 
for about 80 seconds, I think sensors hangs for N*80seconds, where N is the 
number of values it reads.
Thank you for any suggestion,
take care



Dieter


Am Donnerstag, 30. M?rz 2006 23:45 schrieben Sie:
*******
>
> Hmm this seems some race condition in the kernel maybe? If you do ps ax
> can you see the D state of the process? Any OOPs message in the log?
>
> Do you use preempt? (perhaps not)
> Does cat hang if you do for example cat some value from
> /sys/bus/i2c/devices.../temp1_input
>
> Regards
> Rudolf
********

-- 
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------

