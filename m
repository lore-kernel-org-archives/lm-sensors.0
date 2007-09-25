From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 25 Sep 2007 16:00:06 +0000
Subject: Re: [lm-sensors] [PATCH 8/9] ACPI: thinkpad-acpi: use a separate
Message-Id: <20070925180006.74e06c4e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1190557457539-git-send-email-hmh@hmh.eng.br>
	<11905574583315-git-send-email-hmh@hmh.eng.br>
	<20070924171128.19f91009@hyperion.delvare>
	<20070925023958.GA15111@khazad-dum.debian.net>
In-Reply-To: <20070925023958.GA15111@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, LM Sensors ML <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org

On Mon, 24 Sep 2007 23:39:58 -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 24 Sep 2007, Jean Delvare wrote:
> > The name attribute should really read "thinkpad" not "thinkpad_hwmon",
> > otherwise "sensors" will present the chip as "thinkpad_hwmon-isa-0000",
> > its section in /etc/sensors.conf will be named chip "thinkpad_hwmon-*",
> > etc. That's pretty redundant and unaesthetic.
> 
> -isa- in platform drivers where there is not even a ISA bus in sight is also
> very unaesthetic.

It's about I/O addressing space, not bus. OK, technically speaking,
recent systems' I/O space follows the LPC standard, not ISA, but for the
user it's essentially the same.

Most applications will only present the prefix of the hardware
monitoring name (i.e. the contents of the name sysfs attribute), so the
rest of the naming syntax isn't that important.

> That said, I will change it to "thinkpad", but I still would rather have
> thinkpad-platform from a cosmetic point of view, than thinkpad-isa-0001.

Great, thanks. thinkpad-platform wouldn't be a valid name for
libsensors, names have to be in the form $prefix-$bus-$address. And
again, there's no easy way for libsensors to tell between an ISA or LPC
device (which have been around for years and named *-isa-*) and a true
platform device, otherwise I would of course do it.

> > I'm still not convinced that we want a separate device for this. If you
> 
> It is there for ease of breaking thinkpad-acpi into many modules.  It makes
> life easier for me, and also it makes it pretty damn clear to userspace
> app writers that they better use the proper ABI (libsensors4) or else.

I don't understand what you mean here, sorry.

> (...)
> > > Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> > > Cc: LM Sensors ML <lm-sensors@lm-sensors.org>
> > 
> > It's pretty pointless to have a mailing list listed here, as the list
> > itself can't ack nor nack your patch.
> 
> People in the list certainly can :-)  But if you'd rather I cc you directly,
> I will change it.

Actually you'd rather Cc the hwmon subsystem maintainer, if anyone, and
that's not me. But I was really only commenting on the Cc: in the
header of the patch, not the Cc: when sending the patch. Cc'ing the
lm-sensors list when sending your patch was of course correct. Just
writing it down in the patch header doesn't make sense.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
