From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jan 2012 14:28:56 +0000
Subject: Re: [lm-sensors] [PATCH 06/79] hwmon: (lm87) Fix: do not use assignment in if condition
Message-Id: <20120126152856.3a413ce0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-7-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-7-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 23 Jan 2012 18:48:45 -0800, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Fix checkpatch issue:
> ERROR: do not use assignment in if condition
> 
> Replace repeated calls to device_create_file() with calls to sysfs_create_group.
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm87.c |  152 ++++++++++++++++++++++++++------------------------
>  1 files changed, 80 insertions(+), 72 deletions(-)

Overall I like it. Just one suggestion:

> +static void lm87_remove_files(struct i2c_client *client)
> +{

I think it makes sense to introduce
	struct device *dev = &client->dev;
to make the rest of the function easier to read. The binary code
generated is unchanged.

The same might be a good idea in the probe function, for the same
reason.

> +	sysfs_remove_group(&client->dev.kobj, &lm87_group);
> +	sysfs_remove_group(&client->dev.kobj, &lm87_group_in6);
> +	sysfs_remove_group(&client->dev.kobj, &lm87_group_fan1);
> +	sysfs_remove_group(&client->dev.kobj, &lm87_group_in7);
> +	sysfs_remove_group(&client->dev.kobj, &lm87_group_fan2);
> +	sysfs_remove_group(&client->dev.kobj, &lm87_group_temp3);
> +	sysfs_remove_group(&client->dev.kobj, &lm87_group_in0_5);
> +	sysfs_remove_group(&client->dev.kobj, &lm87_group_vid);
> +}

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
