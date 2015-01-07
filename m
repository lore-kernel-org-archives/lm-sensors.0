From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 07 Jan 2015 15:41:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: ina2xx: allow to change the averaging rate at run-time
Message-Id: <CAMpxmJUgXyML4o3ya6ofogjf8KMrdPV-Y6SD=ZfUCjt=xLfGiA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420634769-11246-1-git-send-email-bgolaszewski@baylibre.com>
	<54AD3325.6030301@roeck-us.net>
In-Reply-To: <54AD3325.6030301@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

2015-01-07 14:22 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> I think I know what to do here. Can you look into the ina209 driver ?
> It uses update_interval and calculates the number of samples to use from it.
> The ina226 datasheet suggests that we can do the same, combined with the
> conversion time configuration. We would have to use the default conversion
> time of 1.1ms for that to make sense, but that is what it is today,
> so it would be ok. This way we are in line with the ABI and can still
> configure the number of averages.
>

Just to make sure I understood you correctly: I should add
update_interval attribute instead of avg_rate, accept the desired
interval (as time) instead of the number of averages and - already
having the conversion time hardcoded to 1.1 ms - calculate the
averaging rate? Isn't this an overkill for what we're trying to
implement? I know it's for the sake of staying uniform with already
existing interface of ina209 but on the other hand these devices
aren't quite the same.

Bart

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
