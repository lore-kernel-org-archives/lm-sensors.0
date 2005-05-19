From: Bert.Gevers@belgacom.net (Bert Gevers)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: adm9240 chip on a intel se440bx-2
Message-Id: <000001c46445$52cb4230$3635430a@glauke>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4620c$f27351f0$3635430a@glauke>
In-Reply-To: <000001c4620c$f27351f0$3635430a@glauke>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I know it wasn't officially in, but I didn't find any feedback email and
thought that it could be handy for you guys.
Like I said, I got Adm9240.c from solar.xs4all.nl/sensors/.

Now that I look more closely there was an email there:
michiel@grendelproject.nl, but I suppose that that is Michiel Rook.


> Original message from: Bert.gevers@belgacom.net
> To sensors@stimpy.netroedge.com

> I got the adm9240 to work with a 2.6.7 kernel (custom build debian), but
> there are still errors and I thought that maybe you could use some
> feedback on this.

> Kconfig, Makefile and adm9240.c are from /usr/src/linux/drivers/i2c/chips/
> .

> Adm9240.c came from solar.xs4all.nl/sensors/ (as most of the things came
> from there).
> Chips.c is the change in the lm-sensors2.8.7 driver from your site.  It
>  was based on solar.xs4all.nl but contained some errors (in my humble
> opinion).

> After installation, I get the following info:
> Sensors -v:  Sensorsversion
> Sensors adm9240-i2c-1-2d: sensorsoutputknown

> Sensors -u adm9240-i2c-1-2d: Sensorsoutput

> Things that are still wrong:
> * 2.5V is on the intel se440bx-2 only 1.5V.
> * (I dunnot understand the difference between Vccp1 and 2 but that seems
> all right)
> * fans are correct (fan 1 is in fact not the cpu, but the case fan which
> isn't present)
> temperature is correct except for the hysteresis temp which is a factor
100 too big
> analog out isn't configured (and I dunnot understand what the meaning of
this can be)

> That is about it.  I hope I helped u guys a little bit with this





