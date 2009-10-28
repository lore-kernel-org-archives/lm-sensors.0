From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 28 Oct 2009 10:40:57 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon-f71882fg: Add support for the
Message-Id: <4AE81FB9.6010003@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AE02F99.4060105@redhat.com>
In-Reply-To: <4AE02F99.4060105@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 10/28/2009 10:57 AM, Jean Delvare wrote:
> On Thu, 22 Oct 2009 12:10:33 +0200, Hans de Goede wrote:
>> hwmon-f71882fg: Add support for the f71889fg
>>
>> This adds support for the Fintek f71889fg to the f71882fg driver,
>> many thanks to Gerd v. Egidy for providing (remote) access to a
>> machine which such an ic.
>>
>> Note that this bit of the patch:
>> -	val = SENSORS_LIMIT(val, 0, 255);
>> +
>> +	if (data->type = f71889fg)
>> +		val = SENSORS_LIMIT(val, -128, 127);
>> +	else
>> +		val = SENSORS_LIMIT(val, 0, 127);
>>
>> Changes behaviour for already supported models, the new behaviour is correct
>> as the already supported models have bit 7 of the involved registers fixed at
>> 0, so the previous behaviour which allowed setting temp zone limits>  127
>> was not correct.
>
> I have comments on this one:
>
>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>> diff -up vanilla-2.6.32-rc5-git1/Documentation/hwmon/f71882fg.orig vanilla-2.6.32-rc5-git1/Documentation/hwmon/f71882fg
>> --- vanilla-2.6.32-rc5-git1/Documentation/hwmon/f71882fg.orig	2009-09-10 00:13:59.000000000 +0200
>> +++ vanilla-2.6.32-rc5-git1/Documentation/hwmon/f71882fg	2009-10-22 11:57:10.000000000 +0200
>> @@ -14,6 +14,10 @@ Supported chips:
>>       Prefix: 'f71882fg'
>>       Addresses scanned: none, address read from Super I/O config space
>>       Datasheet: Available from the Fintek website
>> +  * Fintek F71889FG
>> +    Prefix: 'f71889fg'
>> +    Addresses scanned: none, address read from Super I/O config space
>> +    Datasheet: Should become available on the Fintek website soon
>>     * Fintek F8000
>>       Prefix: 'f8000'
>>       Addresses scanned: none, address read from Super I/O config space
>> @@ -51,6 +55,12 @@ supported. The right one to use depends
>>   motherboard, so the driver assumes that the BIOS set the method
>>   properly.
>>
>> +Note that the lowest numbered temperature zone trip point corresponds to
>> +to the border between the highest and one but highest temperature zones, and
>> +vica versa. So the temperature zone trip points 1-4 (or 1-2) go from high temp
>> +to low temp! This is how things are implemented in the IC, and the driver
>> +mimicks this.
>> +
>>   There are 2 modes to specify the speed of the fan, PWM duty cycle (or DC
>>   voltage) mode, where 0-100% duty cycle (0-100% of 12V) is specified. And RPM
>>   mode where the actual RPM of the fan (as measured) is controlled and the speed
>> diff -up vanilla-2.6.32-rc5-git1/drivers/hwmon/Kconfig.orig vanilla-2.6.32-rc5-git1/drivers/hwmon/Kconfig
>> --- vanilla-2.6.32-rc5-git1/drivers/hwmon/Kconfig.orig	2009-10-22 11:05:28.000000000 +0200
>> +++ vanilla-2.6.32-rc5-git1/drivers/hwmon/Kconfig	2009-10-22 11:58:21.000000000 +0200
>> @@ -305,12 +305,12 @@ config SENSORS_F71805F
>>   	  will be called f71805f.
>>
>>   config SENSORS_F71882FG
>> -	tristate "Fintek F71858FG, F71862FG, F71882FG and F8000"
>> +	tristate "Fintek F71858FG, F71862FG, F71882FG, F71889FG and F8000"
>>   	depends on EXPERIMENTAL
>>   	help
>>   	  If you say yes here you get support for hardware monitoring
>> -	  features of the Fintek F71858FG, F71862FG/71863FG, F71882FG/F71883FG
>> -	  and F8000 Super-I/O chips.
>> +	  features of the Fintek F71858FG, F71862FG/71863FG, F71882FG/F71883FG,
>> +	  F71889FG and F8000 Super-I/O chips.
>>
>>   	  This driver can also be built as a module.  If so, the module
>>   	  will be called f71882fg.
>> diff -up vanilla-2.6.32-rc5-git1/drivers/hwmon/f71882fg.c.orig vanilla-2.6.32-rc5-git1/drivers/hwmon/f71882fg.c
>> --- vanilla-2.6.32-rc5-git1/drivers/hwmon/f71882fg.c.orig	2009-10-22 11:50:15.000000000 +0200
>> +++ vanilla-2.6.32-rc5-git1/drivers/hwmon/f71882fg.c	2009-10-22 11:50:32.000000000 +0200
>> @@ -48,6 +48,7 @@
>>   #define SIO_F71858_ID		0x0507  /* Chipset ID */
>>   #define SIO_F71862_ID		0x0601	/* Chipset ID */
>>   #define SIO_F71882_ID		0x0541	/* Chipset ID */
>> +#define SIO_F71889_ID		0x0723	/* Chipset ID */
>>   #define SIO_F8000_ID		0x0581	/* Chipset ID */
>>
>>   #define REGION_LENGTH		8
>> @@ -95,12 +96,13 @@ static unsigned short force_id;
>>   module_param(force_id, ushort, 0);
>>   MODULE_PARM_DESC(force_id, "Override the detected device ID");
>>
>> -enum chips { f71858fg, f71862fg, f71882fg, f8000 };
>> +enum chips { f71858fg, f71862fg, f71882fg, f71889fg, f8000 };
>>
>>   static const char *f71882fg_names[] = {
>>   	"f71858fg",
>>   	"f71862fg",
>>   	"f71882fg",
>> +	"f71889fg",
>>   	"f8000",
>>   };
>>
>> @@ -155,7 +157,7 @@ struct f71882fg_data {
>>   	u8	pwm_auto_point_hyst[2];
>>   	u8	pwm_auto_point_mapping[4];
>>   	u8	pwm_auto_point_pwm[4][5];
>> -	u8	pwm_auto_point_temp[4][4];
>> +	s8	pwm_auto_point_temp[4][4];
>>   };
>>
>>   /* Sysfs in */
>> @@ -945,7 +947,7 @@ static struct f71882fg_data *f71882fg_up
>>   	/* Update once every 60 seconds */
>>   	if ( time_after(jiffies, data->last_limits + 60 * HZ ) ||
>>   			!data->valid) {
>> -		if (data->type = f71882fg) {
>> +		if (data->type = f71882fg || data->type = f71889fg) {
>>   			data->in1_max >>   				f71882fg_read8(data, F71882FG_REG_IN1_HIGH);
>>   			data->in_beep >> @@ -967,7 +969,8 @@ static struct f71882fg_data *f71882fg_up
>>   						F71882FG_REG_TEMP_HYST(1));
>>   		}
>>
>> -		if (data->type = f71862fg || data->type = f71882fg) {
>> +		if (data->type = f71862fg || data->type = f71882fg ||
>> +		    data->type = f71889fg) {
>>   			data->fan_beep = f71882fg_read8(data,
>>   						F71882FG_REG_FAN_BEEP);
>>   			data->temp_beep = f71882fg_read8(data,
>> @@ -977,15 +980,39 @@ static struct f71882fg_data *f71882fg_up
>>   			data->temp_type[2] = (reg&  0x04) ? 2 : 4;
>>   			data->temp_type[3] = (reg&  0x08) ? 2 : 4;
>>   		}
>> -		reg2 = f71882fg_read8(data, F71882FG_REG_PECI);
>> -		if ((reg2&  0x03) = 0x01)
>> -			data->temp_type[1] = 6 /* PECI */;
>> -		else if ((reg2&  0x03) = 0x02)
>> -			data->temp_type[1] = 5 /* AMDSI */;
>> -		else if (data->type = f71862fg || data->type = f71882fg)
>> -			data->temp_type[1] = (reg&  0x02) ? 2 : 4;
>> -		else
>> -			data->temp_type[1] = 2; /* Only supports BJT */
>> +		/* Determine temp index 1 sensor type */
>> +		if (data->type = f71889fg) {
>> +			reg2 = f71882fg_read8(data, F71882FG_REG_START);
>> +			switch ((reg2&  0x60)>>  5) {
>> +			case 0x00:
>> +				data->temp_type[1] = (reg&  0x02) ? 2 : 4;
>> +				break;
>> +			case 0x01:
>> +				data->temp_type[1] = 5 /* AMDSI */;
>> +				break;
>> +			case 0x02:
>> +				reg = f71882fg_read8(data, F71882FG_REG_PECI);
>> +				if (reg&  0x10)
>> +					data->temp_type[1] = 7 /* SST */;
>> +				else
>> +					data->temp_type[1] = 6 /* PECI */;
>
> I don't like this coding style (comment inside code).
>


I agree, this was copy pasted from the existing code (the else block), I
will fix this in the next iteration.

>> +				break;
>> +			case 0x03:
>> +				data->temp_type[1] = 8 /* Intel Ibex */;
>> +				break;
>> +			}
>
> Types 7 and 8 are not listed in Documentation/hwmon/sysfs-interface,
> and not supported by "sensors". That's not OK. Sensor types must be
> standardized before use, not the other way around.
>

You are right, sorry I was planning on doing a separate patch updating
sysfs-interface, but I forgot.

> I am also very skeptical about the latter type. The Intel Ibex is a
> chipset, as far as I know. It's not a sensor type. tempN_type is
> supposed to describe the type of the sensor, not its location. This
> certainly needs to be investigated and discussed.
>

Ok lets discuss it then :)

First of all the new type 7, SST, is not really a sensor type,
as much as it is a bus type, like PECI and AMDSI it is a digital
serial bus used to communicate with sensors, SST actually seems quite
interesting, see for example:
http://www.powerdesignindia.co.in/STATIC/PDF/200608/PDIOL_2006AUG07_PTEST_PMNG_TA_01.pdf?SOURCES=DOWNLOAD

Ok, reading the F71889FG datasheet again (and also checking the F71882FG datasheet),
this bit of the patch is clearly wrong, case 0x02 should simply always be PECI,
the SST enable bit enables a SST slave / client interface on the F71889FG, which
allows the ICH to read various sensor values from the F71889FG, so this bit does
not matter for the temperature reading done by the F71889FG, my bad.

As for case 0x03, the Ibex case, the datasheet calls this "Intel PCH/smbus"
in the register description, but in the pin description it uses:

43 Clock output for INTEL PCH (IBex Peak) interface.
44 INTEL PCH (IBex Peak) data interface pin.

And in several other places there are more references to "IBex Peak", this seems
to be a new Intel replacement for PECI, which looks a lot like AMDSI / smbus and
which can be used to read both the chipset and the cpu temperature from the cpu
resp. chipset.

We could also use type 6 for this, changing the meaning of 6 from Intel PECI,
to "Intel specific digital serial bus" or shorter: "Intel PECI / Ibex", where
Ibex can be replaced by the protocol name if we ever find the official name
for the protocol. Or we could introduce a type 7 for this, but I think that
using 6 for this makes more sense, esp. since I've not seen this actually being
used yet.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
