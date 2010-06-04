From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Jun 2010 11:43:24 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GMT-UD2H
Message-Id: <20100604134324.50fa72bf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
In-Reply-To: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Thu, 03 Jun 2010 10:56:12 -0700, David Mathog wrote:
> > OK, most probably the chip is on an Nvidia graphics adapter. To get it
> > to work, you'll need to run sensors-detect again and write down the i2c
> > bus number and the address at which the chip is detected.
> 
> i2c-2, found lm90
> also
> I2c 0x4c

OK, then you can run the following command to instantiate the device:

echo lm90 0x4c > /sys/bus/i2c/devices/i2c-2/new_device

> > (...)
> > Works for me...
> 
> Got it through an anonymizer.  Apparently khali's web server or firewall
> is blocking Caltech.  I have seen this before on a couple of other
> sites, sometimes our central mail server gets blacklisted and that ends
> up in other sites' firewall rules.

Odd. I've asked my ISP for details, but I'm not holding my breath.

> > (...)
> > Did you check for an update on their website maybe?
> 
> Yes.  The current version has an AODDriver.sys with an invalid checksum
> once installed, and W7 blocks it from running.

Oh well. I'm glad I'm away from the Windows world ;)

> > Remaining points:
> > 
> > * Voltages: I don't know which of in4, in5 or in7 corresponds to +12V.
> >   I suspect in4, but I'm not certain. Please write down all the values
> >   displayed for +12V in the BIOS, and then all the values displayed for
> >   in4, in5 and in7 by "sensors". Voltage sensors almost always
> >   oscillate between two values, sometimes more. If in4 is +12V, then
> >   maybe in5 may be +3.3 Stand-By (3VSB). No idea about in7.
> 
> In4 oscillates between 3.02 and 3.04, in5 is stable at 3.36, in7 reads
> 2.00 or 2.02.  In the BIOS reading there is no oscillation. +12V is
> 11.985V and +3.3V=3.344V.

Did you try leaving the monitoring panel and entering it again? Maybe
the BIOS doesn't update the values dynamically.

It would be very useful to have another BIOS value for +12V. You might
change the value by temporarily adding a fan and/or a disk drive to the
system.

Anyway, I still believe that in4 is +12V, and Speedfan seems to agree.
I disagree with their scaling though, they apparently used a scaling
factor of 4.00, but this makes their reading diverge a lot from the
BIOS': 12.16 V instead of 11.985 V. The scaling factor is more likely
in the 3.94-3.97 range. I have an old nForce2 board here where they
used 3.963 (according to my guesses back then), maybe that's the same
on yours.

> > * Temperatures: I really don't know who is who, nor whether the sensor
> >   types are set properly. Try comparing the temperatures between idle
> >   and full load. If one value raises much faster than the others, that
> >   would be the CPU temperature. Also check the motherboard manual, if
> >   they say where the thermal sensors are, that would be useful.
>  
>                   2xburnK7               idle
> Temp1              29.0                   30.0
> Temp2              49.0                   28.0
> Temp3              43.0                   30.0
> K10Temp1           41.0                   19.5

This suggests that temp1 is either unused or used for a part which
doesn't work too hard ;) Maybe a sensor on the board itself. Would be
interesting to see if it's affected by the case being opened or closed.
It might really be unused though - after all the BIOS only displays 2
temperature values.

temp2 would be the CPU temperature. temp3 could be the north bridge,
after all it has a dedicated fan so it's probably worth monitoring.

> The K10 temperature rises/falls more slowly than temp2 or temp3.

This is strange, as the digital sensor is supposed to be very close to
the core.

> > * Fans: please check how many fan headers your board has. If you have a
> >   spare fan, I would appreciate if you could plug it in the free
> >   header(s). This will help us figure out the labels of fan2 and fan3.
> >   My guess is that one of them is what the BIOS labels SysFan, and the
> >   other one is not connected.
> 
> There are 3:
> fan1  CPU_FAN
> fan2  SYS_FAN
> fan4  NB_FAN

Thanks, at least this part is done now.

> verified by plugging/unplugging that this was how they mapped.  I
> plugged a 60mm ~5000rpm fan into SYS_FAN and it read only 2710 RPM, but
> in the BIOS it had "System Smart Fan Control is enabled", so the
> motherboard may have been running it at less than full speed.  The test
> fan only has 3 pins, plugged into a 4 pin header.  Since the speed
> control should be on pin 4, which isn't connected, I think maybe SYS_FAN
> is off by a factor of 2. Did not test SYS_FAN speed in the BIOS.  

I wouldn't conclude too fast, as the IT8718F datasheet doesn't say
anything about 4-pin fan support. But the board manual claims that pin
4 of SYS FAN is "reserved", so maybe they do traditional 3-pin-style
control on that header.

(OTOH they claim that pin 3 of the NB FAN is not connected, which is
certainly wrong, otherwise you wouldn't get a speed reading for that
fan. So the manual may not be trustworthy.)

Testing in the BIOS and with "Smart Fan" disabled would certainly be a
good idea. Fan speeds normally need no scaling, unless they have a pole
count different from 4 (but then this is a per-fan setting.)

There seems to be many hardware revisions of your board. For the
records, can you tell us which one you have?

Here's my current config, which I will also upload. Basically I'm happy
with everything except +12V (which we should be able to figure out at
least approximately), temp1 and in7 (but it doesn't matter that much.)

# lm_sensors 3 configuration file for the Gigabyte MA785GMT-UD2H motherboard
# 2010-06-04, Jean Delvare <khali@linux-fr.org>
# Thanks to David Mathog for testing and reporting.
# Comments welcome!

chip "it8718-*"

### Voltages

   label  in0  "Vcore"
   label  in1  "Vram"    # "DDR3" in BIOS
   label  in2  "+3.3V"
   label  in3  "+5V"     # Not in BIOS
   label  in4  "+12V"
   label  in5  "3VSB"    # Not in BIOS, guessed
   ignore in6
#  label  in7  "???"     # No idea about that one, maybe -12V?
   label  in8  "Vbat"    # Not in BIOS

   # Vcore, Vram, +3.3V and Vbat are connected directly, so no compute
   # line is needed for these. For +5V the chip is configured to use
   # internal scaling. Scaling for +12V isn't known yet.
   compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
#  compute  in4  @ * ( 30/10+1), @ / ( 30/10+1)

   # The BIOS won't set any limit for voltages.

   set in0_min  0.825 * 0.95
   set in0_max  1.425 * 1.05
   set in1_min  1.5   * 0.95
   set in1_max  1.6   * 1.05
   set in2_min  3.3   * 0.95
   set in2_max  3.3   * 1.05
   set in3_min  5     * 0.95
   set in3_max  5     * 1.05
#  set in4_min 12     * 0.95
#  set in4_max 12     * 1.05
   set in5_min  3.3   * 0.95
   set in5_max  3.3   * 1.05

### Temperatures

   label  temp1  "Sys Temp"    # Needs confirmation
   label  temp2  "CPU Temp"
   label  temp3  "NBr Temp"    # Guessed

   set temp1_min  10
   set temp1_max  50
   set temp2_min  10
   set temp2_max  60
   set temp3_min  10
   set temp3_max  50

### Fans

   label  fan1  "CPU Fan"
   label  fan2  "Case Fan"
   ignore fan3
   label  fan4  "NBr Fan"

   # Adjust for your own fans
   set fan1_min 1500
   set fan4_min 1000


-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
