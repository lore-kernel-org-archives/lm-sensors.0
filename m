From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 10 Dec 2014 16:46:43 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/3] hwmon: ina2xx: make shunt resistance configurable at run-time
Message-Id: <CAMpxmJXp2NT+rie2d2+Z7hixKMyS+xcRNdKRNZaUSJD-aTUVVg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418207937-11648-1-git-send-email-bgolaszewski@baylibre.com>
	<1418207937-11648-2-git-send-email-bgolaszewski@baylibre.com>
	<548856AF.8090805@roeck-us.net>
In-Reply-To: <548856AF.8090805@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

2014-12-10 15:20 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
>> +       case INA2XX_CALIBRATION:
>> +               if (data->regs[reg] = 0)
>> +                       val = 0;
>> +               else
>> +                       val = data->config->calibration_factor
>> +                                               / data->regs[reg];
>> +               break;
>
>
> This doesn't really make sense. What you want to show is rshunt, not the
> above.
> I think it would be better to write a separate show function to display it.

Hi Guenter,

this is the only way to display values read from the chip. It also
tells the user what the actual programmed value is. In fact it was
your suggestion (https://lkml.org/lkml/2014/11/30/233) and I agree
that it's a better alternative. Are you sure you don't want it done
this way?

Bart

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
