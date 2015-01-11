From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 11 Jan 2015 01:25:55 +0000
Subject: Re: [lm-sensors] [PATCHv3] hwmon: (ina2xx) implement update_interval attribute for ina226
Message-Id: <54B1D123.2010007@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420819422-24784-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1420819422-24784-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On 01/09/2015 08:03 AM, Bartosz Golaszewski wrote:
> This attribute allows to configure the update interval of ina226. Although
> the bus and shunt voltage conversion times remain hardcoded to 1.1 ms, we can
> now modify said interval by changing the averaging rate.
>
> While we're at it - add an additional variable to ina2xx_data, which holds
> the current configuration settings - this way we'll be able to restore the
> configuration in case of an unexpected chip reset.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
