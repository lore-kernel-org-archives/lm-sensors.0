From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [PATCH 2.6] I2C: New hardware monitor driver: adm9240
Message-Id: <4vQK2mbU.1114612942.6181050.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
In-Reply-To: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Changes since last submission: remove unused includes, rename
> sysfs 'ci_clear' to 'control' as another driver uses 'control',
> rename 'analog_out' to 'aout_output' to match sysfs naming style,
> change scaling macros to static inlines, update auto fan_div
> comments.

The "control" name isn't a good one IMHO. It could hardly be less
descriptive. The fact that another driver uses it is not relevant, as it
is not part of our sysfs standard. "chassis_clear" maybe?

My comments about your code:

> +#include <linux/i2c.h>
> +#include <linux/i2c-sensor.h>
> +#include <linux/i2c-vid.h>

I think you have been a bit agressive in your includes removal. Please at
least include linux/init.h, linux/module.h and linux/slab.h. The driver
needs them.

> +static unsigned short normal_i2c[] = { 0x2c,0x2d,0x2e,0x2f,
> I2C_CLIENT_END };

Space after the commas please. There are a couple other places in the
code where they are missing, please add them where needed.

> +		adm9240_write_value(client, ADM9240_REG_TEMP_CONF, 0);
> +		adm9240_write_value(client, ADM9240_REG_CONFIG, 1);

What an agressive initialization. Please only set the bits which really
need to be. Arbitrary reconfiguration of hardware monitoring chips is
not wise.

Otherwise I am fine with your code.

Thanks,
--
Jean Delvare
