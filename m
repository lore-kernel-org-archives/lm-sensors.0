From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 03 Mar 2011 15:22:16 +0000
Subject: Re: [lm-sensors] [Nouveau]  hwmon API update
Message-Id: <20110303152216.GA21667@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr> <20110213171640.GB13323@ericsson.com>
	<20110213230833.0ee2ff16@endymion.delvare>
	<AANLkTindG=m4FhNS202MH8YVBUCoDEADTQLxo-Bf_8qx@mail.gmail.com>
In-Reply-To: <AANLkTindG=m4FhNS202MH8YVBUCoDEADTQLxo-Bf_8qx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: nouveau <Nouveau@lists.freedesktop.org>, Martin Peres <martin.peres@free.fr>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Mar 03, 2011 at 04:36:09AM -0500, Dave Airlie wrote:
> On Mon, Feb 14, 2011 at 8:08 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Sun, 13 Feb 2011 09:16:40 -0800, Guenter Roeck wrote:
> >> On Sun, Feb 13, 2011 at 07:18:44AM -0500, Martin Peres wrote:
> >> > Hi,
> >> >
> >> > I am working on power management on the nouveau driver and I need a way
> >> > to get data out of and send commands to the i2c drivers from the kernel
> >> > space.
> 
> Martin,
> 
> you probably should have cc'ed Matthew since it was his patch you based this on,
> and I think he can provide a good explaination.
> 
> to clarify some points,
> 
> radeon does probably want something exactly like this, we just haven't gotten to
> it completely yet, I'd rather not have two drivers in the kernel for
> exact same hardware,
> and I believe sharing the hwmon code to do what we want is a good plan since you
> don't go around reinventing wheels, but if hwmon/i2c maintainers have
> no interest
> it leaves with little choice but to implement about 5-10 i2c drivers
> again in drm codebase.
> 
> Maybe hwmon/i2c maintainers could suggest a cleaner way to implement
> what we want,
> which I think I can summarize as
> 
> a) access to monitored values in-kernel
> b) no userspace access to the same values except via sanitised via the driver.
>
This is not a matter of "no interest". Interest is there, but if one demands
too much one may get nothing.

Request for b) so far was "no userspace access", period. This is unacceptable
since providing userspace access to monitored values is the whole point of hwmon.

I could imagine an API that covers both a) and b), as long as b) focuses
on the "sanitize" aspect and doesn't try to limit userspace access to attributes.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
