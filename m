From: Trent Piepho <tpiepho@freescale.com>
Date: Thu, 20 Nov 2008 22:00:21 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <Pine.LNX.4.64.0811201354310.11673@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
 <200809231532.40083.david-b@pacbell.net> <20081118091546.421d6b78@hyperion.delvare>
 <200811181401.34809.david-b@pacbell.net> <Pine.LNX.4.64.0811190140510.11673@t2.domain.actdsltmp>
 <20081119161632.2d0bde9e@hyperion.delvare>
In-Reply-To: <20081119161632.2d0bde9e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Wed, 19 Nov 2008, Jean Delvare wrote:
> On Wed, 19 Nov 2008 01:51:08 -0800 (PST), Trent Piepho wrote:
>> On Tue, 18 Nov 2008, David Brownell wrote:
>>> ---
>>> drivers/i2c/busses/i2c-gpio.c |   10 ++
>>> drivers/i2c/i2c-core.c        |  155 ++++++++++++++++++++++++++++++++++++++++
>>> include/linux/i2c.h           |   14 +++
>>> 3 files changed, 179 insertions(+)
>>
>> Can this be made optional?  Seeing as nothing uses it yet and it increases a
>> brunch of core structs' sizes.
>
> Did you actually check the size increase? struct i2c_driver is added
> one pointer, so 4 or 8 bytes, hardly worth mentioning. struct
> i2c_adapter is added 72 bytes on x86-64, to 1360 bytes initially so an
> increase of less than 6%. Is this really such a big issue? I doubt it.
> You don't have that many i2c_adapters registered on any given system
> for it to really matter, methinks.

Except every other subsystem in the kernel does the same thing.  Each release
of 2.6 is significantly more bloated than the last and this is how it happens. 
One "it's not that much wasted" change at a time.

> Making it optional would have its problems as well. Either the drivers
> which implement or make use of SMBus alert would have to depend on said
> option being enabled, or you'd have to put #ifdefs in all these drivers

What's so hard about having them depend on smbus alert support?  They already
depend on I2C and so on.  If any drivers ever get code for this, how hard is
it to add one dependency or select to their Kconfig section?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
