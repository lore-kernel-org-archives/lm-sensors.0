From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: adm9240 chip on a intel se440bx-2
Message-Id: <20040707203332.6604bf8a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4620c$f27351f0$3635430a@glauke>
In-Reply-To: <000001c4620c$f27351f0$3635430a@glauke>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Original message from: Bert.gevers@belgacom.net
> > To sensors@stimpy.netroedge.com
> 
> > I got the adm9240 to work with a 2.6.7 kernel (custom build debian),
> > but there are still errors and I thought that maybe you could use
> > some feedback on this.
> 
> > Kconfig, Makefile and adm9240.c are from
> > /usr/src/linux/drivers/i2c/chips/.


Aha. We *never* got the part below on the list. Your message was
truncated here. No attachement either. Something must have gone wrong at
the moment you sent your mail. This is why I was surprised about what
your mail was for.

You should not use Outlook, see how bad it is ;)

> > Adm9240.c came from solar.xs4all.nl/sensors/ (as most of the things
> > came from there).
> > Chips.c is the change in the lm-sensors2.8.7 driver from your site. 
> > It  was based on solar.xs4all.nl but contained some errors (in my
> > humble opinion).
> 
> > After installation, I get the following info:
> > Sensors -v:  Sensorsversion
> > Sensors adm9240-i2c-1-2d: sensorsoutputknown
> 
> > Sensors -u adm9240-i2c-1-2d: Sensorsoutput

Care to resend all the files?

Please let us know what you fixed from Michiel's files.

> > Things that are still wrong:
> > * 2.5V is on the intel se440bx-2 only 1.5V.

According to the doc, it really does monitor +1.5V:
  "*  Voltage sense (+12 V, -12 V, +5 V, -5 V, +3.3 V, +1.5 V, and VCCP)
  to detect out of range values"
so it's OK. Just edit the label.

> > * (I dunnot understand the difference between Vccp1 and 2 but that
> > seems all right)

Vccp2 is meant for dual-CPU system (or maybe dual-plane CPUs, but it
only existed for a short time). It may be used for something different
on your board (it even must be, since there's no VCCP2 in Intel's list).

> > * fans are correct (fan 1 is in fact not the cpu, but the case fan
> > which isn't present)

Again, simply edit the label.

> > temperature is correct except for the hysteresis temp which is a
> > factor 100 too big

I saw several magnitude problems in Michiel's files. Don't know what you
fixed or not.

> > analog out isn't configured (and I dunnot understand what the
> > meaning of this can be)

I don't know either, I guess we can ignore that.

-- 
Jean Delvare
http://khali.linux-fr.org/
