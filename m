From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Nov 2013 03:34:50 +0000
Subject: Re: [lm-sensors] [PATCH] sfc: Convert to use hwmon_device_register_with_groups
Message-Id: <5295685A.7010707@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385523037-3774-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385523037-3774-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-net-drivers@solarflare.com, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>

On 11/26/2013 07:30 PM, Guenter Roeck wrote:
> Simplify the code. Avoid race conditions caused by attributes
> being created after hwmon device registration. Implicitly
> (through hwmon API) add mandatory 'name' sysfs attribute.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Compile tested only.
>

Sorry for the noise if you see this patch multiple times. My send script tried to annoy me.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
