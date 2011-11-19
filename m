From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Nov 2011 11:46:26 +0000
Subject: Re: [lm-sensors] Biostar TA880GB+ Motherboard Information
Message-Id: <20111119124626.34e2927d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001cca684$f7e5ace0$e7b106a0$@mac.com>
In-Reply-To: <000001cca684$f7e5ace0$e7b106a0$@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 19 Nov 2011 02:18:49 -0800, Paul Norman wrote:
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > To: Paul Norman
> > Subject: Re: [lm-sensors] Biostar TA880GB+ Motherboard Information
> 
> > > chip "acpitz-virtual-0"
> > > # This is essentially the same as the CPU temperature.
> > 
> > This could be problematic. If ACPI reads from the same registers as the
> > IT8712F chip, as these accesses are not synchronized, they could
> > collide. This is a problem affecting many boards unfortunately, with no
> > good solution so far.
> 
> Would disabling it be a good idea then?

If the thermal zone is only used by your system for reporting, yes. If
it is also used by the BIOS to achieve thermal protection, then you'd
lose this feature by disabling the thermal zone. That being said, using
both it87 and the ACPI thermal zone is worse than any alternative, so
if you really want to monitor your system, disabling the ACPI thermal
zone is the way to go. That's what I would do personally.

> Also, do you have any suggestions for the k10temp-pci-00c3 temp1 label?

It is definitely related to the CPU temperature, even though the
numbers are not physical. If you are happy with the CPU temperature
reported by the it87 driver, you could blacklist the k10temp driver.

> > Go to the BIOS and watch the +5V and +12V values. Write down every
> > different sample you manage to get. The more samples, the better. Then
> > check the raw values (from sensors -u) for in0 and in1. Write down all
> > samples as well if there are many. From that we can find out who is who
> > and the scaling factors.
> 
> According to the BIOS +12V is at 12.250 with no variation and +5V is at
> 5.115. I waited for about 2 minutes.

Note that some BIOS do not refresh the monitored value in real-time. In
that case you have to leave and re-enter the monitoring panel to get a
chance to see different values.

> Both in0_input and in1_input vary between 2.940 and 2.952. They vary
> independently, and I only observed in0_input=2.940 under heavy CPU load.
> 
> I only observed in1_input=2.940 under heavy IO load.

Hu. If both have exactly the same raw value, it's obviously difficult
to distinguish between them. And the only other Biostar configuration
file we have has a completely different mapping, so it won't help.

Your only chance would be to temporarily change your hardware setup to
slightly alter the load. For example adding or removing a hard disk
drive, or using a different PSU.

I am a little surprised by the raw values BTW... 2.952 V is really
close to the ADC max of 3.060 V.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
