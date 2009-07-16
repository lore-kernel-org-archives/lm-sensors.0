From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 16 Jul 2009 11:47:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add WM835x PMIC hardware monitoring
Message-Id: <20090716114711.GA26350@rakim.wolfsonmicro.main>
List-Id: <lm-sensors.vger.kernel.org>
References: <1247671762-19506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1247671762-19506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 16, 2009 at 11:18:02AM +0000, Jonathan Cameron wrote:
> > --- /dev/null
> > +++ b/drivers/hwmon/wm8350-hwmon.c
> > @@ -0,0 +1,154 @@
> ...
> > +#include <linux/delay.h>
> > +#include <linux/platform_device.h>

> Why input-polldev? or for that matter delay.h, mutex.h, dmi.h
> Can't immediately see any use of things from them, but I
> haven't build tested without to check.

TBH I templated the headers off another driver and never rechecked them
- obviously I've got far too much stuff in there.

> > +	val = wm8350_read_auxadc(wm8350, channel, 0, 0)
> > +		* WM8350_AUX_COEFF / 1000;

> I'd normally be a bit dubious about the lack of error handling here,
> but having taken a look in at the wm8350-core it doesn't look like any
> errors that occur can get through anyway (now whether they would
> ideally be passed up to here is a different question!)

Yeah, and if it were being changed it'd probably be easier to merge the
driver and then do cross-subsystem patches fixing up the readback
function and its users in one fell swoop.  Realistically if the AUXADC
starts failing inaccurate supply voltage readings are probably the least
of your worries, though.

> The rest looks fine to me.  Get rid of (or justify) the headers
> and you have my ack.

I'll prune the headers next time I submit.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
