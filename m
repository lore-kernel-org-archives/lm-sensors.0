From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 13 Mar 2011 14:02:20 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon/f71882fg: Set platform drvdata
Message-Id: <20110313150220.24806f7b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300020634-7724-2-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1300020634-7724-2-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 13 Mar 2011 13:50:33 +0100, Hans de Goede wrote:
> This avoids a possible race leading to trying to dereference NULL.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/hwmon/f71882fg.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index 9cb52f5..a4d430e 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -2280,7 +2280,6 @@ static int f71882fg_remove(struct platform_device *pdev)
>  	int nr_temps = (data->type = f71808e) ? 2 : 3;
>  	u8 start_reg = f71882fg_read8(data, F71882FG_REG_START);
>  
> -	platform_set_drvdata(pdev, NULL);
>  	if (data->hwmon_dev)
>  		hwmon_device_unregister(data->hwmon_dev);
>  
> @@ -2363,6 +2362,7 @@ static int f71882fg_remove(struct platform_device *pdev)
>  		}
>  	}
>  
> +	platform_set_drvdata(pdev, NULL);
>  	kfree(data);
>  
>  	return 0;


Acked-by: Jean Delvare <khali@linux-fr.org>

I'd suggest a
Cc: stable@kernel.org
for this fix too.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
