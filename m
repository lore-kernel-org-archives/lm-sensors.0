From: Wei Ni <wni@nvidia.com>
Date: Wed, 17 Jul 2013 07:03:35 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/4] hwmon: (lm90) use macro defines for the status bit
Message-Id: <51E641C7.4000107@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com> <1373615287-18502-3-git-send-email-wni@nvidia.com> <20130715185727.4ebde8c4@endymion.delvare>
In-Reply-To: <20130715185727.4ebde8c4-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/16/2013 12:57 AM, Jean Delvare wrote:
> Hi Wei, Guenter,
> 
> On Fri, 12 Jul 2013 15:48:05 +0800, Wei Ni wrote:
>> Add bit defines for the status register.
> 
> Regarding the subject: for me these are constants, not macros. AFAIK
> the term "macro" refers to defines with parameters only.

How about "Introduce status bits"

> 
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/hwmon/lm90.c |   72 ++++++++++++++++++++++++++++++++++----------------
>>  1 file changed, 49 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>> index 5f30f90..c90037f 100644
>> --- a/drivers/hwmon/lm90.c
>> +++ b/drivers/hwmon/lm90.c
>> @@ -179,6 +179,19 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
>>  #define LM90_HAVE_TEMP3		(1 << 6) /* 3rd temperature sensor	*/
>>  #define LM90_HAVE_BROKEN_ALERT	(1 << 7) /* Broken alert		*/
>>  
>> +/* LM90 status */
>> +#define LM90_STATUS_LTHRM	(1 << 0) /* local THERM limit tripped */
>> +#define LM90_STATUS_RTHRM	(1 << 1) /* remote THERM limit tripped */
>> +#define LM90_STATUS_OPEN	(1 << 2) /* remote is an open circuit */
>> +#define LM90_STATUS_RLOW	(1 << 3) /* remote low temp limit tripped */
>> +#define LM90_STATUS_RHIGH	(1 << 4) /* remote high temp limit tripped */
>> +#define LM90_STATUS_LLOW	(1 << 5) /* local low temp limit tripped */
>> +#define LM90_STATUS_LHIGH	(1 << 6) /* local high temp limit tripped */
>> +#define LM90_STATUS_BUSY	(1 << 7) /* ADC is converting */
> 
> LM90_STATUS_BUSY is never used anywhere so please don't define it.

Ok, I will remove it.

