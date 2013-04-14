From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 14 Apr 2013 07:32:05 +0000
Subject: Re: [lm-sensors] [PATCH 2/5] hwmon: (tmp401) Use sysfs_create_group / sysfs_remove_group
Message-Id: <20130414093205.695bb5c5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365210177-24656-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365210177-24656-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri,  5 Apr 2013 18:02:54 -0700, Guenter Roeck wrote:
> instead of creating and removing sysfs attribute files individually.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/tmp401.c |  151 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 90 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index ef04cf8..f07fc40 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> (...)
>  static int tmp401_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> -	int i, err = 0;
> +	struct device *dev = &client->dev;

You left one instance of &client->dev in this function. Either convert
them all, or none.

Other than this minor detail, fine with me. Even though it's a bit sad
when a cleanup increases both the line count and the binary size of a
driver.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
