From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 Apr 2011 12:46:45 +0000
Subject: Re: [lm-sensors] w83795 fan control not working
Message-Id: <20110408144645.5890c9bd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110407150007.51dd1c06@endymion.delvare>
In-Reply-To: <20110407150007.51dd1c06@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Darren,

On Thu, 07 Apr 2011 13:59:13 -0700, Darren Hart wrote:
> On 04/07/2011 06:00 AM, Jean Delvare wrote:
> > On Wed, 06 Apr 2011 16:41:07 -0700, Darren Hart wrote:
> >> Quiet State:
> >> temp1:       +83.5°C  (high = +127.0°C, hyst = +127.0°C)
> >>              (crit = +127.0°C, hyst = +127.0°C)  sensor = thermal diode
> > 
> > This is very hot.
> 
> It is... and yet it's much hotter than anything reported by coretemp (which
> I assumed would have some of the higher temperatures).

Not necessarily, depending on your cooling mechanism. These days,
several parts of the system can be much hotter than the CPU, in
particular the graphics chip (for high end graphics cards) and the
north bridge.

> Any idea what temp1 might be measuring?

Could be the north bridge. On my own Intel 5500-based system, I am
using an external sensor to monitor the north bridge temperature, and
here is what I get:

TR2 Temp:     +92.2°C  (high = +85.0°C, hyst = +82.0°C)    ALARM
                       (crit = +90.0°C, crit hyst = +87.0°C)  sensor = thermistor

And I've already seen it hotter than this.

> $ sensors | grep °C
> Core 0:      +26.0°C  (high = +81.0°C, crit = +101.0°C)
> Core 1:      +26.0°C  (high = +81.0°C, crit = +101.0°C)
> Core 2:      +24.0°C  (high = +81.0°C, crit = +101.0°C)
> Core 8:      +22.0°C  (high = +81.0°C, crit = +101.0°C)
> temp1:       +40.0°C  (high = +138.0°C, hyst = +96.0°C)  sensor = thermistor
> temp2:       -61.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
> temp3:       +36.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
> temp1:       +75.0°C  (high = +127.0°C, hyst = +127.0°C)
>                       (crit = +127.0°C, hyst = +127.0°C)  sensor = thermal diode
> temp5:       +35.8°C  (high = +127.0°C, hyst = +127.0°C)
>                       (crit = +75.0°C, hyst = +70.0°C)  sensor = thermistor
> temp7:       +24.8°C  (high = +95.0°C, hyst = +92.0°C)
>                       (crit = +95.0°C, hyst = +92.0°C)  sensor = Intel PECI
> temp8:       +23.0°C  (high = +95.0°C, hyst = +92.0°C)
>                       (crit = +95.0°C, hyst = +92.0°C)  sensor = Intel PECI
> Core 9:      +25.0°C  (high = +81.0°C, crit = +101.0°C)
> Core 10:     +24.0°C  (high = +81.0°C, crit = +101.0°C)
> Core 0:      +24.0°C  (high = +81.0°C, crit = +101.0°C)
> Core 1:      +21.0°C  (high = +81.0°C, crit = +101.0°C)
> Core 2:      +20.0°C  (high = +81.0°C, crit = +101.0°C)
> Core 8:      +15.0°C  (high = +81.0°C, crit = +101.0°C)
> Core 9:      +22.0°C  (high = +81.0°C, crit = +101.0°C)
> Core 10:     +19.0°C  (high = +81.0°C, crit = +101.0°C)  

Unrelated to your issue, but the core numbering by coretemp is
surprising. I'm curious if you see the same in /proc/cpuinfo.

Please note that the temperatures reported by coretemp are not real,
absolute °C. They are a delta from the critical limit, the accuracy of
which degrades quickly with large deltas (i.e. low temperatures.) So,
all that can be said from the above "Core" temperature values is that
your CPUs run very cool and way below their critical limit (which is
good.)

