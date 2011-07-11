From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Jul 2011 20:11:48 +0000
Subject: Re: [lm-sensors] [PATCH v2] MAX1111: Fix Race condition causing
Message-Id: <20110711221148.3a76d55b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310410051-13127-1-git-send-email-morpheus.ibis@gmail.com>
In-Reply-To: <1310410051-13127-1-git-send-email-morpheus.ibis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Pavel,

On Mon, 11 Jul 2011 20:47:31 +0200, Pavel Herrmann wrote:
> spi_sync call uses its spi_message parameter to keep completion information,
> having this structure static is not thread-safe, potentially causing one
> thread having pointers to memory on or above other threads stack. use mutex
> to prevent multiple access

This has nothing to do with static, as a matter of fact the structure
is dynamically allocated. The bottom line is that the driver structure
is such that calls to max1111_read() must be serialized.
> 
> Signed-off-by: Pavel Herrmann <morpheus.ibis@gmail.com>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> Acked-by: Cyril Hrubis <metan@ucw.cz>
> ---
>  drivers/hwmon/max1111.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
> index 12a54aa..d872f57 100644
> --- a/drivers/hwmon/max1111.c
> +++ b/drivers/hwmon/max1111.c
> @@ -40,6 +40,7 @@ struct max1111_data {
>  	struct spi_transfer	xfer[2];
>  	uint8_t *tx_buf;
>  	uint8_t *rx_buf;
> +	struct mutex		msg_lock_mutex;

"lock" and "mutex" being kind of synonyms, this is a rather bad name.
And you should add a comment explaining what is protected. As I
understand it, it's more than just msg, it's also protecting xfer,
tx_buf and rx_buf.

>  };
>  
>  static int max1111_read(struct device *dev, int channel)
> @@ -48,6 +49,11 @@ static int max1111_read(struct device *dev, int channel)
>  	uint8_t v1, v2;
>  	int err;
>  
> +	/* spi_sync requires data not to be freed before function returns
> +	 * for static data, any access is dangerous, use locks
> +	 */

This has nothing to do with "freeing data". max1111_read() doesn't free
anything. It is making use of a data structure, the access to which
must be serialized. Easy as that. And no, access isn't dangerous ;)

> +	mutex_lock(&data->msg_lock_mutex);
> +
>  	data->tx_buf[0] = (channel << MAX1111_CTRL_SEL_SH) |
>  		MAX1111_CTRL_PD0 | MAX1111_CTRL_PD1 |
>  		MAX1111_CTRL_SGL | MAX1111_CTRL_UNI | MAX1111_CTRL_STR;
> @@ -55,12 +61,15 @@ static int max1111_read(struct device *dev, int channel)
>  	err = spi_sync(data->spi, &data->msg);
>  	if (err < 0) {
>  		dev_err(dev, "spi_sync failed with %d\n", err);
> +		mutex_unlock(&data->msg_lock_mutex);
>  		return err;
>  	}
>  
>  	v1 = data->rx_buf[0];
>  	v2 = data->rx_buf[1];
>  
> +	mutex_unlock(&data->msg_lock_mutex);
> +
>  	if ((v1 & 0xc0) || (v2 & 0x3f))
>  		return -EINVAL;
>  
> @@ -176,6 +185,8 @@ static int __devinit max1111_probe(struct spi_device *spi)
>  	if (err)
>  		goto err_free_data;
>  
> +	mutex_init(&data->msg_lock_mutex);
> +
>  	data->spi = spi;
>  	spi_set_drvdata(spi, data);
>  
> @@ -213,6 +224,7 @@ static int __devexit max1111_remove(struct spi_device *spi)
>  
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
> +	mutex_destroy(data->msg_lock_mutex);

I didn't know about this function, interesting. No other hwmon driver
calls it, not sure if it makes sense when the underlying memory is
going to be freed immediately afterwards anyway. But of course it can't
hurt.

>  	kfree(data->rx_buf);
>  	kfree(data->tx_buf);
>  	kfree(data);

Unrelated to your patch, but these 3 separate allocs are really insane,
memory usage in this driver could be much improved IMHO.

Please respin your patch with a better struct member name and improved
description and comments, and I'll be happy to apply it.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
