From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Apr 2015 14:10:42 +0000
Subject: Re: [lm-sensors] [PATCH 06/15] hwmon: (it87) Add support for IT8620E
Message-Id: <551BFC62.30301@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427697235-23566-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1427697235-23566-7-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 04/01/2015 07:03 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sun, 29 Mar 2015 23:33:46 -0700, Guenter Roeck wrote:
>> IT8620E is mostly compatible to IT7828F. Add generic support for it.
>>
>> IT8620E supports up to 6 fan tachometers and 6 pwm controls.
>> Support for the 6th tachometer and for the additional pwm controls
>> are addded in separate patches.
>
> Any plan to add support for the additional voltage/temperature inputs?
> Pins 1, 2 and 3, registers 0x77, 0x2C-0x2E. Note that "VIN7" is used in
> a confusing way in the datasheet, as it designates both the old
> (internal) in7 and the new function of pin 1 :(
>
Hah, there had to be something I missed. Let me look into it.

>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   Documentation/hwmon/it87 | 13 ++++++++++---
>>   drivers/hwmon/Kconfig    |  2 +-
>>   drivers/hwmon/it87.c     | 42 +++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 52 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
>> index 64ea41f017c1..b5c0eed22c15 100644
>> --- a/Documentation/hwmon/it87
>> +++ b/Documentation/hwmon/it87
>> @@ -6,6 +6,10 @@ Supported chips:
>>       Prefix: 'it8603'
>>       Addresses scanned: from Super I/O config space (8 I/O ports)
>>       Datasheet: Not publicly available
>> +  * IT8620E
>> +    Prefix: 'it8620'
>> +    Addresses scanned: from Super I/O config space (8 I/O ports)
>> +    Datasheet: Not publicly available
>>     * IT8705F
>>       Prefix: 'it87'
>>       Addresses scanned: from Super I/O config space (8 I/O ports)
>> @@ -106,7 +110,7 @@ motherboard models.
>>   Description
>>   -----------
>>
>> -This driver implements support for the IT8603E, IT8623E, IT8705F,
>> +This driver implements support for the IT8603E, IT8620E, IT8623E, IT8705F,
>>   IT8712F, IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
>>   IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, IT8790E, and SiS950
>>   chips.
>> @@ -147,8 +151,11 @@ The IT8728F, IT8771E, and IT8772E are considered compatible with the IT8721F,
>>   until a datasheet becomes available (hopefully.)
>>
>>   The IT8603E/IT8623E is a custom design, hardware monitoring part is similar to
>> -IT8728F. It only supports 16-bit fan mode, the full speed mode of the
>> -fan is not supported (value 0 of pwmX_enable).
>> +IT8728F. It only supports three fans, 16-bit fan mode, and the full speed mode
>
> As mentioned before, I'd spell it "3 fans" for consistency.
>
Changed.

>> +of the fan is not supported (value 0 of pwmX_enable).
>> +
>> +The IT8620E is another custom design, hardware monitoring part is similar to
>> +IT8728F. It only supports 16-bit fan mode.
>>
>>   The IT8790E supports up to three fans. 16-bit fan mode is always enabled.
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 929d30e2047e..eb8424f5e4b4 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -601,7 +601,7 @@ config SENSORS_IT87
>>   	  If you say yes here you get support for ITE IT8705F, IT8712F,
>>   	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
>>   	  IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, IT8790E,
>> -	  IT8603E, and IT8623E sensor chips, and the SiS950 clone.
>> +	  IT8603E, IT8620E, and IT8623E sensor chips, and the SiS950 clone.
>>
>>   	  This driver can also be built as a module.  If so, the module
>>   	  will be called it87.
>> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
>> index 01a021172121..ee6d30960fce 100644
>> --- a/drivers/hwmon/it87.c
>> +++ b/drivers/hwmon/it87.c
>> @@ -11,6 +11,7 @@
>>    *  similar parts.  The other devices are supported by different drivers.
>>    *
>>    *  Supports: IT8603E  Super I/O chip w/LPC interface
>> + *            IT8620E  Super I/O chip w/LPC interface
>>    *            IT8623E  Super I/O chip w/LPC interface
>>    *            IT8705F  Super I/O chip w/LPC interface
>>    *            IT8712F  Super I/O chip w/LPC interface
>> @@ -69,7 +70,7 @@
>>   #define DRVNAME "it87"
>>
>>   enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771,
>> -	     it8772, it8781, it8782, it8783, it8786, it8790, it8603 };
>> +	     it8772, it8781, it8782, it8783, it8786, it8790, it8603, it8620 };
>>
>>   static unsigned short force_id;
>>   module_param(force_id, ushort, 0);
>> @@ -154,6 +155,7 @@ static inline void superio_exit(void)
>>   #define IT8783E_DEVID 0x8783
>>   #define IT8786E_DEVID 0x8786
>>   #define IT8603E_DEVID 0x8603
>> +#define IT8620E_DEVID 0x8620
>>   #define IT8623E_DEVID 0x8623
>>   #define IT8790E_DEVID 0x8790
>>   #define IT87_ACT_REG  0x30
>> @@ -375,6 +377,14 @@ static const struct it87_devices it87_devices[] = {
>>   		.peci_mask = 0x07,
>>   		.suffix = "E",
>>   	},
>> +	[it8620] = {
>> +		.name = "it8620",
>> +		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
>> +		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_FIVE_FANS
>> +		  | FEAT_IN7_INTERNAL,
>> +		.peci_mask = 0x07,
>> +		.suffix = "E",
>> +	},
>>   };
>>
>>   #define has_16bit_fans(data)	((data)->features & FEAT_16BIT_FANS)
>> @@ -1850,6 +1860,9 @@ static int __init it87_find(unsigned short *address,
>>   	case IT8623E_DEVID:
>>   		sio_data->type = it8603;
>>   		break;
>> +	case IT8620E_DEVID:
>> +		sio_data->type = it8620;
>> +		break;
>>   	case 0xffff:	/* No device at all */
>>   		goto exit;
>>   	default:
>> @@ -1985,6 +1998,33 @@ static int __init it87_find(unsigned short *address,
>>   		sio_data->internal |= (1 << 3); /* in9 is AVCC */
>>
>>   		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
>> +	} else if (sio_data->type = it8620) {
>> +		int reg;
>> +
>> +		superio_select(GPIO);
>> +
>> +		/* Check for fan4, fan5 */
>> +		reg = superio_inb(IT87_SIO_GPIO2_REG);
>> +		if (!(reg & (1 << 5)))
>> +			sio_data->skip_fan |= (1 << 3);
>> +		if (!(reg & (1 << 4)))
>> +			sio_data->skip_fan |= (1 << 4);
>> +
>> +		/* Check for pwm3, fan3 */
>> +		reg = superio_inb(IT87_SIO_GPIO3_REG);
>> +		if (reg & (1 << 6))
>> +			sio_data->skip_pwm |= (1 << 2);
>> +		if (reg & (1 << 7))
>> +			sio_data->skip_fan |= (1 << 2);
>> +
>> +		/* Check for pwm2, fan2 */
>> +		reg = superio_inb(IT87_SIO_GPIO5_REG);
>> +		if (reg & (1 << 1))
>> +			sio_data->skip_pwm |= (1 << 1);
>> +		if (reg & (1 << 2))
>> +			sio_data->skip_fan |= (1 << 1);
>> +
>> +		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
>>   	} else {
>>   		int reg;
>>   		bool uart6;
>
> After adding the definition of IT87_SIO_GPIO2_REG, looks good.
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
Thanks a lot!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
