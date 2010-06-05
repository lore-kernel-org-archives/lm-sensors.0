From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Jun 2010 12:39:50 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GMT-UD2H
Message-Id: <20100605143950.442b4c56@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
In-Reply-To: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 04 Jun 2010 10:44:00 -0700, David Mathog wrote:
> > Hmm, could be due to the CPU speed scaling.  In the BIOS I'm pretty sure
> > the CPUs are both running at their maximum speed of 2800MHz, but in
> > Windows and linux they scale down to 800MHz.  Plugged a DMM into a molex
> > connector and measured this for the performance and ondemand governors:
> >      2800MHz  800Mz
> > 5V    5.07    5.06
> > 12V  12.03    12.04
> 
> A slightly different table:
>                               DMM
> BIOS measurement  11.985    = 12.00
> W7 speedfan       12.10     = 12.02
> in4/lm_sensors    3.02/3.04 = 12.03 (2800MHz)
> in4/lm_sensors    3.02/3.04 = 12.04 (800MHz)
> 
> So it does look like 12V in the BIOS mode really is a hair lower than it
> is in either linux or W7.  Using 3.03 for the avg in4 measurement and
> 12.035 for the avg DMM measurement gives a scale factor of 3.97,
> assuming the DMM is actually correct.

This is very interesting. Even if your DMM isn't accurate for absolute
readings, using it as a comparison point for relative differences if a
very good idea. I'll try to remember it for next time.

Note that, even if the DMM was infinitely accurate, comparing the
absolute values wouldn't make much sense: Voltage scaling is achieved
by the means of resistors, the value of which is known only with
limited accuracy. Even with 1% resistors, this means the reading in the
BIOS is +/-2% of the actual voltage (not even counting the limited
resolution of the sensor, which makes things worse in practice.)

So 3.97 might be the best scaling factor for your own (physical) board,
but this doesn't mean this is the right value for the model. We'd need
many more samples to make sure, if we really cared to that degree of
detail.

My own computations, which aim at getting the same result as the BIOS
for a given voltage value, led me to a scaling factor of 3.9843. And
guess what, 255 / 64 = 3.9843. This is certainly no coincidence, and I'm
reasonably certain that this is the computation done by the BIOS:
(reg * 0xff) >> 6.

OTOH, I can't find a combination of E96 (1%) resistors that would lead
to this exact scaling factor. So it is also possible that the BIOS is
wrong (wouldn't be the first time...) in which case we don't really
have a comparison point.

The bottom line is that we should probably stop wasting our time
polishing this configuration file, we've already made a good work IMHO
and your +12V line seems to be just fine so we should leave it alone
now ;)

So this is my final version:

# lm_sensors 3 configuration file for the Gigabyte MA785GMT-UD2H motherboard
# 2010-06-05, Jean Delvare <khali@linux-fr.org>
# Written for board revision 1.1, may or may not be suitable for other
# revisions. Thanks to David Mathog for testing and reporting.
# Comments welcome!

chip "it8718-*"

### Voltages

   # in7 is mysterious, it lives in the range 2.00 to 2.90 V, and seems to
   # change with CPU frequency and possibly CPU load. No idea what it can
   # be.

   label  in0  "Vcore"
   label  in1  "Vram"    # "DDR3" in BIOS
   label  in2  "+3.3V"
   label  in3  "+5V"     # Not in BIOS
   label  in4  "+12V"
   label  in5  "3VSB"    # Not in BIOS, guessed
   ignore in6
   label  in8  "Vbat"    # Not in BIOS

   # Vcore, Vram, +3.3V and Vbat are connected directly, so no compute
   # line is needed for these. For +5V the chip is configured to use
   # internal scaling. Scaling for +12V is apparently not standard, my
   # guess is that the BIOS uses 255/64 as the scaling factor. Not sure
   # if it matches the physical reality.
   compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
   compute  in4  @ * (255/64),   @ / (255/64)

   # The BIOS won't set any limit for voltages.

   set in0_min  0.825 * 0.95
   set in0_max  1.425 * 1.05
   set in1_min  1.5   * 0.95
   set in1_max  1.6   * 1.05
   set in2_min  3.3   * 0.95
   set in2_max  3.3   * 1.05
   set in3_min  5     * 0.95
   set in3_max  5     * 1.05
   set in4_min 12     * 0.95
   set in4_max 12     * 1.05
   set in5_min  3.3   * 0.95
   set in5_max  3.3   * 1.05

### Temperatures

   # The BIOS only shows 2 temperature values, so temp1 might not be
   # actually used.

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
