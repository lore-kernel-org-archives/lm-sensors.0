From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Date: Fri, 09 Aug 2013 05:57:00 +0000
Subject: [lm-sensors] =?utf-8?q?Proposal=3A_I2C_device_power_=28Was=3A_hwm?= =?utf-8?q?on=3A_=28lm90=29_Add_p
Message-Id: <1376027820.695103970@f416.i.mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <20130808211825.GN6427@sirena.org.uk>
 <52040DE2.50201@roeck-us.net>
In-Reply-To: <52040DE2.50201-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?UTF-8?B?R3VlbnRlciBSb2Vjaw==?= <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: =?UTF-8?B?TWFyayBCcm93bg==?= <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?B?V2VpIE5p?= <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Hi all.

Instead of adding the support of regulators in each device, let's think about
whether it is possible to create a global regulator for any device on the I2C bus.

I see it like this:
We add an extra field in the i2c_board_info structure "power_name" and handle
it in the i2c_device_{probe/remove} functions.

The question remains how to maintain such regulator in the PM functions,
but we can discuss it.

Changes like this, will remove existing regulators from drivers and allows to
use power regulator for any I2C device.
If such idea is good, such changes could be made to other devices (SPI, w1, etc.).
Thanks.

---
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
