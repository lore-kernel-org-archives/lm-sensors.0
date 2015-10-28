From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 28 Oct 2015 02:47:11 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] hwmon: ina2xx: convert driver to using regmap
Message-Id: <20151028024711.GA30927@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20151027011229.GC31838@roeck-us.net>
 <1445939468-21755-1-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1445939468-21755-1-git-send-email-mtitinger@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Titinger <mtitinger@baylibre.com>
Cc: jdelvare@suse.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, bcousson@baylibre.com, ptitiano@baylibre.com

On Tue, Oct 27, 2015 at 10:51:07AM +0100, Marc Titinger wrote:
> Any sysfs "show" read access from the client app will result in reading
> all registers (8 with ina226). Depending on the host this can limit the
> best achievable read rate.
> 
> This changeset allows for individual register accesses through regmap.
> 
> Tested with BeagleBone Black (Baylibre-ACME) and ina226.
> 
> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
> ---
> 
>   v2:
> 	- rename 'rv' to 'regval' for clarity
> 	- fix missed smbus_xxx api change to regmap
> 	- rename ina2xx_do_update to ina2xx_read_reg
> 	- fix indentation
> 
>  drivers/hwmon/ina2xx.c | 211 +++++++++++++++++++------------------------------
>  1 file changed, 82 insertions(+), 129 deletions(-)
> 
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index 4d28150..5e7ada8 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c

[ ... ]
>  
> -	mutex_lock(&data->update_lock);
>  	data->rshunt = val;
>  	status = ina2xx_calibrate(data);
> -	mutex_unlock(&data->update_lock);

I think this can result in a race conditon if multiple processes
try to update the shunt resistor value at the same time in a
multi-core system. There is no guarantee that the value programmed
into the chip matches the value that is written into 'rshunt'.
So I think we still need the mutex, unless you have a better
idea how to avoid the race.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
