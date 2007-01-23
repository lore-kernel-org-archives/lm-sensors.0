From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 23 Jan 2007 15:24:48 +0000
Subject: [lm-sensors] sensors and i2cdump disagree on bus number
Message-Id: <20070123162448.67aaf443.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0701222114x22dfb5bcn255c300df4fd3a84@mail.gmail.com>
In-Reply-To: <191fb4ca0701222114x22dfb5bcn255c300df4fd3a84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg,

On Tue, 23 Jan 2007 06:43:46 -0800, Juerg Haefliger wrote:
> > Which kernel is this? 2.5 and early 2.6 kernels are known for this
> > behavior. It was fixed in 2.6.4. I guess you're using something more
> > recent though.
> 
> 2.6.18.2
> 
> > Is this bug reproducible, or did it only happen to you once?
> 
> It's reproducible
> 
> > When it happens, please run "ls -l /dev/i2c*" (or /dev/i2c/* if your
> > system uses this naming scheme.) I suspect that you have /dev/i2c-1
> > using minor 0 and /dev/i2c-0 using minor 1.
> 
> Jan 23 06:39:26 localhost kernel: lm85 1-002e: Client (1,0x2e) config is
> locked.
> jabba:/home/juergh# sensors
> emc6d102-i2c-1-2e
> Adapter: SMBus nForce2 adapter at 4c40
> in0:        +3.33 V  (min =  +3.32 V, max =  +3.32 V)
> in1:        +3.00 V  (min =  +2.99 V, max =  +2.99 V)
> in2:        +4.40 V  (min =  +4.38 V, max =  +4.38 V)
> in3:       +6.67 V  (min =  +6.64 V, max =  +6.64 V)
> in4:      +16.00 V  (min = +15.94 V, max = +15.94 V)
> fan1:         0 RPM  (min =    0 RPM)
> fan2:         0 RPM  (min =    0 RPM)
> fan3:         0 RPM  (min =    0 RPM)
> fan4:         0 RPM  (min =    0 RPM)
> temp1:        -0?C  (low  =    -1?C, high =    -1?C)
> temp2:        -0?C  (low  =    -1?C, high =    -1?C)
> temp3:        -0?C  (low  =    -1?C, high =    -1?C)
> pwm1:      255
> pwm2:      255
> pwm3:      255
> vid:      +0.000 V  (VRM Version 2.4)
> 
> jabba:/home/juergh# i2cdump 1 0x2e
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-1, address 0x2e, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

The dump actually matches the sensors output. Look at the sensors
values, they are all broken! I suspect you forced the driver to attach
to this specific bus and address, so it shows in "sensors", but there
really is no chip there. You probably just need to adjust your modprobe
options to force the driver to attach to the right bus.

> jabba:/home/juergh# ls -l /dev/i2c-*
> crw-rw---- 1 root root 89, 0 2007-01-23 06:37 /dev/i2c-0
> crw-rw---- 1 root root 89, 1 2007-01-23 06:37 /dev/i2c-1
> crw-rw---- 1 root root 89, 2 2007-01-23 06:37 /dev/i2c-2
> crw-rw---- 1 root root 89, 3 2007-01-23 06:37 /dev/i2c-3
> crw-rw---- 1 root root 89, 4 2007-01-23 06:37 /dev/i2c-4
> crw-rw---- 1 root root 89, 5 2007-01-23 06:37 /dev/i2c-5

This, on the other hand, looks just fine.

-- 
Jean Delvare

