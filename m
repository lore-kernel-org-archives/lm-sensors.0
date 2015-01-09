From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 09 Jan 2015 17:57:34 +0000
Subject: Re: [lm-sensors] [PATCHv2] hwmon: (ina2xx) implement update_interval attribute for ina226
Message-Id: <20150109175734.GA30337@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420804980-11637-1-git-send-email-bgolaszewski@baylibre.com>
 <54AFE6E3.4050603@roeck-us.net>
 <CAMpxmJV7O_DqTx66N5t2dWc8JqpqFmvQS+figEOVm9P4DYoZNg@mail.gmail.com>
In-Reply-To: <CAMpxmJV7O_DqTx66N5t2dWc8JqpqFmvQS+figEOVm9P4DYoZNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On Fri, Jan 09, 2015 at 03:45:27PM +0100, Bartosz Golaszewski wrote:
> 2015-01-09 15:34 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> > Unfortunately that only applies to INA226 and not INA219, where the time is
> > static
> > (at least so far).
> 
> Oops, I must have missed this one.
> 
> > I think we'll need to store the time in ina2xx_data and use the old
> > (constant)
> > value for ina219. Maybe add another variable into the configuration data
> > for the initial value and copy it from there during probe.
> 
> I tried to avoid adding another variable used by ina226 only, but
> well. It's kind of dull that these chips are supported by a single
> driver - their configuration register layout is completely different.
> 
On the other side the data registers are the same. There is always some
trade-off.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
