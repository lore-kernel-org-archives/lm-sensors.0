From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Jan 2012 13:47:34 +0000
Subject: Re: [lm-sensors] [PATCH 11/39] hwmon: (ds1621 Fix checkpatch issues
Message-Id: <20120120144734.6359cf50@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326703781-14272-12-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326703781-14272-12-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 16 Jan 2012 00:49:13 -0800, Guenter Roeck wrote:
> Fixed:
> ERROR: code indent should use tabs where possible
> ERROR: do not use assignment in if condition
> ERROR: trailing whitespace
> WARNING: labels should not be indented
> WARNING: please, no spaces at the start of a line
> WARNING: simple_strtol is obsolete, use kstrtol instead
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/ds1621.c |   32 +++++++++++++++++++-------------
>  1 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
> index ef1ac996..e23a8ab 100644
> --- a/drivers/hwmon/ds1621.c
> +++ b/drivers/hwmon/ds1621.c
> (...)
> @@ -265,11 +271,11 @@ static int ds1621_probe(struct i2c_client *client,
>  
>  	return 0;
>  
> -      exit_remove_files:
> +exit_remove_files:
>  	sysfs_remove_group(&client->dev.kobj, &ds1621_group);
> -      exit_free:
> +exit_free:
>  	kfree(data);
> -      exit:
> +exit:
>  	return err;
>  }
>  

It is generally accepted to indent labels with a single space. This
avoids breaking the -p option of diff. I think checkpatch would be
happy with this, and I'd prefer this to no indentation at all as you
did.

All other changes look good, tested OK too. If you fix adjust the
labels as suggested above, you can add:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
