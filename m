From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 04 May 2011 17:55:42 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon/sch5627: Trigger Vbat
Message-Id: <4DC1931E.5010409@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110504174240.1491e1d4@endymion.delvare>
In-Reply-To: <20110504174240.1491e1d4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 05/04/2011 05:42 PM, Jean Delvare wrote:
> Hi Hans,
>
> On Thu, 21 Apr 2011 15:35:19 +0200, Hans de Goede wrote:
>> The sch5627 needs to be explicitly told to start an adc conversion
>> for Vbat, once in a while. Without this Vbat may read 0, and will never
>> get updated.
>>
>> Signed-off-By: Hans de Goede<hdegoede@redhat.com>
>> ---
>>   drivers/hwmon/sch5627.c |   17 ++++++++++++++++-
>>   1 files changed, 16 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
>> index 09a47bf..e23ea34 100644
>> --- a/drivers/hwmon/sch5627.c
>> +++ b/drivers/hwmon/sch5627.c
>> @@ -94,6 +94,7 @@ static const char * const SCH5627_IN_LABELS[SCH5627_NO_IN] = {
>>   struct sch5627_data {
>>   	unsigned short addr;
>>   	struct device *hwmon_dev;
>> +	u8 control;
>>   	u8 temp_max[SCH5627_NO_TEMPS];
>>   	u8 temp_crit[SCH5627_NO_TEMPS];
>>   	u16 fan_min[SCH5627_NO_FANS];
>> @@ -101,6 +102,7 @@ struct sch5627_data {
>>   	struct mutex update_lock;
>>   	char valid;			/* !=0 if following fields are valid */
>>   	unsigned long last_updated;	/* In jiffies */
>> +	unsigned long last_battery;	/* In jiffies */
>>   	u16 temp[SCH5627_NO_TEMPS];
>>   	u16 fan[SCH5627_NO_FANS];
>>   	u16 in[SCH5627_NO_IN];
>> @@ -327,6 +329,14 @@ static struct sch5627_data *sch5627_update_device(struct device *dev)
>>   		}
>>
>>   		data->last_updated = jiffies;
>> +	}
>> +
>> +	/* Trigger a Vbat voltage measurement every minute */
>
> I would even have gone for longer than this, at least 5 minutes if not
> even 1 hour. AFAIK monitoring drains the battery's power, and the
> battery isn't used during run-time so monitoring it in real-time is not
> critical.
>

Ok, will make it 5 minutes in the next revision.

>> +	if (time_after(jiffies, data->last_battery + 60 * HZ) ||
>> +	    !data->valid) {
>> +		sch5627_write_virtual_reg(data, SCH5627_REG_CTRL,
>> +					  data->control | 0x10);
>> +		data->last_battery = jiffies;
>>   		data->valid = 1;
>>   	}
>
> This is confusing. What is data->valid supposed to represent now?
>
> I don't think you should mess up with data->valid here. You already
> enabled one sampling of Vbat during probe, so you should have set
> data->last_battery when you did, and only use data->last_battery after
> that.
>
> Furthermore, wouldn't it make more sense to do that _before_ reading
> the samples from the chip? With some luck it may let you get a fresh
> reading for Vbat, instead of possibly hours old one. I understand there
> is no guarantee, but I see no reason to not at least take our chance.
>

Ah, I should have read better before saying I had a question about this
in my previous mail. I'll take over your suggestions and do a new
version of this patch set tomorrow.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
