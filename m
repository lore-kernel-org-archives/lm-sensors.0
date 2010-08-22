From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Aug 2010 14:13:07 +0000
Subject: Re: [lm-sensors] Config for MSI X58 Pro-E (MS-7522)
Message-Id: <20100822161307.7a9ba663@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C6BFB8A.7060300@mandel.name>
In-Reply-To: <4C6BFB8A.7060300@mandel.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Aug 2010 15:13:05 +0200, Olaf Mandel wrote:
> Am 22.08.2010 14:38, schrieb Jean Delvare:
> -Snipp-
> > On Wed, 18 Aug 2010 17:26:02 +0200, Olaf Mandel wrote:
> -Snipp-
> >> * The System1 fan could be on either fan2 or fan3
> > 
> > This should be easy enough to verify. You can temporarily unplug any
> > system fan (or slow it down by pressing your finger on the middle part -
> > don't get hurt), and see which reported speed drops.
> > 
> Hi Jean,
> 
> unfortunately, I cannot do that: the motherboard is build into a
> root-server I rented and is located in a remote location I have no
> physical access to. I can ask for access to its monitor and keyboard via
> a remote KVM solution in order to access the BIOS information, but that
> is about the end of it. The server operator charges per 15min of "remote
> hands", and I am to stingy to ask them to swap the fan connection.

OK, I get the situation better now.

> >> * There are several 3.3V inputs, but which one corresponds to the one
> >> shown in the BIOS?
> > 
> > Most certainly in0. in7 is 3VSB (Stand-By 3.3V) and in8 is Vbat
> > (battery). It's quite rare that BIOS reports these.
> > 
> Thanks for the info. I have updated my configuration file accordingly.
> 
> >> * The calibration values for in1, in4 and in5 are only approximations
> >> * No min, max or critical values are given here.
> > 
> > Easy enough to add once you are certain your configuration is OK.
> > 
> If you mean the thresholds: how does one decide on which values are
> max/min, or critical?

Oh, now I remember that the Fintek F71882FG is actually quite limited
when it comes to thresholds: only temperatures, and in1, support them.

For voltages, you typically set min to -5% of nominal and max to +5% of
nominal. For temperatures, it depends a lot of your CPU, case, cooling,
usage and expectations. Assuming your system works fine, the idea would
be to set the high limit somewhat higher to the maximum values you've
seen so far. And critical to an arbitrary limit you want to be sure you
never hit.

> -Snipp-
> >>     ignore  fan4
> > 
> > No 4th fan header, or just unused on your system? You should only
> > ignore a fan when the header isn't there.
> > 
> I checked the manual: there is a "System 3" Fan, but it does not seem to
> have a Sensor connector (the pin is labeled "No Use" in the manual and
> the BIOS does not report it).
> 
> -Snipp-
> >>     compute in1   (@ * 1.35), (@ / 1.35)
> > 
> > This would be quite surprising. On recent CPUs, Vcore is always lower
> > than the ADC's resolution, so it shouldn't need any scaling. How did
> > you come with this value?
> > 
> 
> I ran several comparisons between readouts from the BIOS and running
> sensors with a dummy configuration. Then I tweaked the compute values to
> match as well as possible the BIOS values. I read in the BIOS (some
> values were quite noisy):

Noisy values are very useful for that kind of exercise. If the BIOS
reports enough different values for a given voltage line, you can guess
the scaling factor without even comparing with the values reported by
"sensors". And it is more reliable than comparing voltages of the same
machine under different workloads...

> CPU Vcore           1.224V
> 3.3V                3.376V
> 5V                  4.961V
> 12V                12.144V
> 
> Vcore was very stable, so I tuned compute1 to match it. For compute5, I
> did the same (even though the values varied slightly). I cannot
> remember, whether I did the same to compute4 or stayed with the default.

The problem is that you compared the Vcore in BIOS, without CPU
frequency scaling, with Vcore in sensors, with CPU frequency scaling
enabled (as can be seen from the two outputs below.) This isn't fair!

If you compare with Linux underload instead, you see Vcore (unscaled)
at 1.12 V. This is definitely not 35% off compared to the BIOS's report
of 1.224 V. To be honest, I would have expected both values to match
exactly. I get to suspect that your Linux system is configured to
prevent the CPU to enter the highest frequency states, you may want to
check this.

Anyway, again, 1.224 V is way below the ACD's range (2.04 V), so
there is no reason why the board vendor would spend 2 resistors to
scale down the voltage value. Thus I still don't think in1 needs a
compute line (and the fact that 1.224 is a multiple of 0.008, the ADC's
resolution, suggests I'm right). The difference in values has to have a
different explanation.

> -Snipp-
> > When sending such configuration files, it is a good practice to also
> > include the output of "sensors -c /dev/null", so that we can review
> > your choices and possibly help you improve your configuration file.
> > 
> 
> Sure (the long "sensor = ..." lines get folded by my MUA):
> 
> unloaded machine:
> f71882fg-isa-0a00
> Adapter: ISA adapter
> in0:         +1.70 V
> in1:         +0.92 V  (max =  +2.04 V)
> in2:         +0.02 V
> in3:         +0.00 V
> in4:         +0.94 V
> in5:         +1.11 V
> in6:         +0.21 V
> in7:         +1.68 V
> in8:         +1.63 V
> fan1:       2407 RPM
> fan2:          0 RPM  ALARM
> fan3:       1758 RPM
> fan4:          0 RPM  ALARM
> temp1:       +22.0°C  (high = +255.0°C, hyst = +251.0°C)
>                       (crit = +255.0°C, hyst = +251.0°C)  sensor = Intel PECI
> temp2:       +59.0°C  (high = +255.0°C, hyst = +251.0°C)
>                       (crit = +255.0°C, hyst = +251.0°C)  sensor = transistor
> temp3:       +44.0°C  (high = +255.0°C, hyst = +253.0°C)
>                       (crit = +255.0°C, hyst = +253.0°C)  sensor = transistor
> 
> machine loaded by 8 instances of burnK7:
> f71882fg-isa-0a00
> Adapter: ISA adapter
> in0:         +1.68 V
> in1:         +1.12 V  (max =  +2.04 V)
> in2:         +0.48 V
> in3:         +0.29 V
> in4:         +0.94 V
> in5:         +1.10 V
> in6:         +0.52 V
> in7:         +1.68 V
> in8:         +1.63 V
> fan1:       2407 RPM
> fan2:          0 RPM  ALARM
> fan3:       1706 RPM
> fan4:          0 RPM  ALARM
> temp1:       +78.0°C  (high = +255.0°C, hyst = +251.0°C)
>                       (crit = +255.0°C, hyst = +251.0°C)  sensor = Intel PECI
> temp2:       +65.0°C  (high = +255.0°C, hyst = +251.0°C)
>                       (crit = +255.0°C, hyst = +251.0°C)  sensor = transistor
> temp3:       +43.0°C  (high = +255.0°C, hyst = +253.0°C)
>                       (crit = +255.0°C, hyst = +253.0°C)  sensor = transistor
> 

Your CPU cooling seems insufficient. A 56°C difference between idle and
load is very, very much. I'd be worried.

> Any further suggestions on how to tweak the warning levels for all the
> settings?

I would suggest the following, but again this is quite subjective, feel
free to adjust. I don't know what you're using the machine for...

   set in1_max         1.3

   set temp1_max        85
   set temp1_max_hyst   82
   set temp1_crit      100
   set temp1_crit_hyst  97
   set temp2_max        75
   set temp2_max_hyst   72
   set temp2_crit       85
   set temp2_crit_hyst  82
   set temp3_max        55
   set temp3_max_hyst   52
   set temp3_crit       65
   set temp3_crit_hyst  62

When you have come up with a "final" configuration file, please send it
over, and I'll put it on the wiki.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
