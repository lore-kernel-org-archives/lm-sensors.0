From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 23 Jan 2015 15:55:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Allow negative hysteresis temperatures
Message-Id: <54C26F01.1020100@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150123102703.4ff3ce85@endymion.delvare>
In-Reply-To: <20150123102703.4ff3ce85@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/23/2015 01:27 AM, Jean Delvare wrote:
> The driver supports negative high and critical limits, it can return
> negative hysteresis values, so there is no good reason to not let the
> user write negative hysteresis values.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---

Hi Jean,

thanks for looking into this. Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
