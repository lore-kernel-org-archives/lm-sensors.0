From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Feb 2013 12:28:28 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (ltc2978) Add support for LTC2974 and LTC3883
Message-Id: <20130219132828.2c498dc4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360079815-15187-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1360079815-15187-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue,  5 Feb 2013 07:56:55 -0800, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/ltc2978   |   26 +++++---
>  drivers/hwmon/pmbus/Kconfig   |    4 +-
>  drivers/hwmon/pmbus/ltc2978.c |  136 +++++++++++++++++++++++++++++++++++++----
>  3 files changed, 143 insertions(+), 23 deletions(-)

Not being familiar with pmbus, my review may be incomplete, but I did
my best.

> 
> diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
> index 8a5e791..8db0b61 100644
> --- a/Documentation/hwmon/ltc2978
> +++ b/Documentation/hwmon/ltc2978
> @@ -2,6 +2,10 @@ Kernel driver ltc2978
>  ==========>  
>  Supported chips:
> +  * Linear Technology LTC2974
> +    Prefix: 'ltc2974'
> +    Addresses scanned: -
> +    Datasheet: http://cds.linear.com/docs/en/datasheet/2974f.pdf
>    * Linear Technology LTC2978
>      Prefix: 'ltc2978'
>      Addresses scanned: -
> @@ -10,6 +14,10 @@ Supported chips:
>      Prefix: 'ltc3880'
>      Addresses scanned: -
>      Datasheet: http://cds.linear.com/docs/en/datasheet/3880fa.pdf
> +  * Linear Technology LTC3883
> +    Prefix: 'ltc3883'
> +    Addresses scanned: -
> +    Datasheet: http://cds.linear.com/docs/en/datasheet/3883f.pdf
>  
>  Author: Guenter Roeck <guenter.roeck@ericsson.com>

You might want to update this e-mail address. This might be better done
as a tree-wide patch though.

>  
> @@ -17,9 +25,9 @@ Author: Guenter Roeck <guenter.roeck@ericsson.com>
>  Description
>  -----------
>  
> -The LTC2978 is an octal power supply monitor, supervisor, sequencer and
> -margin controller. The LTC3880 is a dual, PolyPhase DC/DC synchronous
> -step-down switching regulator controller.
> +LTC2974 is a quad digital power supply manager. LTC2978 is an octal power supply
> +monitor. LTC3880 is a dual output poly-phase step-down DC/DC controller. LTC3883
> +is a single phase step-down DC/DC controller.
>  
>  
>  Usage Notes
> @@ -48,7 +56,7 @@ in1_min_alarm		Input voltage low alarm.
>  in1_max_alarm		Input voltage high alarm.
>  in1_lcrit_alarm		Input voltage critical low alarm.
>  in1_crit_alarm		Input voltage critical high alarm.
> -in1_lowest		Lowest input voltage. LTC2978 only.
> +in1_lowest		Lowest input voltage. LTC2974 and LTC2978 only.
>  in1_highest		Highest input voltage.
>  in1_reset_history	Reset history. Writing into this attribute will reset
>  			history for all attributes.
> @@ -63,7 +71,7 @@ in[2-9]_min_alarm	Output voltage low alarm.

in[2-9]_label says "Channels 3 to 9 on LTC2978 only" but I suppose
channels 3 to 5 are also available on LTC2974?

>  in[2-9]_max_alarm	Output voltage high alarm.
>  in[2-9]_lcrit_alarm	Output voltage critical low alarm.
>  in[2-9]_crit_alarm	Output voltage critical high alarm.
> -in[2-9]_lowest		Lowest output voltage. LTC2978 only.
> +in[2-9]_lowest		Lowest output voltage. LTC2974 and LTC2978 only.
>  in[2-9]_highest		Lowest output voltage.
>  in[2-9]_reset_history	Reset history. Writing into this attribute will reset
>  			history for all attributes.
> @@ -82,20 +90,20 @@ temp[1-3]_min_alarm	Chip temperature low alarm.

temp[1-3]_input has a detailed description of the input mappings for
the LTC2978 and LTC3880, it would seem desirable to have a similar
description for the two new chips LTC2974 and LTC3883.

