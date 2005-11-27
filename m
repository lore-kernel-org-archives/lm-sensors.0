From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Sun, 27 Nov 2005 12:54:28 +0000
Subject: [Fwd: Re: [lm-sensors] Kernel hangs with i2c-i801 driver?]
Message-Id: <20051127113121.GA6234@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051126073613.GG26906@oden.homeip.net>
In-Reply-To: <20051126073613.GG26906@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 25, 2005 at 08:56:49PM +0100, Rudolf Marek wrote:
> 
> Hello all,
> 
> I have a theory that changing limit values will assert SMI interrupt
> and SMI code will hang the machine. 
> Maybe the interrupt is raised via SMBALERT line which can be
> disabled in the i2c-i801.c driver. 
> 
> Eventualy i think if we switch the interrupt generation to IRQ9 so
> inux should report "IRQ9 nobody cared" instead of crarsh ... if I'm
> correct with the SMI assumption. 
> 
> you can try to:
> setpci  -s 0:1f.3 40.b=1
> 
> This will set the SMB routing interrupt to IRQ9 (or some other but not on SMI)

Rudolf,

I was finally able to get into a situation where I can reproduce the
hang in a repeatable fashion. I'm using this script to set the values:

find /sys/bus/i2c/devices/0-002c/ -name 'in*_min' -exec /bin/sh -c '/bin/echo 0 > {}' \; 
find /sys/bus/i2c/devices/0-002c/ -name 'in*_max' -exec /bin/sh -c '/bin/echo 10000 > {}' \; 
find /sys/bus/i2c/devices/0-002c/ -name 'temp*_min' -exec /bin/sh -c '/bin/echo 0 > {}' \;
find /sys/bus/i2c/devices/0-002c/ -name 'temp*_max' -exec /bin/sh -c '/bin/echo 100000 > {}' \;
find /sys/bus/i2c/devices/0-002c/ -name 'temp*_max_hyst' -exec /bin/sh -c '/bin/echo 0 > {}' \;
#find /sys/bus/i2c/devices/0-002c/ -name 'fan*_min' -exec /bin/sh -c '/bin/echo 0 > {}' \;
#find /sys/bus/i2c/devices/0-002c/ -name 'fan*_div' -exec /bin/sh -c '/bin/echo 2 > {}' \;

If I uncommment the last two lines I can always get the system to
hang, but I have sometimes been able to get it to hang by just setting
the in* and temp* limits as well.

I tried executing 'setpci  -s 0:1f.3 40.b=1', that command completed
without complaining but I didn't see any difference in the
behaviour. But I don't know how to verify that the setpci command
actually did what you were expecting it to do.

I noticed one more thing that might not make a difference here, in my
initial post I probably showed the output from sensors with the fan
sensors that are not used hidden (by setting the ignore option in
sensors.conf). I noticed that Fan7 is giving a negative value and has a
different default divisor and  min value. It is also the only fan
giving an alarm in the default state. I thought this might be
significant since setting the fan limits in the script above seem to
be what always caused the hang.

oden:~# sensors
w83792d-i2c-0-2c
Adapter: SMBus I801 adapter at 3080
VCoreA:    +1.69 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
VCoreB:    +1.70 V  (min =  +1.48 V, max =  +1.60 V)       ALARM
VIN0:      +2.96 V  (min =  +3.20 V, max =  +3.39 V)       ALARM
VIN1:      +2.97 V  (min =  +3.09 V, max =  +3.30 V)       ALARM
VIN2:      +2.96 V  (min =  +1.39 V, max =  +1.49 V)       ALARM
VIN3:      +2.96 V  (min =  +2.59 V, max =  +2.64 V)       ALARM
5VCC:      +4.94 V  (min =  +4.73 V, max =  +5.23 V)
5VSB:      +5.06 V  (min =  +4.73 V, max =  +5.23 V)
VBAT:      +3.23 V  (min =  +2.85 V, max =  +3.14 V)       ALARM
Fan1:     2616 RPM  (min = 1500 RPM, div = 4)
Fan2:        0 RPM  (min =  703 RPM, div = 8)
Fan3:     1480 RPM  (min =  703 RPM, div = 8)
Fan4:        0 RPM  (min =  703 RPM, div = 8)
Fan5:        0 RPM  (min =  703 RPM, div = 8)
Fan6:        0 RPM  (min =  703 RPM, div = 8)
Fan7:       -1 RPM  (min =    0 RPM, div = 2)              ALARM
Temp1:     +22.0?C  (high = +36.0?C, hyst = +31.0?C)   ALARM
Temp2:     +41.0?C  (high = +60.0?C, hyst = +57.0?C)   ALARM
Temp3:     +46.5?C  (high = +96.0?C, hyst = +93.0?C)   ALARM
chassis:  Chassis is normal.

Should I still try the UP kernel and an older kernel version?

-- 
Daniel Nilsson
