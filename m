From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 03 Feb 2014 15:18:02 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/4] hwmon: (lm63) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140203161802.70d80a6b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1391390510-19238-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1391390510-19238-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun,  2 Feb 2014 17:21:50 -0800, Guenter Roeck wrote:
> Simplify code, reduce code size, attach hwmon attributes to hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Do not drop client variable in various functions to reduce scope
>     of code changes.
>     Associate error message in lm63_lut_looks_bad with hwmon device.
>     Note: Doing the same in lm62_init_client() doesn't work since
> 	  the hwmon device is not yet available.

That's fine. Initialization messages go with the hardware device,
run-time messages go with the class device, I think it makes sense.

> 
>  drivers/hwmon/lm63.c |  106 +++++++++++++++++++-------------------------------
>  1 file changed, 40 insertions(+), 66 deletions(-)

Applied, thanks.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
