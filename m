From: Paul Norman <penorman@mac.com>
Date: Sat, 19 Nov 2011 10:18:49 +0000
Subject: Re: [lm-sensors] Biostar TA880GB+ Motherboard Information
Message-Id: <000201cca6a4$a2524610$e6f6d230$@mac.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001cca684$f7e5ace0$e7b106a0$@mac.com>
In-Reply-To: <000001cca684$f7e5ace0$e7b106a0$@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> From: Jean Delvare [mailto:khali@linux-fr.org]
> To: Paul Norman
> Subject: Re: [lm-sensors] Biostar TA880GB+ Motherboard Information

> > chip "acpitz-virtual-0"
> > # This is essentially the same as the CPU temperature.
> 
> This could be problematic. If ACPI reads from the same registers as the
> IT8712F chip, as these accesses are not synchronized, they could
> collide. This is a problem affecting many boards unfortunately, with no
> good solution so far.

Would disabling it be a good idea then?

Also, do you have any suggestions for the k10temp-pci-00c3 temp1 label?

> Go to the BIOS and watch the +5V and +12V values. Write down every
> different sample you manage to get. The more samples, the better. Then
> check the raw values (from sensors -u) for in0 and in1. Write down all
> samples as well if there are many. From that we can find out who is who
> and the scaling factors.

According to the BIOS +12V is at 12.250 with no variation and +5V is at
5.115. I waited for about 2 minutes.

Both in0_input and in1_input vary between 2.940 and 2.952. They vary
independently, and I only observed in0_input=2.940 under heavy CPU load.

I only observed in1_input=2.940 under heavy IO load.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
