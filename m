From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 22 May 2007 15:38:29 +0000
Subject: Re: [lm-sensors] Any chances to get THMC50 driver into 2.6.22?
Message-Id: <20070522173829.52a79411@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4649ac914ece8@wp.pl>
In-Reply-To: <4649ac914ece8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Tue, 22 May 2007 21:25:12 +0200, Krzysztof Helt wrote:
> > Well, user support to start with, both on this mailing list and
> > http://www.lm-sensors.org/report . Some tickets are pretty simple, for
> > example everyone should be able to solve #2208. And review or testing
> > of any patch posted to the list, that's always welcome.
> 
> I may try fixing them when I do not have any other task at hand (read:
> I wait for patches accepted in other areas: sparc/fbdev).

For example, Rudolf Marek just posted a patch adding support for the
IT8726F:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019767.html
It should be fairly easy to review. Of course I'll end up doing it if
nobody picks it shortly, but it's probably a good one to get started.

> I have these three machines:
> 
> A. Compaq AP550: i82801AA + dual ADM1022 (thmc50 driver) = 5 temperatures
> and 2 fans. There is also some LPC chip but it is not used I suppose (no
> other fans).
> 
> B. laptop: sis630 + max1617 (adm1021? driver) + unknown ITE chip (id: ea19).
> I got 2 temperatures (CPU & MB) but no fan control. I suppose this ITE chip
> controls the fan (do you know where I can find manual for it?).

Are you sure it is an ITE chip? ID 0xea doesn't sound like an ITE chip
at all, more like National Semiconductor. The earlier versions of
sensors-detect might have been confusing in that respect, please check
again with a recent version.

The adm1021 driver is still using macro-generated functions instead of
dynamic callbacks, and doesn't implement individual alarm files. So
these are two things you could work on if you feel like it.

> C. White box P3: piix4 + as99127f rev 2. This one is my wife's so the access
> is more limited.

Same thing for the w83781d driver, dynamic callbacks and individual
alarm files are missing.

> > Oh, and if you have experience with writing drivers for serial (RS232)
> > devices, please let me know, I am trying to write such a driver for an
> > evaluation module but am going nowhere.
> 
> I do not know how deep knowledge you need.

Basically my problem is that I can't get the driver to bind to my
device. I am able to "talk" to the device using minicom so I know the
serial port and the device work OK. But I don't know how to write a
kernel driver which will bind to the serial port and let me read and
write "raw" characters from and to it. I tried copying random examples
from other serial drivers but my .connect() method never gets called.
LDD3 unfortunately doesn't cover legacy serial drivers.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
