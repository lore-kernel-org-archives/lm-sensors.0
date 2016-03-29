From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
Date: Tue, 29 Mar 2016 15:35:06 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (max31722) Add alarm support
Message-Id: <4586F61A4A291F4DA44D32824E7C0F402356A2E1@IRSMSX109.ger.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1458646865-6416-3-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1458646865-6416-3-git-send-email-tiberiu.a.breana@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for your review! Replies inline.

Tiberiu

> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Tuesday, March 22, 2016 4:57 PM
> To: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; lm-sensors@lm-
> sensors.org
> Cc: Baluta, Daniel <daniel.baluta@intel.com>
> Subject: Re: [PATCH 2/2] hwmon: (max31722) Add alarm support
> 
> On 03/22/2016 04:41 AM, Tiberiu Breana wrote:
> > Add temperature threshold alarm support for the max31722 sensor
> > driver.
> >
> > Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> > ---
> >   Documentation/hwmon/max31722 |   7 +++
> >   drivers/hwmon/max31722.c     | 130
> +++++++++++++++++++++++++++++++++++++++++--
> >   2 files changed, 131 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/hwmon/max31722
> > b/Documentation/hwmon/max31722 index 090da845..e247963 100644
> > --- a/Documentation/hwmon/max31722
> > +++ b/Documentation/hwmon/max31722
> > @@ -25,6 +25,10 @@ Usage Notes
> >   -----------
> >
> >   This driver uses ACPI to auto-detect devices. See ACPI IDs in the above
> section.
> > +The sensor supports a temperature alarm. This is set once the
> > +measured temperature goes above a user-set threshold (temp1_max)
> and
> > +will be cleared once the temperature goes below temp1_min. See the
> > +datasheet, page 9, "Comparator Mode" for details.
> >
> >   Sysfs entries
> >   -------------
> > @@ -32,3 +36,6 @@ Sysfs entries
> >   The following attribute is supported:
> >
> >   temp1_input		Measured temperature. Read-only.
> > +temp1_alarm		Temperature alarm. Read-only.
> > +temp1_min		Minimum temperature threshold. Read-write.
> > +temp1_max		Maximum temperature threshold. Read-write.
> > diff --git a/drivers/hwmon/max31722.c b/drivers/hwmon/max31722.c
> index
> > 13ba906..8e14eed 100644
> > --- a/drivers/hwmon/max31722.c
> > +++ b/drivers/hwmon/max31722.c
> > @@ -11,6 +11,8 @@
> >
> >   #include <linux/kernel.h>
> >   #include <linux/acpi.h>
> > +#include <linux/gpio/consumer.h>
> 
> Why is this needed ?

My bad, this is some leftover code from a development version that
uses gpio to receive interrupts.

> 
> > +#include <linux/interrupt.h>
> >   #include <linux/module.h>
> >   #include <linux/regmap.h>
> >   #include <linux/spi/spi.h>
> > @@ -20,13 +22,20 @@
> >   #define MAX31722_REG_CFG				0x00
> >   #define MAX31722_REG_TEMP_LSB				0x01
> >   #define MAX31722_REG_TEMP_MSB				0x02
> > +#define MAX31722_REG_THIGH_LSB				0x03
> > +#define MAX31722_REG_TLOW_LSB				0x05
> >   #define MAX31722_MAX_REG				0x86
> >
> >   #define MAX31722_MODE_CONTINUOUS			0x00
> >   #define MAX31722_MODE_STANDBY				0x01
> >   #define MAX31722_RESOLUTION_11BIT			0x02
> >
> > +/* Minimum and maximum supported temperatures, in millidegrees */
> > +#define MAX31722_MIN_TEMP				-55000
> > +#define MAX31722_MAX_TEMP				125000
> > +
> 
> Question here is if those are chip operating ranges or register limits.
> Reason for asking is that it might be (and likely is) possible to write values
> outside this range into the chip. If so, those are the limits you should use.
> Otherwise we could end up in situations where the chip reports a lower limit
> of -100 degrees C, but it would be impossible to write that value back into the
> chip.

This is the chip's operating range. The datasheet states that temperatures
outside this range will likely cause permanent damage to the device. I have
no means of testing the device's operation outside of those conditions, so
I suggest we enforce the limits specified from the datasheet.

> 
> >   #define MAX31722_REGMAP_NAME
> 	"max31722_regmap"
> > +#define MAX31722_GPIO
> 	"max31722_gpio"
> >
> Where is this used ?

Again, leftover code. Will delete this.

> 
> >   #define MAX31722_REGFIELD(name)
> 		    \
> >   	do {								    \
> > @@ -39,12 +48,27 @@
> >   		}							    \
> >   	} while (0)
> >
> > +enum attr_index {
> > +	t_input,
> > +	t_min,
> > +	t_max,
> > +	t_alarm,
> > +	t_num_regs
> > +};
> > +
> > +static const u8 max31722_regs[t_num_regs] = {
> > +	[t_input]	= MAX31722_REG_TEMP_LSB,
> > +	[t_min]		= MAX31722_REG_TLOW_LSB,
> > +	[t_max]		= MAX31722_REG_THIGH_LSB,
> > +};
> 
> The only use of this array, as far as I can see, is to convert t_{input, min, max}
> into register addresses. You can write the register directly into attr->index
> and drop this indirection.

