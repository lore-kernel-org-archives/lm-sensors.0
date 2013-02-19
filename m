From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Feb 2013 03:34:19 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/9] hwmon: (lm90) add support to handle irq
Message-Id: <20130219033419.GB25610@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-4-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-4-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On Mon, Feb 18, 2013 at 07:30:25PM +0800, Wei Ni wrote:
> Add support to handle irq. When the temperature touch the limit value, the
> driver can handle the interrupt.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |   38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index caf01b0..80311ef 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -89,6 +89,8 @@
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_irq.h>
>  
>  /*
>   * Addresses to scan
> @@ -302,6 +304,7 @@ static const struct lm90_params lm90_params[] = {
>  struct lm90_data {
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
> +	struct work_struct irq_work;
>  	char valid; /* zero until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  	int kind;
> @@ -1418,6 +1421,29 @@ static void lm90_init_client(struct i2c_client *client)
>  		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
>  }
>  
> +static void lm90_alert(struct i2c_client *client, unsigned int flag);
> +
> +static void lm90_irq_work(struct work_struct *work)
> +{
> +	struct lm90_data *data = container_of(work, struct lm90_data,
> +					      irq_work);
> +	struct i2c_client *client = to_i2c_client(data->hwmon_dev->parent);
> +
> +	lm90_alert(client, 0);
> +
> +	enable_irq(client->irq);
> +}
> +
> +static irqreturn_t lm90_irq(int irq, void *dev_id)
> +{
> +	struct lm90_data *data = dev_id;
> +
> +	disable_irq_nosync(irq);
> +	schedule_work(&data->irq_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int lm90_probe(struct i2c_client *client,
>  		      const struct i2c_device_id *id)
>  {
> @@ -1494,6 +1520,17 @@ static int lm90_probe(struct i2c_client *client,
>  		goto exit_remove_files;
>  	}
>  
> +	if (client->irq >= 0) {
> +		INIT_WORK(&data->irq_work, lm90_irq_work);
> +		dev_dbg(dev, "lm90 irq: %d\n", client->irq);
> +		err = request_irq(client->irq, lm90_irq, IRQF_TRIGGER_LOW,
> +				       "lm90", data);

request_threaded_irq or even better devm_request_threaded_irq would be better here.

> +		if (err < 0) {
> +			dev_err(dev, "cannot request interrupt\n");
> +			goto exit_remove_files;
> +		}
> +	}
> +
>  	return 0;
>  
>  exit_remove_files:
> @@ -1507,6 +1544,7 @@ static int lm90_remove(struct i2c_client *client)
>  {
>  	struct lm90_data *data = i2c_get_clientdata(client);
>  
> +	free_irq(client->irq, data);
>  	hwmon_device_unregister(data->hwmon_dev);
>  	lm90_remove_files(client, data);
>  	lm90_restore_conf(client, data);
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
