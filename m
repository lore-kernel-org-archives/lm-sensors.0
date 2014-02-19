From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 19 Feb 2014 10:18:50 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/4] hwmon: (lm90) Convert to use hwmon_device_register_with_groups
Message-Id: <20140219111850.5483e22d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392771679-14666-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392771679-14666-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 18 Feb 2014 17:01:19 -0800, Guenter Roeck wrote:
> Simplify code, reduce code size, and attach hwmon attributes to hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: The 'pec' attribute is still attached to the i2c device.
>     Reversed parameter order for lm90_init_client()

All 4 patches look good, I've applied them all, thank you.

> TBD: Should log messages be attached to the hwmon device ?
>      If so I'd probably submit a separate patch for it.

To be honest I don't really care.

> I tested this with MAX6695. Given that the pec attribute is now handled
> differently, it might make sense to test this chip explicitly.
> Jean, do you have one available, at least in simulation ?

Unfortunately simulation is done using i2c-stub which lacks support for
PEC, so it doesn't help.

I do have a physical ADM1032 chip, however it is on a parallel-port
evaluation board, and my workstation lacks such a port. I have one on
another machine in my office, but it's running kernel 3.11 and the
converted driver doesn't built there. So I'll have to build a new
kernel on that old machine first.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
