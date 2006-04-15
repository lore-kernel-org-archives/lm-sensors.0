From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 15 Apr 2006 12:17:47 +0000
Subject: [lm-sensors] many wrong values from w83627hf since kernel 2.6.14
Message-Id: <20060415141747.ba5ea896.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060413004532.GA4802@spiegl.de>
In-Reply-To: <20060413004532.GA4802@spiegl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andy,

> I just tried, it didn't.  But when looking for sensors output during
> kernel 2.6.13.4 I noticed something: the values then weren't correct
> either, oops!  But I never noticed it because it didn't say "ALARM".
> Sorry, I feel pretty stupid now for not checking carefully.
> 
> So I should reword my question:
>  "wrong values from w83627hf with whatever kernel"

OK, so we are probably down to a configuration file tweaking issue,
rather than a driver breakage.

> Here is the output from a week ago when running kernel 2.6.13.4:
> 
> Chip: w83627thf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
>   VCore: +1.56 V (min = +1.36 V, max = +0.76 V)
>   +12V: +11.92 V (min = +10.82 V, max = +13.19 V)
>   +3.3V: +3.28 V (min = +3.14 V, max = +3.47 V)
>   +5V: +4.99 V (min = +4.75 V, max = +5.25 V)
>   -12V: -14.91 V (min = -13.18 V, max = -10.80 V)
>   V5SB: +5.08 V (min = +4.76 V, max = +5.24 V)
>   VBat: +2.10 V (min = +2.40 V, max = +3.60 V)
>   fan1: 0 RPM (min = 14062 RPM, div = 32)
>   CPU Fan: 0 RPM (min = 168750 RPM, div = 2)
>   fan3: 1885 RPM (min = 25961 RPM, div = 4)
>   M/B Temp: 36 C (limit = -96 C, hysteresis = 0 C, sensors = thermistor)
>   CPU Temp: 45.5 C (limit = 80 C, hysteresis = 75 C, sensor = thermistor)
>   temp3: -48.0 C (limit = 80 C, hysteresis = 75 C, sensor = thermistor)
>   vid: +0.725 V
>   alarms: Chassis intrusion detection
>   beep_enable: Sound alarm enabled
> 
> So basically, what changed since then:
> 
> > > VCore:     +1.60 V  (min =  +0.69 V, max =  +0.77 V)       ALARM
>
> now, at least "min" is smaller than "max", but still strange values!

The value didn't change that much. The low limit did, I can't tell why.
The problem here is that your VID reading (nominal CPU voltage) is not
correct, and the Vcore limits are set based on that value... This seems
to be caused by a bug in our hwmon-vid driver, Rudolf Marek is working
on it.

Until the bug is fixed, a solution is to hardcode the vid value in the
configuration file. Replace:

    set in0_min vid * 0.95
    set in0_max vid * 1.05

With:

    set in0_min 1.525 * 0.95
    set in0_max 1.525 * 1.05

> > > -12V:      +2.94 V  (min = -13.18 V, max = -10.80 V)       ALARM
>
> before it was: -14.91

in4 reading was broken before 2.6.15, this explains the change. The new
value doesn't make more sense though, so it's pretty clear to me that
this input is not wired to -12V. Either this line is used to monitor
something different, or it's not used at all. Given that the BIOS
doesn't display it, it's probably not used.

> Just in case I'll attach my sensors.conf.

Urgh, next time please only include the relevant section!

I just found a sample configuration file for this motherboard posted by
Mark M. Hoffman to the list some times ago:

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-February/010490.html

Except for vrm (no need to set it) and vid (can't trust the bogus
value) it should work fine for you.

-- 
Jean Delvare

