From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 08 Jan 2015 18:14:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ina2xx) implement update_interval attribute for ina226
Message-Id: <CAMpxmJVmyVr7PJGaAkujacpWyRXew=37bz-PsURf7_-dTptBSw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420734313-24546-1-git-send-email-bgolaszewski@baylibre.com>
	<20150108170519.GA30248@roeck-us.net>
In-Reply-To: <20150108170519.GA30248@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

2015-01-08 18:05 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> What is the purpose of multiplying the calculated average by 2 ?

The comment above says:

> +     /*
> +      * Add bus and shunt voltage conversion times and multiple them
> +      * by the averaging rate. Return the result in milliseconds.
> +      */

Since both conversion times are the same and equal
INA226_CONV_TIME_DEFAULT I just multiplied it by 2 - I thought it was
clear enough. I'll fix that in the next iteration.

Bart

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
