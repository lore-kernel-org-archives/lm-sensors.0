From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 28 Mar 2009 21:50:16 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-add-fscsyl-v3.patch
Message-Id: <49CE9B98.9030405@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <49CCC1D5.6040804@redhat.com>
In-Reply-To: <49CCC1D5.6040804@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On 03/28/2009 02:09 PM, Jean Delvare wrote:
> On Sat, 28 Mar 2009 09:07:56 +0100, Hans de Goede wrote:
>> This patch adds support for the FSC Syleus IC to the fschmd driver.
>>
>> Many thanks to Fujitsu Siemens Computers for providing docs and a machine to
>> test the driver on.
>> (...)
>
> You forgot to update this part:
>

Good catch, thanks!

>> @@ -1126,7 +1225,7 @@ static int fschmd_remove(struct i2c_clie
>>   	if (data->hwmon_dev)
>>   		hwmon_device_unregister(data->hwmon_dev);
>>
>> -	for (i = 0; i<  ARRAY_SIZE(fschmd_attr); i++)
>> +	for (i = 0; i<  (FSCHMD_NO_VOLT_SENSORS[data->kind] + 1); i++)
>>   		device_remove_file(&client->dev,&fschmd_attr[i].dev_attr);
>>   	for (i = 0; i<  (FSCHMD_NO_TEMP_SENSORS[data->kind] * 4); i++)
>>   		device_remove_file(&client->dev,
>
> Didn't you try unloading the driver? I guess this would break.
>

I did unload it, and didn't see any problems.

> The rest looks OK. I'll fix it up myself.

Ok, thanks.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
