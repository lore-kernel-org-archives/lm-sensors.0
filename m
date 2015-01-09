From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 09 Jan 2015 14:45:27 +0000
Subject: Re: [lm-sensors] [PATCHv2] hwmon: (ina2xx) implement update_interval attribute for ina226
Message-Id: <CAMpxmJV7O_DqTx66N5t2dWc8JqpqFmvQS+figEOVm9P4DYoZNg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420804980-11637-1-git-send-email-bgolaszewski@baylibre.com>
	<54AFE6E3.4050603@roeck-us.net>
In-Reply-To: <54AFE6E3.4050603@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

2015-01-09 15:34 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> Unfortunately that only applies to INA226 and not INA219, where the time is
> static
> (at least so far).

Oops, I must have missed this one.

> I think we'll need to store the time in ina2xx_data and use the old
> (constant)
> value for ina219. Maybe add another variable into the configuration data
> for the initial value and copy it from there during probe.

I tried to avoid adding another variable used by ina226 only, but
well. It's kind of dull that these chips are supported by a single
driver - their configuration register layout is completely different.

Bart

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
