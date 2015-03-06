From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 06 Mar 2015 03:59:27 +0000
Subject: Re: [lm-sensors] [PATCH -next] sensors: fix build of pwm-fan.c when THERMAL=m
Message-Id: <54F9261F.6080007@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <54F8E666.9090403@infradead.org>
In-Reply-To: <54F8E666.9090403@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>, lm-sensors@lm-sensors.org, LKML <linux-kernel@vger.kernel.org>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>

On 03/05/2015 03:27 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build errors when CONFIG_THERMAL=m and SENSORS_PWM_FAN=y
> by restricting SENSORS_PWM_FAN to 'm' when THERMAL=m.
>
> drivers/built-in.o: In function `pwm_fan_remove':
> pwm-fan.c:(.text+0x22ba58): undefined reference to `thermal_cooling_device_unregister'
> drivers/built-in.o: In function `pwm_fan_probe':
> pwm-fan.c:(.text+0x22bebb): undefined reference to `thermal_of_cooling_device_register'
> pwm-fan.c:(.text+0x22bf11): undefined reference to `thermal_cdev_update'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kamil Debski <k.debski@samsung.com>
> ---

Applied, thanks.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