>  temp[1-3]_max_alarm	Chip temperature high alarm.
>  temp[1-3]_lcrit_alarm	Chip temperature critical low alarm.
>  temp[1-3]_crit_alarm	Chip temperature critical high alarm.
> -temp[1-3]_lowest	Lowest measured temperature. LTC2978 only.
> +temp[1-3]_lowest	Lowest measured temperature. LTC2974 and LTC2978 only.
>  temp[1-3]_highest	Highest measured temperature.
>  temp[1-3]_reset_history	Reset history. Writing into this attribute will reset
>  			history for all attributes.
>  
> -power[1-2]_label	"pout[1-2]". LTC3880 only.
> +power[1-2]_label	"pout[1-2]". LTC2974, LTC3880, LTC3883 only.

I am under the impression that LTC2974 has pout[3-4] as well?

>  power[1-2]_input	Measured power.
>  
> -curr1_label		"iin". LTC3880 only.
> +curr1_label		"iin". LTC3880 and LTC3883 only.
>  curr1_input		Measured input current.
>  curr1_max		Maximum input current.
>  curr1_max_alarm		Input current high alarm.
>  
> -curr[2-3]_label		"iout[1-2]". LTC3880 only.
> +curr[2-3]_label		"iout[1-2]". LTC3880 and LTC3883 only.

What about LTC2974? It has PMBUS_HAVE_IOUT on all 4 pages, doesn't this
translate to curr[2-5]_* files? This would correlate with the size
increase of data->iout_min/max from 2 to 4 elements.

>  curr[2-3]_input		Measured input current.
>  curr[2-3]_max		Maximum input current.
>  curr[2-3]_crit		Critical input current.

> diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
> index 9652a2c..755ab35 100644
> --- a/drivers/hwmon/pmbus/ltc2978.c
> +++ b/drivers/hwmon/pmbus/ltc2978.c
> @@ -1,5 +1,5 @@
>  /*
> - * Hardware monitoring driver for LTC2978 and LTC3880
> + * Hardware monitoring driver for LTC2974, LTC2978, LTC3880, and LTC3883
>   *
>   * Copyright (c) 2011 Ericsson AB.

Feel free to add your name and copyright here, with the new year.

>   *
> @@ -26,28 +26,42 @@
>  #include <linux/i2c.h>
>  #include "pmbus.h"
>  
> -enum chips { ltc2978, ltc3880 };
> +enum chips { ltc2974, ltc2978, ltc3880, ltc3883 };
>  
> -/* LTC2978 and LTC3880 */
> +/* Common for all chips */
>  #define LTC2978_MFR_VOUT_PEAK		0xdd
>  #define LTC2978_MFR_VIN_PEAK		0xde
>  #define LTC2978_MFR_TEMPERATURE_PEAK	0xdf
>  #define LTC2978_MFR_SPECIAL_ID		0xe7
>  
> -/* LTC2978 only */
> +/* LTC2974 and LTC2978 */
>  #define LTC2978_MFR_VOUT_MIN		0xfb
>  #define LTC2978_MFR_VIN_MIN		0xfc
>  #define LTC2978_MFR_TEMPERATURE_MIN	0xfd
>  
> -/* LTC3880 only */
> +/* LTC3880 and LTC3883 */
>  #define LTC3880_MFR_IOUT_PEAK		0xd7
>  #define LTC3880_MFR_CLEAR_PEAKS		0xe3
>  #define LTC3880_MFR_TEMPERATURE2_PEAK	0xf4
>  
> +/* LTC3883 only */
> +#define LTC3883_MFR_IIN_PEAK		0xe1
> +
> +/* LTC2974 only */
> +#define LTC2974_MFR_IOUT_PEAK		0xd7
> +#define LTC2974_MFR_IOUT_MIN		0xd8

As you have two sub-families (LTC2974/8 vs. LTC3880/3) it would be
clearer to group "LTC2974 only" register definitions with "LTC2974 and
LTC2978" register definitions (i.e. move this one block two blocks up.) 

