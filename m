From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 06 Feb 2006 09:10:06 +0000
Subject: [lm-sensors] reading CPU temp from kernel module
Message-Id: <oq0vLp4y.1139217006.3795890.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <6030766.1138809619345.JavaMail.ngmail@webmail-05.arcor-online.net>
In-Reply-To: <6030766.1138809619345.JavaMail.ngmail@webmail-05.arcor-online.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo Andreas,

> I'm sorry because of the advertisement, but it is added by my email
> provider.

I would urge you to change providers then. I guess you get the mail
service for "free" in echange of an advertisement being inserted in
each e-mail you send? Nothing is really free, you know, and someone has
to pay. In this case, the ones who pay are the recipients of your post -
150 people or so reading this list. Sure, we don't pay with money; but
we pay with bandwidth, storage space and time, and these have a value
too.

So, put in short, not only you are asking us for technical help (which is
OK, that's was the list was created for) but you ask us to pay in order
to help you. How acceptable is this? Not much, I fear.

> I want to measure the influence of temperature on the performance of the
> CPU. Due to this I have an external hardware which generates a very
> precise signal every second. This signal causes an interrupt and in the
> interrupt service routine (= kernel-mode / kernel module) I want to
> printk the timestamp counter and the temperature of the CPU. First I
> wanted to use a user-mode application, but this way I get a too big and
> variing latencies. Unfortenately I don't know how to read from the bus
> which can deliver the temperature information.

This is an interesting experiment, but I am not sure your experimental
setup is right. What exactly are you measuring? The time the kernel will
take to handle the interrupt, as I understand it. The variations of it
will probably be neglectable compared to the time spent by printk (and
the consequent logging, either on screen or on disk) and the noise from
the rest of the system.

What CPU are you working with, BTW? As far as I know, almost all CPUs
work at a fixed clock rate anyway, so how could the speed depend on the
temperature?

> How can I give ACPI a try? Is there a code example?

No idea, sorry. You better ask this question on the linux-acpi list (see
MAINTAINERS). Make sure that your test system supports ACPI temperature
reporting first (enable ACPI thermal and look in
/proc/acpi/thermal_zone).

Note that if your experiment is meant to be only run on one specific
system, and ACPI thermal doesn't work, and lm_sensors does, then you
may just hack the relevant hardware monitoring driver to do just what
you need: export a function which probes for just one temperature and
prints it. It might be preferable over ACPI anyway, because ACPI thermal
seems to report the measured temperature with limited resolution (1
degree C) and may also cache the measured value for some times, like the
hardware monitoring drivers do by default.

--
Jean Delvare

