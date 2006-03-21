From: swsnyder@insightbb.com (Steve Snyder)
Date: Tue, 21 Mar 2006 21:25:12 +0000
Subject: [lm-sensors] lm87 on kernel 2.6.9: kinda-sorta working. What
Message-Id: <200603211625.13032.swsnyder@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603211249.43224.swsnyder@insightbb.com>
In-Reply-To: <200603211249.43224.swsnyder@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Jean.

Thanks for the advice.  With the lm87.c from kernel v2.6.12 and 
lm_sensors v2.8.8 the output is vastly improved.  Now it looks like this:

# sensors
lm87-i2c-0-2e
Adapter: SMBus PIIX4 adapter at 0580
VCore:     +1.43 V  (min =  +0.98 V, max =  +2.00 V)
+3.3V:     +3.32 V  (min =  +2.99 V, max =  +3.51 V)
+5V:       +5.03 V  (min =  +4.50 V, max =  +5.52 V)
+12V:     +12.12 V  (min = +10.00 V, max = +13.00 V)
CPU Fan:  5153 RPM  (min = 2848 RPM, div = 2)
fan2:     5114 RPM  (min = 2848 RPM, div = 2)
M/B Temp:    +34?C  (low  =    +0?C, high =   +50?C)
CPU Temp:    +37?C  (low  =    +0?C, high =   +85?C)
temp3:       +37?C  (low  =    +0?C, high =   +75?C)
vid:      +1.450 V  (VRM Version 8.5)


Those 3 temperatures correspond to the 2 CPUs and the motherboard temp.

Is there any way to know which temp and RPM reading corresponds to which
actual device?  I assume that the lowest of the 2 temperatures is the M/B,
but it would be nice to accurately identify the specific CPUs and fans.

Thanks again.


>Hi Steve,
>
>> Oops! Forgot to mention that I'm using lm_sensors-2.8.7 for the userspace 
>> programs.  (Standard with RHEL4).
>
>This is the cause of your problem then. Proper support for the Linux
>2.6 lm87 driver was only added in lm_sensors-2.8.8.
>
>> I got the lm87.c from the standard 2.6.10 kernel and simply dropped it
>> into Red Hat's source tree.  After adding the required normal_i2c_range[]
>> and normal_isa_range{} references (see below) it built without complaint.
>> No errors or warnings are seen in the system log at load time, either.
>
>Note that you may want to backport the driver from 2.6.12 rather than
>2.6.10 - it has some more bugfixes and cleanups, and the backport
>should be similarly easy.


