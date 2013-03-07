From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 07 Mar 2013 14:30:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75.h) Update header inclusion
Message-Id: <20130307143042.GA664@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130307133301.4cfd2414@endymion.delvare>
In-Reply-To: <20130307133301.4cfd2414@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 07, 2013 at 01:33:01PM +0100, Jean Delvare wrote:
> File lm75.h used to include <linux/hwmon.h> for SENSORS_LIMIT() but
> this function is gone by now. Instead we call clamp_val() so we should
> include <linux/kernel.h>, where this function is declared.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <linux@roeck-us.net>

Good catch. Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
