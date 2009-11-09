From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 09 Nov 2009 10:52:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adt7475) Cache limits for 60
Message-Id: <4AF7F45E.2090705@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091109113829.204f18fe@hyperion.delvare>
In-Reply-To: <20091109113829.204f18fe@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ack.

On 11/09/2009 11:38 AM, Jean Delvare wrote:
> The comment says that limits are cached for 60 seconds but the code
> actually caches them for only 2 seconds. Align the code on the
> comment, as 60 seconds make more sense.
>
> Signed-off-by: Jean Delvare<khali@linux-fr.org>
> Cc: Hans de Goede<hdegoede@redhat.com>
> Cc: Jordan Crouse<jordan@cosmicpenguin.net>
> ---
>   drivers/hwmon/adt7475.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-2.6.32-rc6.orig/drivers/hwmon/adt7475.c	2009-11-08 19:22:06.000000000 +0100
> +++ linux-2.6.32-rc6/drivers/hwmon/adt7475.c	2009-11-09 10:28:59.000000000 +0100
> @@ -1151,7 +1151,7 @@ static struct adt7475_data *adt7475_upda
>   	}
>
>   	/* Limits and settings, should never change update every 60 seconds */
> -	if (time_after(jiffies, data->limits_updated + HZ * 2) ||
> +	if (time_after(jiffies, data->limits_updated + HZ * 60) ||
>   	    !data->valid) {
>   		data->config5 = adt7475_read(REG_CONFIG5);
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
