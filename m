From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 07 Jan 2015 12:48:40 +0000
Subject: Re: [lm-sensors] [v8, 5/5] hwmon: ina2xx: allow to change the averaging rate at run-time
Message-Id: <CAMpxmJUeX1J+wHW_c0NLeOgPcUyv82s9fH+xo8aisdwBYH2hUg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420467656-6112-6-git-send-email-bgolaszewski@baylibre.com>
	<20150106181842.GA618@roeck-us.net>
In-Reply-To: <20150106181842.GA618@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Patrick Titiano <ptitiano@baylibre.com>, LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

2015-01-06 19:18 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> ina226_avg_val() calculates the average value from ina226_avg_tab
> and then you loop through ina226_avg_tab to find the index into ina226_avg_tab
> again, only to use the thus calculated index for accessing ina226_avg_tab[]
> once more. Think about it. A simple
>         avg = ina226_avg_tab[INA226_READ_AVG(data->regs[INA2XX_CONFIG])];
>         return snprintf(buf, PAGE_SIZE, "%d\n", avg);
> or even
>         return snprintf(buf, PAGE_SIZE, "%d\n",
>                         ina226_avg_tab[INA226_READ_AVG(data->regs[INA2XX_CONFIG])]);
>
> would accomplish exactly the same.

This was stupid, I admit. Fixed in the new version. Hope it's ok now.

> I kind of dislike that attribute name. I don't have a better idea though, so
> I'll let it pass unless you have a better idea.

I don't really. What's wrong with this one?

Bart

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