Agreed, will drop this.

> 
> > +
> >   struct max31722_data {
> >   	struct spi_device *spi_device;
> >   	struct device *hwmon_dev;
> >   	struct regmap *regmap;
> >   	struct regmap_field *reg_state;
> >   	struct regmap_field *reg_resolution;
> > +	bool alarm_active;
> >   };
> >
> >   /*
> > @@ -117,9 +141,9 @@ static ssize_t max31722_show_name(struct device
> *dev,
> >   	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
> >   }
> >
> > -static ssize_t max31722_show_temperature(struct device *dev,
> > -					 struct device_attribute *attr,
> > -					 char *buf)
> > +static ssize_t max31722_show_temp(struct device *dev,
> > +				  struct device_attribute *devattr,
> > +				  char *buf)
> 
> If you are going to use max31722_show_temp(), might as well introduce it
> with that name in the first patch.

Done.

> 
> >   {
> >   	int i;
> >   	int ret;
> > @@ -127,8 +151,10 @@ static ssize_t max31722_show_temperature(struct
> device *dev,
> >   	s16 val;
> >   	u16 temp;
> >   	struct max31722_data *data = dev_get_drvdata(dev);
> > +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> >
> > -	ret = regmap_bulk_read(data->regmap, MAX31722_REG_TEMP_LSB,
> &temp, 2);
> > +	ret = regmap_bulk_read(data->regmap,
> > +			       max31722_regs[attr->index], &temp, 2);
> >   	if (ret < 0) {
> >   		dev_err(&data->spi_device->dev,
> >   			"failed to read temperature register\n"); @@ -152,13
> +178,79 @@
> > static ssize_t max31722_show_temperature(struct device *dev,
> >   	return sprintf(buf, "%d\n", val);
> >   }
> >
> > +static ssize_t max31722_set_temp(struct device *dev,
> > +				 struct device_attribute *devattr,
> > +				 const char *buf, size_t count)
> > +{
> > +	int i;
> > +	int ret;
> > +	int fract;
> > +	u16 thresh;
> > +	u8 lsb;
> > +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > +	long val;
> > +	struct max31722_data *data = dev_get_drvdata(dev);
> > +
> > +	ret = kstrtol(buf, 10, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (val < MAX31722_MIN_TEMP || val > MAX31722_MAX_TEMP)
> > +		return -EINVAL;
> 
> Please use clamp_val(). We don't expect users to know chip limits.

Will use clamp_val() in v2.

> 
> > +	/*
> > +	* Convert input to a register value. First round down the value to one
> > +	* that can be represented in the 11 bit resolution.
> > +	*/
> > +	val -= val % max31722_milli_table[2];
> > +
> > +	fract = val % 1000;
> > +
> > +	lsb = 0;
> > +	for (i = 0 ; i < ARRAY_SIZE(max31722_milli_table) && fract > 0; i++)
> > +	if (fract - max31722_milli_table[i] >= 0) {
> > +		fract -= max31722_milli_table[i];
> > +		lsb += 1 << (3 - i - 1);
> > +	}
> > +	lsb <<= 5;
> > +
> > +	thresh = (val / 1000) << 8 | lsb;
> 
> 	thresh = cpu_to_le16(DIV_ROUND_CLOSEST(val, 125) << 5);
> 
> should accomplish the same (and also work on big endian systems).

Will use this in v2.

> 
> > +	ret = regmap_bulk_write(data->regmap,
> > +				max31722_regs[attr->index], &thresh, 2);
> > +	if (ret < 0) {
> > +		dev_err(&data->spi_device->dev,
> > +			"failed to write threshold register\n");
> 
> Please no log message here.
> 
> > +		return ret;
> > +	}
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t max31722_show_alarm(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   char *buf)
> > +{
> > +	struct spi_device *spi_device = to_spi_device(dev);
> > +	struct max31722_data *data = spi_get_drvdata(spi_device);
> > +
> > +	return sprintf(buf, "%d\n", data->alarm_active ? 1 : 0);
> 
> bool auto-converts to 0/1, so you can just print data->alarm_active.
> 
> > +}
> > +
> >   static DEVICE_ATTR(name, S_IRUGO, max31722_show_name, NULL); -
> static
> > SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
> > -			  max31722_show_temperature, NULL, 0);
> > +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
> max31722_show_temp,
> > +NULL, 0); static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
> max31722_show_temp,
> > +			  max31722_set_temp, t_min);
> > +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
> max31722_show_temp,
> > +			  max31722_set_temp, t_max);
> 
>  From the datasheet, this is not really min/max, but max_hyst/max.

