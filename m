From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 07 Jan 2015 16:25:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: ina2xx: allow to change the averaging rate at run-time
Message-Id: <CAMpxmJVrbOnjF3me-qyjKqWSxTkQ1=eHdxxsOd7KixVdDGzGoA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420634769-11246-1-git-send-email-bgolaszewski@baylibre.com>
	<54AD3325.6030301@roeck-us.net>
	<CAMpxmJUgXyML4o3ya6ofogjf8KMrdPV-Y6SD=ZfUCjt=xLfGiA@mail.gmail.com>
	<20150107161638.GA9012@roeck-us.net>
In-Reply-To: <20150107161638.GA9012@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

2015-01-07 17:16 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> INA219 uses the same mechanism and timing as used by INA209. This way
> it is easily possible to extend the driver to support the attribute
> for every chip. But overall this uses the existing ABI (update_interval
> is part of the hwmon ABI) instead of creating a new driver specific
> attribute. Yes, that is quite important.
>
> The additional "overhead" is just to use different numbers and a
> different attribute name, so I don't really understand your concern.

My concern is that it seems less clear this way, but I understand the
priorities. Ok, I'll get back to it tomorrow.

Bart

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
