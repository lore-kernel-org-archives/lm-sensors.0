From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 11 Dec 2014 10:26:07 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/3] hwmon: ina2xx: make shunt resistance configurable at run-time
Message-Id: <CAMpxmJXVPbp+XJQ9oVpAB3ejRx7Czb0KTC0HtfL9zed4Z_rOQA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418207937-11648-1-git-send-email-bgolaszewski@baylibre.com>
	<1418207937-11648-2-git-send-email-bgolaszewski@baylibre.com>
	<548856AF.8090805@roeck-us.net>
	<CAMpxmJXp2NT+rie2d2+Z7hixKMyS+xcRNdKRNZaUSJD-aTUVVg@mail.gmail.com>
	<20141210183146.GA22847@roeck-us.net>
In-Reply-To: <20141210183146.GA22847@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

2014-12-10 19:31 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> I don't really want it at all ;-). Seems to me all those options are broken
> one way or another. The only real solution would be to re-instantiate the
> driver if the chip was removed and re-inserted, and to provide parameters
> either with platform data or with devicetree data.

I see your point, but as Benoit mentioned in one of the previous
messages, in case of our platform it would be impossible to have an
exhaustive list of possible shunt values.

> On a side note, data->rshunt is not really needed anymore with your current
> code. The only reason for storing it in data is to use it in
> ina2xx_calibration_val(), but you could as well pass it in as parameter
> to that function. Even better would be to have a function such as
> ina2xx_calibrate() and let it handle the write to the calibration register.
> Also, I would suggest to move the above code into its own show function.
> It is probably not a good idea to have a single function for all those
> conversions in the first place, and converting from 'calibration' to
> rshunt goes a bit beyond the original intent to convert from one representation
> to the other.

I agree about having separate functions for this parameter and about
not needing data->rshunt in my current code, but we still aren't clear
about whether to read the value from the register or to store it in
memory.

> That still doesn't really solve the structural problem of having to deal with
> an uninitialized chip which doesn't like to be uninitialized. But then on the
> other side I guess that is really a problem with your platform, not a driver
> problem.

This might be a stupid idea, but what about reading the calibration
register first in ina2xx_update_device() and, in case it's value is 0
(POR value according to the datasheet), reinitializing the chip?

Bart

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
