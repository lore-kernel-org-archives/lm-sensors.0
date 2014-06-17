From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 17 Jun 2014 16:21:14 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Driver for TI TMP103 temperature sensor
Message-Id: <20140617162114.GA23451@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402992713-22711-1-git-send-email-hs@denx.de>
 <20140617161105.GF8930@leverpostej>
In-Reply-To: <20140617161105.GF8930@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland@arm.com>
Cc: Heiko Schocher <hs@denx.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Tue, Jun 17, 2014 at 05:11:05PM +0100, Mark Rutland wrote:
> On Tue, Jun 17, 2014 at 09:11:53AM +0100, Heiko Schocher wrote:
> > Driver for the TI TMP103.
> > 
> > The TI TMP103 is similar to the TMP102.  It differs from the TMP102
> > by having only 8 bit registers.
> > 
> > Signed-off-by: Heiko Schocher <hs@denx.de>
> > 
[ ... ]
> > +
> > +static const struct i2c_device_id tmp103_id[] = {
> > +	{ DRIVER_NAME, 0 },
> 
> This seems to be used for compatible string matching. As such, I think
> it would make more sense to have the string in full here so as to
> discourage it from being changed arbitrarily in future.
> 
Makes sense. Heiko, can you change that as well in v5 ?
It also simplifies adding another chip to the driver, should that
ever happen.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
