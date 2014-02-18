From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 18 Feb 2014 15:41:16 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (lm90) Create optional attributes with sysfs_create_group
Message-Id: <53037F1C.7080601@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392513973-25148-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392513973-25148-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/18/2014 06:55 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sat, 15 Feb 2014 17:26:33 -0800, Guenter Roeck wrote:
>> With the new hwmon API, all attributes have to be created as groups.
>> Use sysfs_create_group and sysfs_remove_group instead of device_create_file
>> and device_remove_file to prepare for the new API.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/lm90.c |   27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>> index 701e952..c3bb771 100644
>> --- a/drivers/hwmon/lm90.c
>> +++ b/drivers/hwmon/lm90.c
>> @@ -1057,6 +1057,15 @@ static const struct attribute_group lm90_group = {
>>   	.attrs = lm90_attributes,
>>   };
>>
>> +static struct attribute *lm90_temp2_offset_attrs[] = {
>
> Other groups in this driver use the _attributes suffix, please do the
> same for new groups for consistency.
>
>> +	&sensor_dev_attr_temp2_offset.dev_attr.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group lm90_temp2_offset_group = {
>> +	.attrs = lm90_temp2_offset_attrs,
>> +};
>> +
>>   /*
>>    * Additional attributes for devices with emergency sensors
>>    */
>> @@ -1174,6 +1183,15 @@ static ssize_t set_pec(struct device *dev, struct device_attribute *dummy,
>>
>>   static DEVICE_ATTR(pec, S_IWUSR | S_IRUGO, show_pec, set_pec);
>>
>> +static struct attribute *lm90_pec_attrs[] = {
>> +	&dev_attr_pec.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group lm90_pec_group = {
>> +	.attrs = lm90_pec_attrs,
>> +};
>
> I am worried about this. Later in this patch set you'll move the "pec"
> attribute from the i2c device to the hwmon class device. However this
> attribute is very SMBus-specific, and has nothing to do with hwmon. I
> don't think it makes sense to move this attribute, it should stay with
> the i2c device. Non-hwmon i2c device drivers could implement it too.
>
It is specifically mentioned in Documentation/hwmon/lm90, though.
If I separate it to the i2c device, I'll have to come up with some text
explaining where to find the attribute. Is that ok ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
