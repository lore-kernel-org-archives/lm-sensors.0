From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 Jan 2015 14:23:53 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: (ina2xx) code clean-up and minor fixes
Message-Id: <54B3D8F9.9030003@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421070442-9635-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1421070442-9635-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On 01/12/2015 05:47 AM, Bartosz Golaszewski wrote:
> This small series fixes two minor issues in the driver after recent
> implementation of new attributes. The first patch removes an unnecessary
> result check after calling dev_get_drvdata() and the second one adds
> calls to DIV_ROUND_CLOSEST() to avoid rounding errors.
>
> This series is rebased against current hwmon-next.
>
> Bartosz Golaszewski (2):
>    hwmon: (ina2xx) remove an unnecessary dev_get_drvdata() result check
>    hwmon: (ina2xx) use DIV_ROUND_CLOSEST() to avoid rounding errors
>
Both applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
