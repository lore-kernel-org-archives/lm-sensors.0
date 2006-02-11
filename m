From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 11 Feb 2006 19:52:23 +0000
Subject: [lm-sensors] Can't load smsc47m1: no such device
Message-Id: <20060211205223.6f6a47c7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <34919D5FCCAB494F97265DA64D1D703001AFCDF0@XCH-SW-1V1.sw.nos.boeing.com>
In-Reply-To: <34919D5FCCAB494F97265DA64D1D703001AFCDF0@XCH-SW-1V1.sw.nos.boeing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kevin,

> I ran sensor-detect and got the same output as before. i.e. no driver
> for smsc47m14x/192.  So I did a 'modprobe smsc47m1' just in case and
> didn't get any error.  Output from 'dmesg' was:
> smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997
> -------
> 
> Ouput from 'sensors' now, is:
> ~]# sensors
> smsc47m1-isa-0800
> Adapter: ISA adapter
> fan1:        0 RPM  (min = 2560 RPM, div = 2)
> fan2:        0 RPM  (min = 2560 RPM, div = 2)
> --------
> 
> Obviously, it's not 0.

This is strange. I would have suggested that you increase the fan clock
dividers (fan1_div and fan2_div in /etc/sensors.conf) but the output of
pwmconfig below suggest that it was able to measure the speed of the
fans, and that this speed is over 5000 RPM so a clock divider of 2
should work just fine. I can't explain why pwmconfig was able to
monitor the fans when "sensors" wasn't - it doesn't make much sense.

> So I ran 'pwmconfig' and instantly, the processor
> fans shutoff(because this is SFF, there are 2 fans each side of the
> heatsink).  Here's the output:
> ~]# pwmconfig
> Found the following PWM controls:
>    9191-0800/pwm1
>    9191-0800/pwm2
> 
> Found the following fan sensors:
>    9191-0800/fan1_input     current speed: 5585 RPM
>    9191-0800/fan2_input     current speed: 5461 RPM
> 
> Warning!!! This program will stop your fans, one at a time,
> for approximately 5 seconds each!!!
> This may cause your processor temperature to rise!!!
> If you do not want to do this hit control-C now!!!
> Hit return to continue:
> 
> Testing pwm control 9191-0800/pwm1 ...
>   9191-0800/fan1_input ... speed was 5585 now 0
>     It appears that fan 9191-0800/fan1_input
>     is controlled by pwm 9191-0800/pwm1
>     Fan 9191-0800/fan1_input has not returned to speed, please
> investigate!
>   9191-0800/fan2_input ... speed was 5461 now 0
>     It appears that fan 9191-0800/fan2_input
>     is controlled by pwm 9191-0800/pwm1
>     Fan 9191-0800/fan2_input has not returned to speed, please
> investigate!
> 
> Testing pwm control 9191-0800/pwm2 ...
>   9191-0800/fan1_input ... speed was 5585 now 0
>     It appears that fan 9191-0800/fan1_input
>     is controlled by pwm 9191-0800/pwm2
>     Fan 9191-0800/fan1_input has not returned to speed, please
> investigate!
>   9191-0800/fan2_input ... speed was 5461 now 0
>     It appears that fan 9191-0800/fan2_input
>     is controlled by pwm 9191-0800/pwm2
>     Fan 9191-0800/fan2_input has not returned to speed, please
> investigate!
> 
> Testing is complete.
> Please verify that all fans have returned to their normal speed.
> 
> The fancontrol script can automatically respond to temperature changes
> of your system by changing fanspeeds.
> Do you want to set up its configuration file now (y)? y
> /usr/sbin/pwmconfig: There are no temperature-capable sensor modules
> installed
> -----
> 
> In the beginning you can see that it reports the fan speeds correctly.
> In the bios, it reports similar values.  However, while it is able to
> successfully shut the fans down, it can't bring them back up(which I
> verified was true...and bad, so I rebooted into bios).

That's bad :(

> Any suggestions here, it looks like there's a way to detect fan speed
> and turn it off, now I just need to fine tune it.

Well I think you jumped the gun. You should take some time to get
"sensors" to work, then to manually control the speed of your fans.
Once this is OK, and only then, you should consider running pwmconfig
again.

First, if you have the opportunity to upgrade the version of lm_sensors
you are using, take it. I have no particular fix in mind, but this
can't hurt.

Then, you must get "sensors" to display the speed of your fans. You may
try changing the low speed limits too, just to make sure your chip is
behaving as intended. This tweaking is done in file /etc/sensors.conf,
section "smsc47m1-*". Try the following for example, and see if it
works:

   set fan1_div 4
   set fan2_div 4
   set fan1_min 2000
   set fan2_min 2000

Once you have proper readings, try changing the fan speeds manually.
This is done by writing values to sysfs files.
Under /sys/class/hwmon/hwmon0/device, you should find files named:

  fan1_div
  fan1_input
  fan1_min
  fan2_div
  fan2_input
  fan2_min
  pwm1
  pwm1_enable
  pwm2
  pwm2_enable

fan* files are for monitoring ("sensors" reads its values from there),
pwm* files are for speed control. pwmN_enable is a boolean switch, 0
disables PWM (pulse width modulation), which means that the
corresponing fan is running at full speed); 1 means enabled. When
pwmN_enable is set to 1, pwmN controls the speed. Values range from 0
(fan stopped, don't do that) to 254 (fan at full speed).

Usually pwm1 corresponds to fan1 and pwm2 corresponds to fan2, but it
doesn't have to be the case so you'll have to experiment with your
actual hardware setup.

As pwmconfig was not able to restore your fans to full speed, I'd
expect you to have some problems too. Try decreasing the fan speeds
step by step. I can't tell much more at this point as I can't explain
what you observed, but maybe playing with the controls by yourself will
make you understand what went wrong. If you can figure out, please
report so that we can see what can be done to improve the situation.

-- 
Jean Delvare

