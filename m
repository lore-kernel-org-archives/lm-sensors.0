From: kevin.c.williams3@boeing.com (Williams, Kevin C)
Date: Fri, 10 Feb 2006 22:58:09 +0000
Subject: [lm-sensors] Can't load smsc47m1: no such device
Message-Id: <34919D5FCCAB494F97265DA64D1D703001AFCDF4@XCH-SW-1V1.sw.nos.boeing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <34919D5FCCAB494F97265DA64D1D703001AFCDF0@XCH-SW-1V1.sw.nos.boeing.com>
In-Reply-To: <34919D5FCCAB494F97265DA64D1D703001AFCDF0@XCH-SW-1V1.sw.nos.boeing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Boy, I love yum.  2.6.15-1.1831FC4smp kernel is installed now.

I ran sensor-detect and got the same output as before. i.e. no driver
for smsc47m14x/192.  So I did a 'modprobe smsc47m1' just in case and
didn't get any error.  Output from 'dmesg' was:
smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997
-------

Ouput from 'sensors' now, is:
~]# sensors
smsc47m1-isa-0800
Adapter: ISA adapter
fan1:        0 RPM  (min = 2560 RPM, div = 2)
fan2:        0 RPM  (min = 2560 RPM, div = 2)
--------

Obviously, it's not 0. So I ran 'pwmconfig' and instantly, the processor
fans shutoff(because this is SFF, there are 2 fans each side of the
heatsink).  Here's the output:
~]# pwmconfig
Found the following PWM controls:
   9191-0800/pwm1
   9191-0800/pwm2

Found the following fan sensors:
   9191-0800/fan1_input     current speed: 5585 RPM
   9191-0800/fan2_input     current speed: 5461 RPM

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control 9191-0800/pwm1 ...
  9191-0800/fan1_input ... speed was 5585 now 0
    It appears that fan 9191-0800/fan1_input
    is controlled by pwm 9191-0800/pwm1
    Fan 9191-0800/fan1_input has not returned to speed, please
investigate!
  9191-0800/fan2_input ... speed was 5461 now 0
    It appears that fan 9191-0800/fan2_input
    is controlled by pwm 9191-0800/pwm1
    Fan 9191-0800/fan2_input has not returned to speed, please
investigate!

Testing pwm control 9191-0800/pwm2 ...
  9191-0800/fan1_input ... speed was 5585 now 0
    It appears that fan 9191-0800/fan1_input
    is controlled by pwm 9191-0800/pwm2
    Fan 9191-0800/fan1_input has not returned to speed, please
investigate!
  9191-0800/fan2_input ... speed was 5461 now 0
    It appears that fan 9191-0800/fan2_input
    is controlled by pwm 9191-0800/pwm2
    Fan 9191-0800/fan2_input has not returned to speed, please
investigate!

Testing is complete.
Please verify that all fans have returned to their normal speed.

The fancontrol script can automatically respond to temperature changes
of your system by changing fanspeeds.
Do you want to set up its configuration file now (y)? y
/usr/sbin/pwmconfig: There are no temperature-capable sensor modules
installed
-----

In the beginning you can see that it reports the fan speeds correctly.
In the bios, it reports similar values.  However, while it is able to
successfully shut the fans down, it can't bring them back up(which I
verified was true...and bad, so I rebooted into bios).

Any suggestions here, it looks like there's a way to detect fan speed
and turn it off, now I just need to fine tune it.

-Kevin

> -----Original Message-----
> From: Jean Delvare [mailto:khali at linux-fr.org] 
> Sent: Friday, February 10, 2006 2:13 PM
> To: Williams, Kevin C
> Cc: LM Sensors
> Subject: Re: [lm-sensors] Can't load smsc47m1: no such device
> 
> Hi Kevin,
> 
> > My fan speed is at the highest possible speed when booted 
> into linux 
> > on this system(same as speed during POST).  Load is 0.00 
> and x-windows 
> > is not installed. Winxp has a no audible fan noise unless 
> doing high 
> > computation but never as high as with linux.  So, I decided 
> to figure 
> > out how to tweak the fan speed.
> > 
> > 'sensors-detect' found SMSC 47M15x/192 and I found that in 
> the drivers 
> > section of the website, I(think) can use the 'smsc47m1' 
> driver.  So I 
> > tried it:
> > ~]# modprobe smsc47m1 force_addr=0x0800
> > FATAL: Error inserting smsc47m1
> > 
> (/lib/modules/2.6.11-1.1369_FC4smp/kernel/drivers/i2c/chips/smsc47m1.k
> > o)
> > : No such device
> 
> Support for the SMSC LPC47M15x/192 chip was added to the 
> smsc47m1 driver in Linux 2.6.13. Your kernel is older so the 
> support is simply not there. Unfortunately, there is no way 
> to force a device with that kind of driver. So your only hope 
> is a newer kernel (or a self compiled kernel from patched sources).
> 
> --
> Jean Delvare
> 