> 
>> +
>> +#define MAX6696_STATUS2_RLOW	(1 << 3) /* remote2 low temp limit tripped */
>> +#define MAX6696_STATUS2_RHIGH	(1 << 4) /* remote2 high temp limit tripped */
>> +
>>  /*
>>   * Driver data (common to all clients)
>>   */
>> @@ -1417,6 +1430,36 @@ static void lm90_init_client(struct i2c_client *client)
>>  		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
>>  }
>>  
>> +static bool lm90_is_tripped(struct i2c_client *client)
>> +{
>> +	struct lm90_data *data = i2c_get_clientdata(client);
>> +	u8 status, status2 = 0;
>> +
>> +	lm90_read_reg(client, LM90_REG_R_STATUS, &status);
>> +
>> +	if (data->kind = max6696)
>> +		lm90_read_reg(client, MAX6696_REG_R_STATUS2, &status2);
>> +
>> +	if ((status & 0x7f) = 0 && (status2 & 0xfe) = 0)
>> +		return false;
> 
> It's a bit disappointing to not use the freshly introduced constants.
> That being said I agree it would make the code hard to read, so you can
> leave it as is.

Sorry, I forgot it.
How about to define:
#define LM90_STATUS_MASK 0x7f
#define MAX6696_STATUS2 0xfe

Or since Guenter is for vacation, I can just leave it as is, and wait
him back to talk about below issue.

> 
> Unrelated to this patch, but Guenter, I am worried about the MAX6696
> handling here. I realize that I am the one who accepted your code, but
> now it looks wrong. Specifically:
> * We check for (status2 & 0xfe) i.e. 7 alarm bits, but the code below
>   only reports 2 alarms bits. So if any of the 5 other alarm bits in
>   STATUS2 are, we may return true (chip is tripped) but not print the
>   cause.
> * At least bits 1 and 2 of STATUS 2 fit totally fine in the driver as
>   it currently exists, so I can't think of any reason for not handling
>   them. Why are we not? Ideally we should print a message for every
>   alarm bit so that we never return "true" without printing a message.
>   Even though OT2 limits aren't handled by the driver...
> * If you think this piece of code shouldn't deal with OT/THERM limits
>   because they do not trigger an SMBus alarm, this can be discussed,
>   but all chips should be handled the same in this respect then.
> * Why in the first place is max6696's data->alert_alarms set to 0x187c
>   and not 0x1c7c? Including 1OPEN but not 2OPEN makes no sense.
> 
>> +
>> +	if (status & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH | LM90_STATUS_LTHRM))
>> +		dev_warn(&client->dev,
>> +			 "temp%d out of range, please check!\n", 1);
>> +	if (status & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH | LM90_STATUS_RTHRM))
>> +		dev_warn(&client->dev,
>> +			 "temp%d out of range, please check!\n", 2);
>> +	if (status & LM90_STATUS_OPEN)
>> +		dev_warn(&client->dev,
>> +			 "temp%d diode open, please check!\n", 2);
>> +
>> +	if (status2 & (MAX6696_STATUS2_RLOW | MAX6696_STATUS2_RHIGH))
>> +		dev_warn(&client->dev,
>> +			 "temp%d out of range, please check!\n", 3);
>> +
>> +	return true;
>> +}
>> +
>>  static int lm90_probe(struct i2c_client *client,
>>  		      const struct i2c_device_id *id)
>>  {
>> @@ -1515,36 +1558,19 @@ static int lm90_remove(struct i2c_client *client)
>>  
>>  static void lm90_alert(struct i2c_client *client, unsigned int flag)
>>  {
>> -	struct lm90_data *data = i2c_get_clientdata(client);
>> -	u8 config, alarms, alarms2 = 0;
>> -
>> -	lm90_read_reg(client, LM90_REG_R_STATUS, &alarms);
>> -
>> -	if (data->kind = max6696)
>> -		lm90_read_reg(client, MAX6696_REG_R_STATUS2, &alarms2);
>> -
>> -	if ((alarms & 0x7f) = 0 && (alarms2 & 0xfe) = 0) {
>> +	if (!lm90_is_tripped(client)) {
> 
> You could swap the success and failure cases to avoid this negation.

Yes, I will change it.

> 
>>  		dev_info(&client->dev, "Everything OK\n");
>>  	} else {
>> -		if (alarms & 0x61)
>> -			dev_warn(&client->dev,
>> -				 "temp%d out of range, please check!\n", 1);
>> -		if (alarms & 0x1a)
>> -			dev_warn(&client->dev,
>> -				 "temp%d out of range, please check!\n", 2);
>> -		if (alarms & 0x04)
>> -			dev_warn(&client->dev,
>> -				 "temp%d diode open, please check!\n", 2);
>> -
>> -		if (alarms2 & 0x18)
>> -			dev_warn(&client->dev,
>> -				 "temp%d out of range, please check!\n", 3);
>> -
>>  		/*
>>  		 * Disable ALERT# output, because these chips don't implement
>>  		 * SMBus alert correctly; they should only hold the alert line
>>  		 * low briefly.
>>  		 */
>> +		struct lm90_data *data = i2c_get_clientdata(client);
>> +		u8 config, alarms;
>> +
>> +		lm90_read_reg(client, LM90_REG_R_STATUS, &alarms);
> 
> You end up reading LM90_REG_R_STATUS, which is not OK. This register
> contains self-clearing bits, so there is no guarantee that the second
> read will return the same value as the first read. You'll have to come
> up with a different approach that reads LM90_REG_R_STATUS only once.

Oh, yes, this is a problem, I didn't noticed it.
How about to use this:
bool lm90_alarms_tripped(*client, *status);
bool lm90_alarms2_tripped(*client, *status2);
So we can read the status only once and pass it.

> 
>> +
>>  		if ((data->flags & LM90_HAVE_BROKEN_ALERT)
>>  		 && (alarms & data->alert_alarms)) {
>>  			dev_dbg(&client->dev, "Disabling ALERT#\n");
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