Two of the three temperatures reported by the w83627ehf driver look
sane, so my advice to not load this driver might not have been correct.
It may be better to load it, and configure libsensors to ignore all the
unused inputs. 

> >> (...)
> >> pwmconfig reports the following:
> >>
> >> ---------------------------
> >> Found the following devices:
> >>    hwmon0/device is max1617
> > 
> > This would be very surprising and smells like a misdetection. Which
> > could, in turn, explain (some of) your problems. What the use of the
> > adm1021 driver suggested by sensors-detect?
> 
> Hrm, I noticed it reports:
> Intel Core family thermal sensor...                         No
> But if I load coretemp I get 12 sane temperature readings...

Presumably you are using a relatively old version of the sensors-detect
script. This version:
  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
should find the Intel Core family thermal sensor. It might also solve
the adm1021 mystery... Could be that you have thermal sensors in your
memory modules, and the jc42 driver would report their temperature.

> It does not detect adm1021, but it did report:

How did the adm1021 driver get loaded in the first place then? Please
note that sensors-detect needs hwmon drivers to be unloaded first to be
most efficient. 

> Trying family `National Semiconductor'...                   Yes
> Found unknown chip with ID 0x1a11

No idea what it is, and this is somewhat surprising as you already have
one identified Super-I/O chip (W83627DHG-P, as documented by
Supermicro.)

> However Kconfig says:
> 
> │ If you say yes here you get support for Analog Devices ADM1021          │
> │ and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,        │
> │ Genesys Logic GL523SM, National Semiconductor LM84, TI THMC10,          │
> │ and the XEON processor built-in sensor.  
>
> These are XEON CPUs, is this an older interface that has been replaced by
> something else?

This really only applies to an old generation of Xeon processors which
were popular in 2003. These days this help text is seriously
misleading, I'll fix it. Thanks for reporting.

> > I presume that the output
> > for the supposed max1617 chip in "sensors" is plain wrong? I would
> > advise that you do not load the adm1021 driver.
> 
> OK, unloaded.
> 
> >>    hwmon1/device is w83627dhg
> > 
> > Super-I/O (multifunction) chip, probably not used for monitoring.
> > Unloading the w83627ehf driver would make running pwmconfig much easier.
> 
> Done

As noted above, this driver might still be somewhat useful after all.

> > (...)
> > The next steps in pwmconfig should tell. One thing worth noting is that
> > you have 6 fan inputs used on the W83795ADG, but the chip has only two
> > fan control outputs. So it is impossible that you have one control per
> > fan. On my board, pwm1 controls both CPU fans and pwm2 controls all 6
> > case fans.
> 
> 
> I read somewhere during my hours of searching for a solution to this that
> both CPU fans are controlled by the same pwm signal, so that is not
> surprising. It's too bad about the case fans though, I really like to run
> the larger quiet fan up before bringing up the smaller front fan, but,
> it is what it is.

As you don't seem to be using the second CPU fan header, you could
cheat and plug your large rear fan in this header, so pwm1 would
control it (if we manage to get this to work at all...)

BTW, the Supermicro documentation is pretty clear that fan control is
only supported when using 4-pin fans. Is it what you're using?

> I ran pwmconfig again with adm1021, ipmi_si, and w83627ehf unloaded. This
> time it detected 8 pwm interfaces, and only pwm1 failed to enter manual mode.
> 
>    hwmon2/device is w83795g

Ouch. Last time your chip was a W83795ADG (the small version with only
2 fan control outputs) and now you are supposed to have a W83795G (the
big version with 8 fan control outputs.) The Supermicro product
description doesn't tell which is present, but to be fair, I've never
seen a W83795G on a PC mainboard so far, only W83795ADG.

Anyway, this suggests unreliable I/O on the SMBus. So even though you
have unloaded ipmi_si, which should guarantee that the Linux host isn't
accessing the chip through IPMI, I suspect that something else is still
accessing the chip in our back. A BMC for remote management?

Didn't you get an error message in the kernel logs related to w83795
register 0x001? This is where the driver gets the chip type from.

I think I get what's happening. The W83795G/ADG chips have so-called
banked registers, which means that you have to select the right bank
before accessing a given register. To improve register access time, the
driver remembers the currently selected bank, and only selects a
different bank when needed. Now, if somebody else accesses the chip
in our back, this assumption gets wrong suddenly.

I could change the driver to unconditionally set the bank before any
register access, at the price of severely decreased performance.
However, even this would not completely solve the problem, as whoever
else is accessing the chip might do so between the w83795 driver
setting the bank and the w83795 driver reading (or writing) the
register value - and nothing can be done against this.

The bottom line is that using the W83795 driver in a multi-master I2C
setup (and I strongly suspect this is what Supermicro did) is a bad
hardware design mistake. This hardware monitoring device wasn't
designed with this use case in mind.

> Found the following PWM controls:
>    hwmon2/device/pwm1
> hwmon2/device/pwm1 is currently setup for automatic speed control.
> In general, automatic mode is preferred over manual mode, as
> it is more efficient and it reacts faster. Are you sure that
> you want to setup this output for manual control? (n) y
> hwmon2/device/pwm1 stuck to 125
> 
> While trying to turn them off, I watched syslog:
> 
> During pwm3 test:
> Apr  7 08:40:48 rage kernel: [ 1617.363333] w83795 0-002f: Failed to read from register 0x023, err -6

The driver was temporarily unable to read the in19 value.

> I then searched for the pwm controls manually and tried adjusting them.
> I was able reduce fan noise considerably by echo'ing 0 to pwm1, and I
> brought it back up by echo'ing 125 to it. I didn't notice any change

Odd, this is exactly what pwmconfig is doing. It's hard to explain how
pwmconfig could consistently fail and your manual attempt worked right
away. It may not work always though?

> with the other pwms. Also, the fan speed as reported by sensors stayed
> constant, even though they obviously had slowed down considerably.

My bet is that you don't have pwm3 to pwm8 anyway, so it's expected
they had no effect.

> 
> # for PWM in $(find . -name "pwm[0-8]"); do echo $PWM; echo 0 > $PWM; echo -n "Off ($(cat $PWM))..."; sleep 5; echo 125 > $PWM; echo "On ($(cat $PWM))"; done
> ./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm1
> Off (0)...On (119)
> ./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm2
> Off (0)...On (0)
> ./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm3
> Off (0)...On (0)
> ./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm4
> Off (0)...On (0)
> ./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm5
> Off (0)...On (0)
> ./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm6
> Off (0)...On (0)
> ./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm7
> Off (0)...On (0)
> ./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm8
> Off (0)...On (0)
> 
> I ran pwmconfig again... and it didn't complain about pwm1 not entering
> manual mode. It was also able to bring the fans up and shut them down
> with pwm1. It did NOT detect a correlation however.

This is all consistent with my theory about random bank switches.

> I hit a bug in pwmconfig when configuring the pwm temperature input and fan speeds:
> 
> --------------
> Enter the low temperature (degree C)
> below which the fan should spin at minimum speed (20): 35
> 
> Enter the high temperature (degree C)
> over which the fan should spin at maximum speed (60): /usr/sbin/pwmconfig: line 923: [: -eq: unary operator expected
> /usr/sbin/pwmconfig: line 949: [: -eq: unary operator expected
> --------------
> 
> 923:
>                        if [ $FAN_MIN -eq 0 ]
> 949:
>                         if [ $FAN_MIN -eq 0 ]

Your line numbers don't match mine, which means you aren't using the
latest upstream version of pwmconfig. So I can't help, sorry.

> 
> Apparently, earlier in the script (line 877):
> 
>                 FAN_MIN=`echo $fanactive_min|cut -d' ' -f$REPLY`
> 
> sets FAN_MIN to "" instead of a number. Adding some debug confirms this:
> 		FAN_MIN=`echo $fanactive_min|cut -d' ' -f$REPLY`
>                 # dvhart debug
>                 if [ -z "$FAN_MIN" ]; then
>                         echo "FAN_MIN detection failed, setting to 0."
>                         FAN_MIN=0
>                 fi
> 
> ------------
> FAN_MIN detection failed, setting to 0.
> ------------

This certainly explains why a correlation couldn't be found. Your
workaround however is not correct. If fanactive_min has fewer elements
than expected, this means that CURRENT_SPEEDS too, but you don't know
which ones are missing, because CURRENT_SPEEDS is a string, not an
array. We should really be using proper bash arrays for robustness, but
I simply don't have the time to work on this these days.

Overall the pwmconfig (and fancontrol) code isn't good quality, partly
because it started as an afternoon hack and has grown way too old,
partly because writing nice and efficient code in bash can be quite
challenging. I think someone posted on the lm-sensors list to announce
a rewrite in C, which might be a better starting point.

> 
> ------------
> Enter the low temperature (degree C)
> below which the fan should spin at minimum speed (20): 35
> 
> Enter the high temperature (degree C)
> over which the fan should spin at maximum speed (60): 
> Enter the minimum PWM value (0-255)
> at which the fan STOPS spinning (press t to test) (100): t
> 
> Now we decrease the PWM value to figure out the lowest usable value.
> We will use a slightly greater value as the minimum speed.
> ------------
> 
> After fixing that, the detection of the lowest value (where the fan
> stops) ran for 30 minutes without indicating any forward progress or
> making an audibly detectable change in fan speed. I tried adjusting
> it manually, and was able to make several speed adjustments, finding
> the min value somewhere between 35 and 50 (sys reports 'pwm1_start:

This suggests more problems in pwmconfig, it isn't supposed to behave
that way. But again the root cause is probably the kernel driver not
behaving in the standard way pwmconfig expects. In turn caused by the
hardware playing tricks on you.

> 48'). Before I could finish, the interface stopped responding to
> commands. I reloaded the w83795 module, and pwmconfig then reported:
> 
> /usr/sbin/pwmconfig: There are no fan-capable sensor modules installed
> 
> And sensors only reported:
> 
> # sensors
> w83795g-i2c-0-2f
> Adapter: SMBus I801 adapter at 0400
> beep_enable:enabled

Wow. Your system is very strange. I can't even think of how such an
output would be possible at all.

> > Does the board manual say whether the case fans are supposed to be
> > controllable, or only the CPU fans?
> 
> It is rather vague on the topic unfortunately:
> 
> "Fan status monitor with firmware control and CPU fan auto-off in sleep mode"
> "Pule Width Modulation (PWM) Fan Control"
> "The PC health monitor can check the RPM status of the cooling fans. The
> onboard CPU and chassis fans are controlled by Thermal Management via BIOS
> (under Hardware Monitoring in the Advanced Setting)."

I read this as: all fans should be controllable. 

> And under the Nuvoton WPCM450R Controller (the baseboard management
> controller):
> "The WPCM450R communicates with onboard components via six SMBus interfaces,
> fan control, and Platform Environment Control Interface (PECI) buses."

This seems to be a complex setup, unfortunately the block diagram in
the manual mentions neither SMBus nor PECI.

> The case fans are definitely controllable given my experiment above on pwm1.
> pwm2 doesn't appear to do anything... and I'm not sure what 3-8 are supposed
> to do :-)

As said before, I am certain you won't have pwm3-8 at all so they
aren't supposed to do anything.

> >> (...)
> >> dmesg reports:
> >> $ dmesg | grep 83795
> >> [   12.643929] i2c i2c-0: Found w83795adg rev. B at 0x2f
> >> [   12.883789] w83795 0-002f: PECI agent 1 Tbase temperature: 100
> >> [   12.903779] w83795 0-002f: PECI agent 2 Tbase temperature: 100
> >> [ 2288.932629] w83795 0-002f: Failed to read from register 0x030, err -6
> >> [ 2613.292773] w83795 0-002f: Failed to write to register 0x040, err -6
> >> [ 2693.333461] w83795 0-002f: Failed to read from register 0x01e, err -11
> > 
> > -6 is -ENXIO, returned by the i2c-i801 driver when a slave I2C device
> > doesn't answer. -11 is -EAGAIN, meaning arbitration loss, which can
> > happen on multi-master I2C buses, and I guess IPMI is implemented
> > exactly that way.
> > 
> >> Am I doing something wrong?
> > 
> > Yes. You are using IPMI and a native Linux driver to access the same
> > monitoring chip. Both access methods don't know of each other and are
> > not synchronized.
> 
> OK, I removed the ipmi_si driver early on and am still seeing the
> problems described above.

Probably caused by concurrent accesses from the BMC.

> >> Can I provide any additional information to
> >> help narrow down what might be wrong?
> > 
> > Choose between IPMI and native drivers. If you want to use IPMI on this
> > board, then you have to forget about the w83795 driver. And about
> > software-driven fan speed control too, I'm afraid.
> 
> Does that mean all IPMI features? I'd hate to have to lose SOL and power control.

It's hard to tell what exactly IPMI is doing. Clearly if you want to
use IPMI then the w83795 driver is out IMHO, and you'll suffer from the
lack of integration between IPMI and libsensors.

> > Did you look for a BIOS or IPMI firmware update already?
> 
> IPMI is current.
> BIOS had an update available. After hunting down a FreeDOS USB boot image, I
> managed to flash it. pwmconfig is much happier now, and the sensors report
> the fan speed correctly now. pwmconfig walked through the PWM:RPM mapping
> for fan2_input, and all three fans dropped along with it. When it started
> in on fan4_input produced an error:
> 
> ----------
>   hwmon2/device/fan4_input ... speed was 4285 now 1058
>     It appears that fan hwmon2/device/fan4_input
>     is controlled by pwm hwmon2/device/pwm1
> /usr/sbin/pwmconfig: line 464: hwmon2/device: expression recursion level exceeded (error token is "device")
> Testing is complete.
> ----------
> 
> line 464
> fanactive="$(($j+${fanactive}))" #not supported yet by fancontrol

I had never seen this error message before. But I also don't have the
line above in my copy of pwmconfig either. Are you by any chance using a
packaged version with custom patches?

> fancontrol appears to work now as well. It appears all my fans are connected
> to the same PWM control, which is pretty unfortunate, but things are MUCH
> better now than they were. It appears there are a few scripting bugs in
> pwmconfig (at least in my distro version) that can be corrected with

Please test the upstream version. If you find bugs in your distro
version which aren't upstream, report to them, not us. And please ask
them to push their changes upstream (if they are good) or drop them (if
not.)

> some string checking, but the core problem appears to be a buggy BIOS -
> big surprise ;-)

I don't want to bash your optimism, but... My personal impression is
that there is a severe design issue on this board, which will prevent
you from using the w83795 driver.

> I am not sure which temperature sensor to use to control pwm1. I don't trust
> the temp1 input of 82C, temp5 reads 39 idle, and 7 and 8 read about 25 idle.
> While the coretemp sensors read 24-29.
> 
> temp1:       +82.5°C  (high = +127.0°C, hyst = +127.0°C)  
>                       (crit = +127.0°C, hyst = +127.0°C)  sensor = thermal diode
> temp5:       +39.0°C  (high = +127.0°C, hyst = +127.0°C)  
>                       (crit = +75.0°C, hyst = +70.0°C)  sensor = thermistor
> temp7:       +25.0°C  (high = +95.0°C, hyst = +92.0°C)  
>                       (crit = +95.0°C, hyst = +92.0°C)  sensor = Intel PECI
> temp8:       +22.8°C  (high = +95.0°C, hyst = +92.0°C)  
>                       (crit = +95.0°C, hyst = +92.0°C)  sensor = Intel PECI

temp5 is the system (board) temperature temp7 is CPU1 and temp8 is
CPU2. I would use temp5 for case fans, and temp7 for CPU fans. A
perfect fan control system would allow you to take the max or average
of multiple temperatures, but we don't support this.

But then again, in your case, software driven fan control seems out of
the question. Way too dangerous when you don't know if you'll be able
to access the monitoring chip the next minute. I really wish board
vendors would let people tweak the automatic fan speed control settings
in the BIOS. Asus offers several profiles, which is better than
nothing, but it would seem fair to let the user set the temperature
limits manually. Sigh.

> # sensors | grep Core
> Core 0:      +27.0°C  (high = +81.0°C, crit = +101.0°C)  
> Core 1:      +28.0°C  (high = +81.0°C, crit = +101.0°C)  
> Core 2:      +27.0°C  (high = +81.0°C, crit = +101.0°C)  
> Core 8:      +25.0°C  (high = +81.0°C, crit = +101.0°C)  
> Core 9:      +28.0°C  (high = +81.0°C, crit = +101.0°C)  
> Core 10:     +26.0°C  (high = +81.0°C, crit = +101.0°C)  
> Core 0:      +25.0°C  (high = +81.0°C, crit = +101.0°C)  
> Core 1:      +23.0°C  (high = +81.0°C, crit = +101.0°C)  
> Core 2:      +21.0°C  (high = +81.0°C, crit = +101.0°C)  
> Core 8:      +17.0°C  (high = +81.0°C, crit = +101.0°C)  
> Core 9:      +24.0°C  (high = +81.0°C, crit = +101.0°C)  
> Core 10:     +20.0°C  (high = +81.0°C, crit = +101.0°C)  
> 
> 
> And as I'm typing this, dmesg started spewing a lot of errors and temp1-5 now report 0°C
> 
> [ 1056.545180] w83795 0-002f: Failed to write to register 0x040, err -6
> [ 1056.585158] w83795 0-002f: Failed to read from register 0x041, err -6
> [ 1056.605143] w83795 0-002f: Failed to read from register 0x042, err -6
> [ 1056.645123] w83795 0-002f: Failed to read from register 0x043, err -6
> [ 1056.685094] w83795 0-002f: Failed to read from register 0x044, err -6
> [ 1056.705084] w83795 0-002f: Failed to read from register 0x045, err -6
> [ 1056.745057] w83795 0-002f: Failed to read from register 0x046, err -6
> [ 1056.765044] w83795 0-002f: Failed to write to register 0x040, err -6
> ....
> [ 1060.442767] w83795 0-002f: Failed to set bank to 2, err -6
> [ 1060.482745] w83795 0-002f: Failed to set bank to 2, err -6
> [ 1060.502728] w83795 0-002f: Failed to set bank to 2, err -6
> ...
> [ 1060.702605] w83795 0-002f: Failed to read from register 0x040, err -6
> [ 1060.722590] w83795 0-002f: Failed to read from register 0x046, err -6
> [ 1060.762569] w83795 0-002f: Failed to write to register 0x040, err -6
> ...
> and on for pages.
> 
> Reloading w83795 stops the messages, but the w83795 sensors don't come back.
> 
> OK, that's a ton of data, hopefully it's good data.

Oh, I suddenly have an idea what may be going on. If I'm right, it even
worse than I thought at first.

I guess that your SMBus is multiplexed. The errors -6 (-ENXIO) mean the
W83795ADG chip is unreachable, presumably because the multiplexer was
switched to a different segment. If the multiplexer is out of the
operating system's control (as seems to be the case here) then you
really have to give up the w83795 driver, much to my despair.

You may be able to get the w83795 driver working again by invoking
ipmitool. If IPMI know how to switch back to the right SMBus segment,
it may leave it selected afterwards. But anyway this is just a trick,
nothing you can rely on in the long run, as the conflict between w83795
and the BMC isn't one we can solve.

It might be the right time for you to ask the Supermicro support for a
detailed topology of the I2C/SMBus on this board.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
