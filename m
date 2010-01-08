From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 Jan 2010 08:28:08 +0000
Subject: Re: [lm-sensors] sensors show hdd temp instead of cpu temp using
Message-Id: <20100108092808.5efb6191@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <b4184b2f1001041651x593dec41tf7e6a0dc71acecf8@mail.gmail.com>
In-Reply-To: <b4184b2f1001041651x593dec41tf7e6a0dc71acecf8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, 7 Jan 2010 16:24:48 -0500, vajorie wrote:
> Cpuburn really helped, thank you :)
> 
> > Make and run the `./burnP6 &` twice to occpuy whole CPU. Check whether the coretemp temperature increase.
> 
> Indeed, it seems that the temperature is reported low but not as hdd's
> temp. I started when hhtemp's report was same as sensors, after some
> cpuburn:
> 
> $ sensors && sudo hddtemp /dev/sda
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +52.0°C  (crit = +90.0°C)
> 
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +52.0°C  (crit = +90.0°C)
> 
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +26.8°C  (crit = +100.0°C)
> 
> /dev/sda: WDC WD1600BEVT-22ZCT0: 40°C
> 
> At 52C, the fans sounded a bit panicky :)
> 
> > What makes you believe that hwmonitor is right and Linux is wrong rather than the other way around?
> 
> I thought rather that Windows software was closer to an accurate
> reading. Running both speedfan & hwmonitor side by side (screenshot
> http://bugzilla.kernel.org/attachment.cgi?id$478 ) demonstrates that
> no one really knows what the temperature of this cpu is :-) The
> particular reason why I believe Windows softwares' report in this case
> is because I find the reported cpu temperatures on linux simply too
> low.

Yeah, since the Athlon XP and its incredibly high operating
temperature, users seem to think that 60 or even 70°C is a reasonable
CPU temperature. Thankfully CPU vendors have learned from their past
mistakes and newer CPUs, in particular the Atom, run much colder. If
you don't believe me, just compare the thermal design power of my
Athlon XP 2400+ (62W) and your Atom N280 (2.5W).

A temperature of 52.0°C when the CPU is operating at full speed, as
shown above, seems perfectly reasonable to me.

> If the critical temperature of my cpu is 90C, why would the bios
> (?) turn the fans on at 36C or so? And speeds them up at around 45C or
> so? (And one more speedup at 54C I think, but I am not sure about that
> at all)

You'd need to ask Acer about it. One possibility is that, given the
small form factor and the lack of other thermal sensor (ACPI thermal
zone doesn't seem to work), they consider the CPU temperature as an
indicator of the overall system temperature. Also, for a laptop, the
user might be in close contact with it, and they may not want the user
to get burnt.

Anyway, the only thing where the Linux coretemp driver can be wrong
(and indeed has been for some CPU models in the past) is the high
temperature limit, which itself is used to compute the current
temperature. So, while the current temperature could be wrong, the
difference between the current temperature and the high limit can't.
So, Acer really wants the fan to kick in when the thermal margin is
less than 90 - 36 = 54 degrees C.

My theory is that Speedfan, HWmonitor and the Linux coretemp driver
simply disagree on the high temperature limit for the Atom N280.
Unfortunately neither Speedfan nor HWmonitor display that value, so we
don't know what they use.

> As you said in your email, though, this is pure speculation on my part
> (especially after seeing speedfan and hwmonitor disagree too, though
> the range of temperature they disagreed sounded more logical to me).

At this point I have no reason to believe that the coretemp driver
isn't reporting the temperature correctly for your system.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
