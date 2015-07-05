From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 05 Jul 2015 02:41:00 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (nct7802) Add pwm mode
Message-Id: <5598993C.9090003@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436049691-20312-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1436049691-20312-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/04/2015 03:41 PM, Constantine Shulyupin wrote:
> Introduced: show_pwm_mode, pwm1_mode, pwm2_mode, pwm2_mode
>
> ---
> Changelog:
> Fixed in v2:
> - used SENSOR_DEVICE_ATTR instead of SENSOR_DEVICE_ATTR_2 for pwmX_mode
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
