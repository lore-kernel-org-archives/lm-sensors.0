From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Mar 2015 21:32:39 +0000
Subject: Re: [lm-sensors] [PATCH 04/15] hwmon: (it87) Introduce feature flag to reflect internal in7 sensor
Message-Id: <5519C0F7.5070601@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427697235-23566-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1427697235-23566-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/30/2015 01:05 PM, Jean Delvare wrote:
> On Sun, 29 Mar 2015 23:33:44 -0700, Guenter Roeck wrote:
>> On some chips, in7 is always an internal voltage sensor. Introduce
>> feature flag to reflect this condition to simplify adding support
>> for new chips.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/it87.c | 25 +++++++++++++++----------
>>   1 file changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
>> index bdd6b33a3b25..2b41a598cee7 100644
>> --- a/drivers/hwmon/it87.c
>> +++ b/drivers/hwmon/it87.c
>> @@ -258,6 +258,7 @@ struct it87_devices {
>>   #define FEAT_FAN16_CONFIG	(1 << 7)	/* Need to enable 16-bit fans */
>>   #define FEAT_FIVE_FANS		(1 << 8)	/* Supports five fans */
>>   #define FEAT_VID		(1 << 9)	/* Set if chip supports VID */
>> +#define FEAT_IN7_INTERNAL	(1 << 10)	/* Set if in7 is internal */
>>
>>   static const struct it87_devices it87_devices[] = {
>>   	[it87] = {
>> @@ -295,7 +296,7 @@ static const struct it87_devices it87_devices[] = {
>>   		.name = "it8721",
>>   		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>>   		  | FEAT_TEMP_OFFSET | FEAT_TEMP_OLD_PECI | FEAT_TEMP_PECI
>> -		  | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
>> +		  | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS | FEAT_IN7_INTERNAL,
>>   		.peci_mask = 0x05,
>>   		.old_peci_mask = 0x02,	/* Actually reports PCH */
>>   		.suffix = "F",
>> @@ -303,14 +304,15 @@ static const struct it87_devices it87_devices[] = {
>>   	[it8728] = {
>>   		.name = "it8728",
>>   		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>> -		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_FIVE_FANS,
>> +		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_FIVE_FANS
>> +		  | FEAT_IN7_INTERNAL,
>>   		.peci_mask = 0x07,
>>   		.suffix = "F",
>>   	},
>>   	[it8771] = {
>>   		.name = "it8771",
>>   		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>> -		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
>> +		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_IN7_INTERNAL,
>>   				/* PECI: guesswork */
>>   				/* 12mV ADC (OHM) */
>>   				/* 16 bit fans (OHM) */
>> @@ -321,7 +323,7 @@ static const struct it87_devices it87_devices[] = {
>>   	[it8772] = {
>>   		.name = "it8772",
>>   		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>> -		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
>> +		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_IN7_INTERNAL,
>>   				/* PECI (coreboot) */
>>   				/* 12mV ADC (HWSensors4, OHM) */
>>   				/* 16 bit fans (HWSensors4, OHM) */
>> @@ -353,14 +355,14 @@ static const struct it87_devices it87_devices[] = {
>>   	[it8786] = {
>>   		.name = "it8786",
>>   		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>> -		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
>> +		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_IN7_INTERNAL,
>>   		.peci_mask = 0x07,
>>   		.suffix = "E",
>>   	},
>>   	[it8603] = {
>>   		.name = "it8603",
>>   		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>> -		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
>> +		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_IN7_INTERNAL,
>>   		.peci_mask = 0x07,
>>   		.suffix = "E",
>>   	},
>> @@ -379,6 +381,7 @@ static const struct it87_devices it87_devices[] = {
>>   #define has_fan16_config(data)	((data)->features & FEAT_FAN16_CONFIG)
>>   #define has_five_fans(data)	((data)->features & FEAT_FIVE_FANS)
>>   #define has_vid(data)		((data)->features & FEAT_VID)
>> +#define has_in7_internal(data)	((data)->features & FEAT_IN7_INTERNAL)
>>
>>   struct it87_sio_data {
>>   	enum chips type;
>> @@ -1862,6 +1865,11 @@ static int __init it87_find(unsigned short *address,
>>
>>   	/* in8 (Vbat) is always internal */
>>   	sio_data->internal = (1 << 2);
>> +
>> +	/* in7 (VSB or VCCH5V) is always internal on some chips */
>> +	if (it87_devices[sio_data->type].features & FEAT_IN7_INTERNAL)
>> +		sio_data->internal |= (1 << 1);
>> +
>>   	/* Only the IT8603E has in9 */
>>   	if (sio_data->type != it8603)
>>   		sio_data->skip_in |= (1 << 9);
>
> Nitpicking, but wouldn't it make more sense to deal with in7 first,
> then in8, then in9?
>

Agreed, and done.

>> @@ -1962,7 +1970,6 @@ static int __init it87_find(unsigned short *address,
>>   		sio_data->skip_in |= (1 << 5); /* No VIN5 */
>>   		sio_data->skip_in |= (1 << 6); /* No VIN6 */
>>
>> -		sio_data->internal |= (1 << 1); /* in7 is VSB */
>>   		sio_data->internal |= (1 << 3); /* in9 is AVCC */
>>
>>   		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
>> @@ -2023,9 +2030,7 @@ static int __init it87_find(unsigned short *address,
>>   		}
>>   		if (reg & (1 << 0))
>>   			sio_data->internal |= (1 << 0);
>> -		if ((reg & (1 << 1)) || sio_data->type = it8721 ||
>> -		    sio_data->type = it8728 || sio_data->type = it8771 ||
>> -		    sio_data->type = it8772 || sio_data->type = it8786)
>> +		if (reg & (1 << 1))
>>   			sio_data->internal |= (1 << 1);
>>
>>   		/*
>
> Other than that, no objection.
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
Thanks again!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