> +
> +#define LTC2974_ID			0x0212
>  #define LTC2978_ID_REV1			0x0121
>  #define LTC2978_ID_REV2			0x0122
>  #define LTC3880_ID			0x4000
>  #define LTC3880_ID_MASK			0xff00
> +#define LTC3883_ID			0x4300
> +
> +#define LTC2974_NUM_PAGES		4
> +#define LTC2978_NUM_PAGES		8
> +#define LTC3880_NUM_PAGES		2
> +#define LTC3883_NUM_PAGES		1
>  
>  /*
>   * LTC2978 clears peak data whenever the CLEAR_FAULTS command is executed, which
> @@ -61,7 +75,9 @@ struct ltc2978_data {
>  	int vin_min, vin_max;
>  	int temp_min, temp_max;
>  	int vout_min[8], vout_max[8];
> -	int iout_max[2];
> +	int iin_max;
> +	int iout_max[4];
> +	int iout_min[4];

Nitpicking:

	int iout_min[4], iout_max[4];

would match the existing coding style.

>  	int temp2_max[2];
>  	struct pmbus_driver_info info;
>  };
> @@ -184,6 +200,38 @@ static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
>  	return ret;
>  }
>  
> +static int ltc2974_read_word_data(struct i2c_client *client, int page, int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct ltc2978_data *data = to_ltc2978_data(info);
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VIRT_READ_IOUT_MAX:
> +		ret = pmbus_read_word_data(client, page, LTC2974_MFR_IOUT_PEAK);
> +		if (ret >= 0) {
> +			if (lin11_to_val(ret)
> +			    > lin11_to_val(data->iout_max[page]))
> +				data->iout_max[page] = ret;
> +			ret = data->iout_max[page];
> +		}
> +		break;
> +	case PMBUS_VIRT_READ_IOUT_MIN:
> +		ret = pmbus_read_word_data(client, page, LTC2974_MFR_IOUT_MIN);
> +		if (ret >= 0) {
> +			if (lin11_to_val(ret)
> +			    < lin11_to_val(data->iout_min[page]))
> +				data->iout_min[page] = ret;
> +			ret = data->iout_min[page];
> +		}
> +		break;
> +	default:
> +		ret = ltc2978_read_word_data(client, page, reg);
> +		break;
> +	}
> +	return ret;
> +}
> +
>  static int ltc3880_read_word_data(struct i2c_client *client, int page, int reg)
>  {
>  	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> @@ -226,6 +274,29 @@ static int ltc3880_read_word_data(struct i2c_client *client, int page, int reg)
>  	return ret;
>  }
>  
> +static int ltc3883_read_word_data(struct i2c_client *client, int page, int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct ltc2978_data *data = to_ltc2978_data(info);
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VIRT_READ_IIN_MAX:
> +		ret = pmbus_read_word_data(client, page, LTC3883_MFR_IIN_PEAK);
> +		if (ret >= 0) {
> +			if (lin11_to_val(ret)
> +			    > lin11_to_val(data->iin_max))
> +				data->iin_max = ret;
> +			ret = data->iin_max;
> +		}
> +		break;
> +	default:
> +		ret = ltc3880_read_word_data(client, page, reg);
> +		break;
> +	}
> +	return ret;
> +}
> +
>  static int ltc2978_clear_peaks(struct i2c_client *client, int page,
>  			       enum chips id)
>  {

In function ltc2978_clear_peaks() the test on "id" looks wrong:

	if (id = ltc2978)
		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
	else
		ret = pmbus_write_byte(client, 0, LTC3880_MFR_CLEAR_PEAKS);

LTC2974 doesn't have LTC3880_MFR_CLEAR_PEAKS, the address is used for a
different register, still you'll write to this register for that chip.
No good.

In order to avoid this from happening again when adding support for new
chips, I'd suggest reverting the test to:

	if (id = ltc3880 || id = ltc3883)
		ret = pmbus_write_byte(client, 0, LTC3880_MFR_CLEAR_PEAKS);
	else
		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);


> @@ -247,8 +318,17 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
>  	int ret;
>  
>  	switch (reg) {
> +	case PMBUS_VIRT_RESET_IIN_HISTORY:
> +		if (data->id != ltc3883) {
> +			ret = -ENODATA;
> +			break;
> +		}
> +		data->iin_max = 0xffff;

This initial value is inconsistent with the iout_max one below (both the
original one and the new one.) If I understand the L11 format
correctly, 0xffff corresponds to the closest negative value to 0 (-1 *
2^(-15)), right? If negative values are supported I'd expect you to put
the most negative value (largest in absolute value) possible here,
which would be 0x7c00 (exponent = 15, sign = 1, mantissa = 0.) If
negative values aren't supported then 0 would do?

> +		ret = ltc2978_clear_peaks(client, page, data->id);
> +		break;
>  	case PMBUS_VIRT_RESET_IOUT_HISTORY:
> -		data->iout_max[page] = 0x7fff;
> +		data->iout_min[page] = 0xffff;
> +		data->iout_max[page] = 0;

This change looks suspicious, can you explain it? It seems to be
unrelated to the support of new chips. If it is a bug fix, it should be
split to a separate patch.

I noticed that the driver has inconsistent initial values for iin_max,
iout_min and temp2_max, between the probe function and the history
reset code. In fact iin_max, iout_min and temp2_max have no explicit
initial value in the probe path, so they default to 0, while history
reset sets explicit values. This was the case for iout_max too before
the change above. This looks wrong.

Several L11-formatted initial values look wrong to me as well. I
suggest sorting this out first, both the consistency and the values
themselves, and only after this is done, adding support for the new
chips. As I understand it, for L11-formatted registers, min should be
set to 0x7bff and max should be set to 0x7c00.

>  		ret = ltc2978_clear_peaks(client, page, data->id);
>  		break;
>  	case PMBUS_VIRT_RESET_TEMP2_HISTORY:
> @@ -278,8 +358,10 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
>  }
>  
>  static const struct i2c_device_id ltc2978_id[] = {
> +	{"ltc2974", ltc2974},
>  	{"ltc2978", ltc2978},
>  	{"ltc3880", ltc3880},
> +	{"ltc3883", ltc3883},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc2978_id);
> @@ -304,10 +386,14 @@ static int ltc2978_probe(struct i2c_client *client,
>  	if (chip_id < 0)
>  		return chip_id;
>  
> -	if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2) {
> +	if (chip_id = LTC2974_ID) {
> +		data->id = ltc2974;
> +	} else if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2) {
>  		data->id = ltc2978;
>  	} else if ((chip_id & LTC3880_ID_MASK) = LTC3880_ID) {
>  		data->id = ltc3880;
> +	} else if ((chip_id & LTC3880_ID_MASK) = LTC3883_ID) {
> +		data->id = ltc3883;
>  	} else {
>  		dev_err(&client->dev, "Unsupported chip ID 0x%x\n", chip_id);
>  		return -ENODEV;
> @@ -327,13 +413,29 @@ static int ltc2978_probe(struct i2c_client *client,
>  	data->temp_max = 0x7fff;
>  
>  	switch (id->driver_data) {
> +	case ltc2974:
> +		info->read_word_data = ltc2974_read_word_data;
> +		info->pages = LTC2974_NUM_PAGES;
> +		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IOUT

No PMBUS_HAVE_STATUS_IOUT here?

> +		  | PMBUS_HAVE_STATUS_INPUT
> +		  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +		  | PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP2
> +		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> +		for (i = 1; i < info->pages; i++) {
> +			info->func[i] = PMBUS_HAVE_VOUT
> +			  | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_POUT
> +			  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> +			  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
> +			data->vout_min[i] = 0xffff;
> +		}
> +		break;
>  	case ltc2978:
>  		info->read_word_data = ltc2978_read_word_data;
> -		info->pages = 8;
> +		info->pages = LTC2978_NUM_PAGES;
>  		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
>  		  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
>  		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> -		for (i = 1; i < 8; i++) {
> +		for (i = 1; i < info->pages; i++) {
>  			info->func[i] = PMBUS_HAVE_VOUT
>  			  | PMBUS_HAVE_STATUS_VOUT;
>  			data->vout_min[i] = 0xffff;
> @@ -341,7 +443,7 @@ static int ltc2978_probe(struct i2c_client *client,
>  		break;
>  	case ltc3880:
>  		info->read_word_data = ltc3880_read_word_data;
> -		info->pages = 2;
> +		info->pages = LTC3880_NUM_PAGES;
>  		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
>  		  | PMBUS_HAVE_STATUS_INPUT
>  		  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> @@ -354,6 +456,16 @@ static int ltc2978_probe(struct i2c_client *client,
>  		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  		data->vout_min[1] = 0xffff;
>  		break;
> +	case ltc3883:
> +		info->read_word_data = ltc3883_read_word_data;
> +		info->pages = LTC3883_NUM_PAGES;
> +		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
> +		  | PMBUS_HAVE_STATUS_INPUT
> +		  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> +		  | PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
> +		  | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
> +		break;
>  	default:
>  		return -ENODEV;
>  	}
> @@ -374,5 +486,5 @@ static struct i2c_driver ltc2978_driver = {
>  module_i2c_driver(ltc2978_driver);
>  
>  MODULE_AUTHOR("Guenter Roeck");
> -MODULE_DESCRIPTION("PMBus driver for LTC2978 and LTC3880");
> +MODULE_DESCRIPTION("PMBus driver for LTC2974, LTC2978, LTC3880, and LTC3883");
>  MODULE_LICENSE("GPL");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
