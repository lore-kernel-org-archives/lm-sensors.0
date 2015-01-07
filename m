From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 07 Jan 2015 16:16:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: ina2xx: allow to change the averaging rate at run-time
Message-Id: <20150107161638.GA9012@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420634769-11246-1-git-send-email-bgolaszewski@baylibre.com>
 <54AD3325.6030301@roeck-us.net>
 <CAMpxmJUgXyML4o3ya6ofogjf8KMrdPV-Y6SD=ZfUCjt=xLfGiA@mail.gmail.com>
In-Reply-To: <CAMpxmJUgXyML4o3ya6ofogjf8KMrdPV-Y6SD=ZfUCjt=xLfGiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On Wed, Jan 07, 2015 at 04:41:35PM +0100, Bartosz Golaszewski wrote:
> 2015-01-07 14:22 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> > I think I know what to do here. Can you look into the ina209 driver ?
> > It uses update_interval and calculates the number of samples to use from it.
> > The ina226 datasheet suggests that we can do the same, combined with the
> > conversion time configuration. We would have to use the default conversion
> > time of 1.1ms for that to make sense, but that is what it is today,
> > so it would be ok. This way we are in line with the ABI and can still
> > configure the number of averages.
> >
> 
> Just to make sure I understood you correctly: I should add
> update_interval attribute instead of avg_rate, accept the desired
> interval (as time) instead of the number of averages and - already
> having the conversion time hardcoded to 1.1 ms - calculate the
> averaging rate? Isn't this an overkill for what we're trying to
> implement? I know it's for the sake of staying uniform with already
> existing interface of ina209 but on the other hand these devices
> aren't quite the same.
> 
INA219 uses the same mechanism and timing as used by INA209. This way
it is easily possible to extend the driver to support the attribute
for every chip. But overall this uses the existing ABI (update_interval
is part of the hwmon ABI) instead of creating a new driver specific
attribute. Yes, that is quite important.

The additional "overhead" is just to use different numbers and a
different attribute name, so I don't really understand your concern.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