That does indeed sound more logical. I'll change the attributes in v2.

> 
> > +static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO,
> max31722_show_alarm, NULL,
> > +			  t_alarm);
> 
> There is no alarm register, so you might as well just use DEVICE_ATTR here.
> 
> > +
> >
> >   static struct attribute *max31722_attributes[] = {
> >   	&dev_attr_name.attr,
> >   	&sensor_dev_attr_temp1_input.dev_attr.attr,
> > +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> > +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> > +	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
> 
> Attributes should be max_hyst, max, and max_alarm.
> 
> >   	NULL,
> >   };
> >
> > @@ -166,6 +258,18 @@ static const struct attribute_group
> max31722_group = {
> >   	.attrs = max31722_attributes,
> >   };
> >
> > +static irqreturn_t max31722_irq_handler(int irq, void *private) {
> > +	struct max31722_data *data = private;
> > +	/*
> > +	 * The device will issue cyclical interrupts when the
> > +	 * THIGH/TLOW thresholds are met.
> > +	 */
> > +	data->alarm_active = !data->alarm_active;
> 
> 'Cyclical' is a bit misleading. Yes, the term is used in the data sheet, but what
> it really means is that the alarm is activated if the temperature exceeds Thigh
> and deactivated if the temperature goes below Tlow.
> 
> However, I am more than a bit concerned about this code, It assumes that
> there is no alarm when the driver is instantiated, and it assumes that
> interrupts don't get lost.
> 
> I think your real only option here is to explicitly read the current temperature
> and compare it to Thigh/Tlow to see if there is an alarm. This makes this
> function a bit tricky; it would have to be something like
> 
> 	if (temperature > Thigh)
> 		alarm_active = true;
> 	else if (temperature < Tlow)
> 		alarm_active = false;
> 
> with a grey area what to do if the measured temperature is between Tlow
> and Thigh.
> Maybe flip alarm_active in that case ?
> 
> You might also consider generating a sysfs and/or udev notification on the
> alarm attribute here.

I was somewhat conflicted as well when implementing interrupt support for the
chip via the hwmon alarm attribute. In IIO it was simpler; when an interrupt is
received, we send an event to userspace that a threshold has been met.
We can't check a register to see which threshold was met, so we sent an
"either direction" event and let the user check.

The hwmon sysfs-interface doc explicitly says "drivers do NOT make
comparisons of readings to thresholds". Are you suggesting otherwise?

> 
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >   static int max31722_init(struct max31722_data *data)
> >   {
> >   	int ret = 0;
> > @@ -196,6 +300,8 @@ static int max31722_init(struct max31722_data
> *data)
> >   	if (ret < 0)
> >   		goto err;
> >
> > +	data->alarm_active = false;
> > +
> 
> That assumes that there is currently no alarm, which we don't know.
> Best solution might be to have a function update_alarm_status() and call it
> from here as well as from the interrupt handler.

In the default comparator mode, if a threshold was surpassed, TOUT will be
active and it should trigger the interrupt handler, setting alarm_active to true.

> 
> >   	return 0;
> >
> >   err:
> > @@ -223,6 +329,18 @@ static int max31722_probe(struct spi_device *spi)
> >   	if (ret < 0)
> >   		goto err_standby;
> >
> > +	if (spi->irq > 0) {
> > +		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> > +						NULL,
> > +						max31722_irq_handler,
> > +						IRQF_TRIGGER_LOW |
> IRQF_ONESHOT,
> 
> Doesn't IRQF_ONESHOT mean you would have to re-enable the interrupt ?

devm_request_threaded_irq won't allow the request without a "top half"
irq handler unless the oneshot flag is added. From what I've seen working
with the device, there's no need to manually reactivate interrupts.

> 
> > +						dev_name(&spi->dev), data);
> > +		if (ret < 0) {
> > +			dev_err(&spi->dev, "request irq %d failed\n", spi-
> >irq);
> > +			goto err_remove_group;
> > +		}
> > +	}
> 
> This means that the alarm is only supported if there is interrupt support.
> The alarm attribute should therefore only exist if interrupts are supported.
> The easiest way to implement this would be by creating a separate sensor
> group for the alarm attribute (though you would have to add the list of
> groups to max31722_data). Another option would be to use .is_visible.
>

That makes sense. I'll implement this in v2.

> Another problem is initialization: Your code assumes that the chip is in
> interrupt mode. What if the BIOS/ROMMON programmed it to comparator
> mode ?
> In that case you would have to either reprogram it, or change the interrupt to
> edge triggered (I think).
> 
> The datasheet suggests that the chip is initially in comparator mode, which
> makes me wonder if/how you tested this code.

There is no assumption that the chip starts in interrupt mode. As mentioned
in the cover letter, the driver was written for comparator mode.

> 
> > +
> >   	data->hwmon_dev = hwmon_device_register(&spi->dev);
> >   	if (IS_ERR(data->hwmon_dev)) {
> >   		ret = PTR_ERR(data->hwmon_dev);
> >


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
