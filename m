From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 18:20:56 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (gpio-fan) Fix fan_ctrl_init
Message-Id: <1289326856.22931.211.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289292108.28671.1.camel@mola>
In-Reply-To: <1289292108.28671.1.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, Simon Guinot <sguinot@lacie.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Tue, 2010-11-09 at 03:41 -0500, Axel Lin wrote:
> In current implementation, the sysfs entries is not removed before return -ENODEV.
> 
> Creating the sysfs attribute should be the last thing done by the function,
> after all the rest has been successful.
> Otherwise there is a small window during which user-space can access the attribute
> but the driver isn't ready to deal with the requests.
> 
> Fix it by moving sysfs_create_group to be the last thing done by the function.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
