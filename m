From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 09 Jan 2015 04:32:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ina2xx) implement update_interval attribute for ina226
Message-Id: <54AF59F3.9080200@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420734313-24546-1-git-send-email-bgolaszewski@baylibre.com>	<20150108170519.GA30248@roeck-us.net> <CAMpxmJVmyVr7PJGaAkujacpWyRXew=37bz-PsURf7_-dTptBSw@mail.gmail.com>
In-Reply-To: <CAMpxmJVmyVr7PJGaAkujacpWyRXew=37bz-PsURf7_-dTptBSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On 01/08/2015 10:14 AM, Bartosz Golaszewski wrote:
> 2015-01-08 18:05 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
>> What is the purpose of multiplying the calculated average by 2 ?
>
> The comment above says:
>
>> +     /*
>> +      * Add bus and shunt voltage conversion times and multiple them
>> +      * by the averaging rate. Return the result in milliseconds.
>> +      */
>
> Since both conversion times are the same and equal
> INA226_CONV_TIME_DEFAULT I just multiplied it by 2 - I thought it was
> clear enough. I'll fix that in the next iteration.
>

Sorry, still don't get it. I must be a bit slow today ;-)

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
