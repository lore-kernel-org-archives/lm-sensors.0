From: Wei Ni <wni@nvidia.com>
Date: Tue, 19 Feb 2013 10:43:36 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/9] hwmon: (lm90) add support to handle irq
Message-Id: <51235758.60902@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-4-git-send-email-wni@nvidia.com> <20130219033419.GB25610@roeck-us.net>
In-Reply-To: <20130219033419.GB25610@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Alex Courbot <acourbot@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/19/2013 11:34 AM, Guenter Roeck wrote:
> On Mon, Feb 18, 2013 at 07:30:25PM +0800, Wei Ni wrote:
>> Add support to handle irq. When the temperature touch the limit value, the
>> driver can handle the interrupt.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/hwmon/lm90.c |   38 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>> index caf01b0..80311ef 100644
>> --- a/drivers/hwmon/lm90.c
>> +++ b/drivers/hwmon/lm90.c
>> @@ -89,6 +89,8 @@
>>  #include <linux/err.h>
>>  #include <linux/mutex.h>
>>  #include <linux/sysfs.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/of_irq.h>
>>  
>>  /*
>>   * Addresses to scan
>> @@ -302,6 +304,7 @@ static const struct lm90_params lm90_params[] = {
>>  struct lm90_data {
>>  	struct device *hwmon_dev;
>>  	struct mutex update_lock;
>> +	struct work_struct irq_work;
>>  	char valid; /* zero until following fields are valid */
>>  	unsigned long last_updated; /* in jiffies */
>>  	int kind;
>> @@ -1418,6 +1421,29 @@ static void lm90_init_client(struct i2c_client *client)
>>  		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
>>  }
>>  
>> +static void lm90_alert(struct i2c_client *client, unsigned int flag);
>> +
>> +static void lm90_irq_work(struct work_struct *work)
>> +{
>> +	struct lm90_data *data = container_of(work, struct lm90_data,
>> +					      irq_work);
>> +	struct i2c_client *client = to_i2c_client(data->hwmon_dev->parent);
>> +
>> +	lm90_alert(client, 0);
>> +
>> +	enable_irq(client->irq);
>> +}
>> +
>> +static irqreturn_t lm90_irq(int irq, void *dev_id)
>> +{
>> +	struct lm90_data *data = dev_id;
>> +
>> +	disable_irq_nosync(irq);
>> +	schedule_work(&data->irq_work);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  static int lm90_probe(struct i2c_client *client,
>>  		      const struct i2c_device_id *id)
>>  {
>> @@ -1494,6 +1520,17 @@ static int lm90_probe(struct i2c_client *client,
>>  		goto exit_remove_files;
>>  	}
>>  
>> +	if (client->irq >= 0) {
>> +		INIT_WORK(&data->irq_work, lm90_irq_work);
>> +		dev_dbg(dev, "lm90 irq: %d\n", client->irq);
>> +		err = request_irq(client->irq, lm90_irq, IRQF_TRIGGER_LOW,
>> +				       "lm90", data);
> 
> request_threaded_irq or even better devm_request_threaded_irq would be better here.

yes, it's better to use request_threaded_irq here.
we can set lm90_irq() as interrupt handle, and set lm90_alert() as
thread function.
I will try it on my next version.

> 
>> +		if (err < 0) {
>> +			dev_err(dev, "cannot request interrupt\n");
>> +			goto exit_remove_files;
>> +		}
>> +	}
>> +
>>  	return 0;
>>  
>>  exit_remove_files:
>> @@ -1507,6 +1544,7 @@ static int lm90_remove(struct i2c_client *client)
>>  {
>>  	struct lm90_data *data = i2c_get_clientdata(client);
>>  
>> +	free_irq(client->irq, data);
>>  	hwmon_device_unregister(data->hwmon_dev);
>>  	lm90_remove_files(client, data);
>>  	lm90_restore_conf(client, data);
>> -- 
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
