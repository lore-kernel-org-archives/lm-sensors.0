From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <20040910130400.M46942@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 10 Sep 2004 08:44:35 -0400, Leif W wrote
> Ticket # 1770
> 
> Hi,
> 
> I couldn't find a way to reply via the support ticket page.  The problem
> was not solved on my end.

This is a weakness of our home-brew ticket system. We certainly should switch
to a more modern system such as Bugzilla.

> "sensors-detect" did in fact discover the W83781D device when probing
> the ISA bus, at 0x290 as you mentioned.  I missed it before, but noticed
> it when I did not load the ali15x3 adapter driver, and scanned the 
> ISA bus.

OK, interesting information. This raises some hope that you should be able to
get it to work over the ISA bus in the end.

> In "sensors.conf" I have tried 'chip "w83781d-*"' and 'chip
> "w83781d-isa-*"', but running "sensors" says "No sensors found!".

It shouldn't make any difference, both should work equally well (for the ISA
mode). However, note that the existence of these sections in the configuration
file is completely unrelated to the fact that "sensors" will find it or not.

> Loaded modules are: w83781d, i2c_sensor, i2c_isa, i2c_core.

Sounds OK.

> I also tried with i2c_dev loaded, same result.

No surprise. i2c-dev is meant for raw access to the busses from user space.
i2cdetect and i2cdump use it, but "sensors" doesn't (reads from procfs/sysfs
instead).

> Am I missing a module or module option?

No, it should work the way you did.

> Is it possible that the chip is detected on the ISA bus but 
> not accessible (misconfigured?) or not wired (unlikely?).

It is wired and configured properly, or sensors-detect wouldn't see it.

> Do I need to reboot when switching between SMBus and ISA?

No. This is Linux. You usually don't reboot unless upgrading kernels.

> If I wanted to use  ISA but still see the EEPROMs, would I still hang the
> bus?  Would I load both the ali15x3 and isa adapter drivers? How would I
> configure sensors.conf? With separate "w83781d-i2c-*" and "w83781d-isa-*" 
> sections, with ALL "w83781d-i2c-*" values ignored with optionally 
> commented label, compute and set?

This is a second problem we will work on later. For now, the problem is to
understand why you plain can't get the ISA W83781D to work.

I suspect some resource conflict. The w83781d driver will attempt to reserve
the ISA I/0 range 0x290-0x297. I suspect that it failed to do so. Please make
sure that your kernel was compiled with i2c debugging enabled. Then try
loading i2c-isa and w83781d, in this order, and watch the logs
(/var/log/syslog, /var/log/debug and dmesg) for hints. I'd expect to see the
w83781d driver complain it failed to reserve the I/O range. You may look in
/proc/ioports to see who/what reserved it. I wouldn't be surprised if ACPI or
PNP drivers were involved. You may try to enable/disable ACPI and/or PNP while
configuring your kernel and see if it helps.

> sensors.conf contains only this text (excluding the END comment 
> below):

No END comment as far as I can see...

-- 
Jean Delvare
http://khali.linux-fr.org/
