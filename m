From: Wei Ni <wni@nvidia.com>
Date: Tue, 09 Jul 2013 07:58:54 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (lm90) add support to handle irq
Message-Id: <51DBC2BE.6050000@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372924670-16355-1-git-send-email-wni@nvidia.com> <1372924670-16355-3-git-send-email-wni@nvidia.com> <20130709061514.GB17499@mithrandir>
In-Reply-To: <20130709061514.GB17499@mithrandir>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org" <linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/09/2013 02:15 PM, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Jul 04, 2013 at 03:57:49PM +0800, Wei Ni wrote:
>> Add support to handle irq. When the temperature touch
> 
> Nit: This first sentence can be dropped. It merely repeats the subject.
> And another nit: "irq" -> "IRQ"

Ok, I will update in my next version.

> 
>> the limit value, the driver can handle the interrupt.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/hwmon/lm90.c |   25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>> index 2cb7f8e..fce9dfa 100644
>> --- a/drivers/hwmon/lm90.c
>> +++ b/drivers/hwmon/lm90.c
>> @@ -89,6 +89,7 @@
>>  #include <linux/err.h>
>>  #include <linux/mutex.h>
>>  #include <linux/sysfs.h>
>> +#include <linux/interrupt.h>
>>  
>>  /*
>>   * Addresses to scan
>> @@ -1423,6 +1424,18 @@ static void lm90_init_client(struct i2c_client *client)
>>  		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
>>  }
>>  
>> +static void lm90_alert(struct i2c_client *client, unsigned int flag);
> 
> Any reason why the implementation of lm90_alert() can't be moved here.
> Granted, it'll make the diff larger but at least it'll allow us to get
> rid of the forward declaration.

Ok, you are right, I will move it.

> 
>> +static irqreturn_t lm90_irq_thread(int irq, void *dev_id)
>> +{
>> +	struct lm90_data *data = dev_id;
>> +	struct i2c_client *client = to_i2c_client(data->hwmon_dev->parent);
>> +
>> +	lm90_alert(client, 0);
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> Isn't this potentially dangerous, since if the IRQ was shared, IRQ
> processing will always stop after this handler. Shouldn't you check
> whether the device actually triggered an interrupt (by reading the
> interrupt status register)?

Yes, it has potential dangerous, I didn't consider it carefully.
I will check the interrupt status.

> 
>> +
>>  static int lm90_probe(struct i2c_client *client,
>>  		      const struct i2c_device_id *id)
>>  {
>> @@ -1499,6 +1512,18 @@ static int lm90_probe(struct i2c_client *client,
>>  		goto exit_remove_files;
>>  	}
>>  
>> +	if (client->irq >= 0) {
>> +		dev_dbg(dev, "lm90 irq: %d\n", client->irq);
> 
> Nit: "irq" -> "IRQ"

Ok, got it.

> 
> Thierry
> 
> * Unknown Key
> * 0x7F3EB3A1
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
