From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 14:01:30 +0000
Subject: Re: [lm-sensors] [PATCH 04/10] drivers: hwmon: use module_platform_driver_probe()
Message-Id: <20130314140130.GB16825@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <1363266691-15757-6-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1363266691-15757-6-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-ide@vger.kernel.org, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean Delvare <khali@linux-fr.org>

On Thu, Mar 14, 2013 at 02:11:25PM +0100, Fabio Porcedda wrote:
> This patch converts the drivers to use the
> module_platform_driver_probe() macro which makes the code smaller and
> a bit simpler.
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: lm-sensors@lm-sensors.org
> ---
>  drivers/hwmon/mc13783-adc.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
I have that one already queued for -next, submitted by Jingoo Han.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
