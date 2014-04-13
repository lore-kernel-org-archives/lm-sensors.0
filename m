From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 13 Apr 2014 15:38:36 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (lm77) Rearrange code to no longer require forward declarations
Message-Id: <534AAF7C.9020208@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397322118-4275-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397322118-4275-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/13/2014 03:07 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sat, 12 Apr 2014 10:01:55 -0700, Guenter Roeck wrote:
>> Forward declarations are easy to avoid and unnecessary.
>> Rearrange code to avoid it.
>>
>> No functional change.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/lm77.c |  173 +++++++++++++++++++++++---------------------------
>>   1 file changed, 81 insertions(+), 92 deletions(-)
>> (...)
>
> Looks good, just one suggestion:
>
>> diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
>> index 502771c..9e60eea 100644
>> --- a/drivers/hwmon/lm77.c
>> +++ b/drivers/hwmon/lm77.c
>> (...)
>> @@ -266,6 +292,14 @@ static const struct attribute_group lm77_group = {
>>   	.attrs = lm77_attributes,
>>   };
>>
>> +static void lm77_init_client(struct i2c_client *client)
>> +{
>> +	/* Initialize the LM77 chip - turn off shutdown mode */
>> +	int conf = lm77_read_value(client, LM77_REG_CONF);
>> +	if (conf & 1)
>> +		lm77_write_value(client, LM77_REG_CONF, conf & 0xfe);
>> +}
>
> IMHO this would rather go before lm77_probe() than lm77_detect().
> Having _init before _detect is almost an invitation to initialize the
> chip in the _detect function, which would be wrong.
>
Ok, makes sense. I'll move it.

Guenter

>> +
>>   /* Return 0 if detection is successful, -ENODEV otherwise */
>>   static int lm77_detect(struct i2c_client *client, struct i2c_board_info *info)
>>   {
>
> Acked-by: Jean Delvare <jdelvare@suse.de>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
