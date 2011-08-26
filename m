From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 26 Aug 2011 13:52:38 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (pmbus/adm1275) Add support for
Message-Id: <20110826135238.GB30002@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314324755-18514-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1314324755-18514-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Aug 26, 2011 at 08:29:53AM -0400, Jean Delvare wrote:
> On Thu, 25 Aug 2011 19:12:35 -0700, Guenter Roeck wrote:
> > ADM1276 is mostly compatible to ADM1275, with added support for input power
> > measurement. Add support for it to the ADM1275 driver.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  Documentation/hwmon/adm1275   |   32 ++++++++++++----------
> >  drivers/hwmon/pmbus/Kconfig   |    5 ++-
> >  drivers/hwmon/pmbus/adm1275.c |   58 ++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 73 insertions(+), 22 deletions(-)
> 
> Looks overall sane, except for one thing:
> 
> > 
> > diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
> > index c438c98..ab70d96 100644
> > --- a/Documentation/hwmon/adm1275
> > +++ b/Documentation/hwmon/adm1275
> > @@ -6,6 +6,10 @@ Supported chips:
> >      Prefix: 'adm1275'
> >      Addresses scanned: -
> >      Datasheet: www.analog.com/static/imported-files/data_sheets/ADM1275.pdf
> > +  * Analog Devices ADM1276
> > +    Prefix: 'adm1276'
> > +    Addresses scanned: -
> > +    Datasheet: www.analog.com/static/imported-files/data_sheets/ADM1276.pdf
> >  
> >  Author: Guenter Roeck <guenter.roeck@ericsson.com>
> >  
> > @@ -13,13 +17,13 @@ Author: Guenter Roeck <guenter.roeck@ericsson.com>
> >  Description
> >  -----------
> >  
> > -This driver supports hardware montoring for Analog Devices ADM1275 Hot-Swap
> > -Controller and Digital Power Monitor.
> > +This driver supports hardware montoring for Analog Devices ADM1275 and ADM1276
> > +Hot-Swap Controller and Digital Power Monitor.
> >  
> > -The ADM1275 is a hot-swap controller that allows a circuit board to be removed
> > -from or inserted into a live backplane. It also features current and voltage
> > -readback via an integrated 12-bit analog-to-digital converter (ADC), accessed
> > -using a PMBus. interface.
> > +ADM1275 and ADM1276 are hot-swap controllers that allow a circuit board to be
> > +removed from or inserted into a live backplane. They also feature current and
> > +voltage readback via an integrated 12-bit analog-to-digital converter (ADC),
> > +accessed using a PMBus interface.
> >  
> >  The driver is a client driver to the core PMBus driver. Please see
> >  Documentation/hwmon/pmbus for details on PMBus client drivers.
> > @@ -48,18 +52,18 @@ attributes are write-only, all other attributes are read-only.
> >  
> >  in1_label		"vin1" or "vout1" depending on chip variant and
> >  			configuration.
> > -in1_input		Measured voltage. From READ_VOUT register.
> > -in1_min			Minumum Voltage. From VOUT_UV_WARN_LIMIT register.
> > -in1_max			Maximum voltage. From VOUT_OV_WARN_LIMIT register.
> > -in1_min_alarm		Voltage low alarm. From VOLTAGE_UV_WARNING status.
> > -in1_max_alarm		Voltage high alarm. From VOLTAGE_OV_WARNING status.
> > +in1_input		Measured voltage.
> > +in1_min			Minumum Voltage.
> > +in1_max			Maximum voltage.
> > +in1_min_alarm		Voltage low alarm.
> > +in1_max_alarm		Voltage high alarm.
> >  in1_highest		Historical maximum voltage.
> >  in1_reset_history	Write any value to reset history.
> >  
> >  curr1_label		"iout1"
> > -curr1_input		Measured current. From READ_IOUT register.
> > -curr1_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
> > -curr1_max_alarm		Current high alarm. From IOUT_OC_WARN_LIMIT register.
> > +curr1_input		Measured current.
> > +curr1_max		Maximum current.
> > +curr1_max_alarm		Current high alarm.
> >  curr1_lcrit		Critical minimum current. Depending on the chip
> >  			configuration, either curr1_lcrit or curr1_crit is
> >  			supported, but not both.
> > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > index c9237b9..3757558 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -26,11 +26,12 @@ config SENSORS_PMBUS
> >  	  be called pmbus.
> >  
> >  config SENSORS_ADM1275
> > -	tristate "Analog Devices ADM1275"
> > +	tristate "Analog Devices ADM1275 and compatibles"
> >  	default n
> >  	help
> >  	  If you say yes here you get hardware monitoring support for Analog
> > -	  Devices ADM1275 Hot-Swap Controller and Digital Power Monitor.
> > +	  Devices ADM1275 and ADM1276 Hot-Swap Controller and Digital Power
> > +	  Monitor.
> >  
> >  	  This driver can also be built as a module. If so, the module will
> >  	  be called adm1275.
> > diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> > index 061e7e7..cb04291 100644
> > --- a/drivers/hwmon/pmbus/adm1275.c
> > +++ b/drivers/hwmon/pmbus/adm1275.c
> > @@ -23,6 +23,8 @@
> >  #include <linux/i2c.h>
> >  #include "pmbus.h"
> >  
> > +enum chips { adm1275, adm1276 };
> > +
> >  #define ADM1275_PEAK_IOUT		0xd0
> >  #define ADM1275_PEAK_VIN		0xd1
> >  #define ADM1275_PEAK_VOUT		0xd2
> > @@ -36,9 +38,12 @@
> >  
> >  #define ADM1275_IOUT_WARN2_SELECT	(1 << 4)
> >  
> > +#define ADM1276_PEAK_PIN		0xda
> > +
> >  #define	ADM1275_MFR_STATUS_IOUT_WARN2	(1 << 0)
> >  
> >  struct adm1275_data {
> > +	int id;
> >  	bool have_oc_fault;
> >  	struct pmbus_driver_info info;
> >  };
> > @@ -78,11 +83,24 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
> >  	case PMBUS_VIRT_READ_VIN_MAX:
> >  		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_VIN);
> >  		break;
> > +	case PMBUS_VIRT_READ_PIN_MAX:
> > +		if (data->id != adm1276) {
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		ret = pmbus_read_word_data(client, 0, ADM1276_PEAK_PIN);
> > +		break;
> >  	case PMBUS_VIRT_RESET_IOUT_HISTORY:
> >  	case PMBUS_VIRT_RESET_VOUT_HISTORY:
> >  	case PMBUS_VIRT_RESET_VIN_HISTORY:
> >  		ret = 0;
> >  		break;
> > +	case PMBUS_VIRT_RESET_PIN_HISTORY:
> > +		if (data->id != adm1276)
> > +			ret = -EINVAL;
> > +		else
> > +			ret = 0;
> > +		break;
> 
> As with the previous patch, I am confused by the mix of -EINVAL and
> -ENODATA for unsupported features.
> 
Same as before - the calling code reacts differently.

> Also please don't forget to update wiki/Devices once this patch goes
> upstream.
> 
Sure.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
