From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 May 2011 19:09:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver sch5636
Message-Id: <20110526210922.4d015457@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306255997-4337-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1306255997-4337-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 24 May 2011 18:53:17 +0200, Hans de Goede wrote:
> This patch adds a new driver for SMSC SCH5636 Super I/O chips.
> The chips include an embedded microcontroller for hardware monitoring
> solutions, allowing motherboard manufacturers to create their own custom
> hwmon solution based upon the SCH5636.
> 
> Currently the sch5636 driver only supports the Fujitsu Theseus SCH5636 based
> hwmon solution. The sch5636 driver runs a sanity check on loading to ensure
> it is dealing with a Fujitsu Theseus and not with another custom SCH5636 based
> hwmon solution.

Overall it looks very good, see my comments inline below.

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/hwmon/sch5636 |   31 ++
>  drivers/hwmon/Kconfig       |   14 +
>  drivers/hwmon/Makefile      |    1 +
>  drivers/hwmon/sch5636.c     |  801 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 847 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/sch5636
>  create mode 100644 drivers/hwmon/sch5636.c
> 
> diff --git a/Documentation/hwmon/sch5636 b/Documentation/hwmon/sch5636
> new file mode 100644
> index 0000000..2bb0cd8
> --- /dev/null
> +++ b/Documentation/hwmon/sch5636
> @@ -0,0 +1,31 @@
> +Kernel driver sch5636
> +==========> +
> +Supported chips:
> +  * SMSC SCH5636
> +    Prefix: 'sch5636'
> +    Addresses scanned: none, address read from Super I/O config space
> +
> +Author: Hans de Goede <hdegoede@redhat.com>
> +
> +
> +Description
> +-----------
> +
> +SMSC SCH5636 Super I/O chips include an embedded microcontroller for
> +hardware monitoring solutions, allowing motherboard manufacturers to create
> +their own custom hwmon solution based upon the SCH5636.
> +
> +Currently the sch5636 driver only supports the Fujitsu Theseus SCH5636 based
> +hwmon solution. The sch5636 driver runs a sanity check on loading to ensure
> +it is dealing with a Fujitsu Theseus and not with another custom SCH5636 based
> +hwmon solution.
> +
> +The Fujitsu Theseus can monitor up to 5 voltages, 8 fans and 16
> +temperatures. Note that the driver detects how much fan headers /

s/how much/how many/

> +temperature sensors are actually implemented on the motherboard, so you will
> +likely see less temperature and fan inputs.

s/less/fewer/

> +
> +An application note decribing the Theseus' registers, as well as an
> +application note describing the protocol for communicating with the
> +microcontroller is available upon request. Please mail me if you want a copy.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 43221be..e9f0c49 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1030,6 +1030,20 @@ config SENSORS_SCH5627
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called sch5627.
>  
> +config SENSORS_SCH5636
> +	tristate "SMSC SCH5636"
> +	help
> +	  SMSC SCH5636 Super I/O chips include an embedded microcontroller for
> +	  hardware monitoring solutions, allowing motherboard manufacturers to
> +	  create their own custom hwmon solution based upon the SCH5636.
> +
> +	  Currently this driver only supports the Fujitsu Theseus SCH5636 based
> +	  hwmon solution. Say yes here if you want support for the Fujitsu
> +	  Theseus' hardware monitoring features.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sch5636.
> +
>  config SENSORS_ADS1015
>  	tristate "Texas Instruments ADS1015"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 28e8d52..8e85e9a 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -93,6 +93,7 @@ obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>  obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
>  obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
> +obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
>  obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>  obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
>  obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
> diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
> new file mode 100644
> index 0000000..71dd90f
> --- /dev/null
> +++ b/drivers/hwmon/sch5636.c
> @@ -0,0 +1,801 @@
> +/***************************************************************************
> + *   Copyright (C) 2011 Hans de Goede <hdegoede@redhat.com>                *
> + *                                                                         *
> + *   This program is free software; you can redistribute it and/or modify  *
> + *   it under the terms of the GNU General Public License as published by  *
> + *   the Free Software Foundation; either version 2 of the License, or     *
> + *   (at your option) any later version.                                   *
> + *                                                                         *
> + *   This program is distributed in the hope that it will be useful,       *
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
> + *   GNU General Public License for more details.                          *
> + *                                                                         *
> + *   You should have received a copy of the GNU General Public License     *
> + *   along with this program; if not, write to the                         *
> + *   Free Software Foundation, Inc.,                                       *
> + *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
> + ***************************************************************************/
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/platform_device.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/io.h>
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +
> +#define DRVNAME "sch5636"
> +#define DEVNAME "theseus" /* We only support one model for now */

Not sure if you really need a define for the device name. We'll have to
remove it if we ever add support for a second device.

> +
> +#define SIO_SCH5636_EM_LD	0x0C	/* Embedded Microcontroller LD */

_LD_EM would make more sense IMHO. You could also spell out "logical
device" in the comment, it's not necessarily obvious to everyone.

> +#define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
> +#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */

Each being used only once, I'm not sure if you really need defines.

> +
> +#define SIO_REG_LDSEL		0x07	/* Logical device select */
> +#define SIO_REG_DEVID		0x20	/* Device ID */
> +#define SIO_REG_ENABLE		0x30	/* Logical device enable */
> +#define SIO_REG_ADDR		0x66	/* Logical device address (2 bytes) */
> +
> +#define SIO_SCH5636_ID		0xC7	/* Chipset ID */
> +
> +#define REGION_LENGTH		9
> +
> +#define SCH5636_REG_FUJITSU_ID		0x780
> +#define SCH5636_REG_FUJITSU_REV		0x783
> +
> +#define SCH5636_CMD_READ		0x02
> +#define SCH5636_CMD_WRITE		0x03
> +
> +#define SCH5636_NO_IN 5
> +#define SCH5636_NO_TEMPS 16
> +#define SCH5636_NO_FANS 8

Naming is inconsistent, it should either be _INS/_TEMPS/_FANS or
_IN/_TEMP_FAN.

> +
> +static const u16 SCH5636_REG_IN[SCH5636_NO_IN] = {
> +	0x22, 0x23, 0x24, 0x25, 0x189 };
> +static const u16 SCH5636_REG_IN_FACTOR[SCH5636_NO_IN] = {
> +	4400, 1500, 4000, 4400, 16000 };
> +static const char * const SCH5636_IN_LABELS[SCH5636_NO_IN] = {
> +	"3.3V", "VREF", "VBAT", "3.3AUX", "12V" };

Here again, _FACTOR vs. _LABELS is inconsistent. And REG_IN is
inconsistent with REG_TEMP_VAL and REG_FAN_VAL below.

> +
> +static const u16 SCH5636_REG_TEMP_VAL[SCH5636_NO_TEMPS] = {
> +	0x2B, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x180, 0x181,
> +	0x85, 0x86, 0x87, 0x88, 0x89, 0x8A, 0x8B, 0x8C };
> +#define SCH5636_REG_TEMP_CTRL(i) (0x790 + (i))
> +#define SCH5636_TEMP_WORKING 0x01
> +#define SCH5636_TEMP_ALARM 0x02
> +#define SCH5636_TEMP_DEACTIVATED 0x80

Please align values with tabs.

> +
> +static const u16 SCH5636_REG_FAN_VAL[SCH5636_NO_FANS] = {
> +	0x2C, 0x2E, 0x30, 0x32, 0x62, 0x64, 0x66, 0x68 };
> +#define SCH5636_REG_FAN_CTRL(i) (0x880 + (i))
> +#define SCH5636_FAN_ALARM 0x04 /* FAULT in datasheet, but acts as an alarm */
> +#define SCH5636_FAN_NOT_PRESENT 0x08
> +#define SCH5636_FAN_DEACTIVATED 0x80

Please align values with tabs.

> +
> +struct sch5636_data {
> +	unsigned short addr;
> +	struct device *hwmon_dev;
> +
> +	struct mutex update_lock;
> +	char valid;			/* !=0 if following fields are valid */
> +	unsigned long last_updated;	/* In jiffies */
> +	u8 in[SCH5636_NO_IN];
> +	u8 temp_val[SCH5636_NO_TEMPS];
> +	u8 temp_ctrl[SCH5636_NO_TEMPS];
> +	u16 fan_val[SCH5636_NO_FANS];
> +	u8 fan_ctrl[SCH5636_NO_FANS];
> +};
> +
> +static struct platform_device *sch5636_pdev;
> +
> +/* Super I/O functions */
> +static inline int superio_inb(int base, int reg)
> +{
> +	outb(reg, base);
> +	return inb(base + 1);
> +}
> +
> +static inline int superio_enter(int base)
> +{
> +	/* Don't step on other drivers' I/O space by accident */
> +	if (!request_muxed_region(base, 2, DRVNAME)) {
> +		pr_err("I/O address 0x%04x already in use\n", base);
> +		return -EBUSY;
> +	}
> +
> +	outb(SIO_UNLOCK_KEY, base);
> +
> +	return 0;
> +}
> +
> +static inline void superio_select(int base, int ld)
> +{
> +	outb(SIO_REG_LDSEL, base);
> +	outb(ld, base + 1);
> +}
> +
> +static inline void superio_exit(int base)
> +{
> +	outb(SIO_LOCK_KEY, base);
> +	release_region(base, 2);
> +}
> +
> +static int sch5636_send_cmd(struct sch5636_data *data, u8 cmd, u16 reg, u8 v)
> +{

This looks very similar to the SCH5627. Have you considered having a
single driver for both? Or at least having a common part?

> +	u8 val;
> +	int i;
> +	/*
> +	 * According to SMSC for the commands we use the maximum time for
> +	 * the EM to respond is 15 ms, but testing shows in practice it
> +	 * responds within 15-32 reads, so we first busy poll, and if
> +	 * that fails sleep a bit and try again until we are way past
> +	 * the 15 ms maximum response time.
> +	 */
> +	const int max_busy_polls = 64;
> +	const int max_lazy_polls = 32;
> +
> +	/* (Optional) Write-Clear the EC to Host Mailbox Register */
> +	val = inb(data->addr + 1);
> +	outb(val, data->addr + 1);
> +
> +	/* Set Mailbox Address Pointer to first location in Region 1 */
> +	outb(0x00, data->addr + 2);
> +	outb(0x80, data->addr + 3);
> +
> +	/* Write Request Packet Header */
> +	outb(cmd, data->addr + 4); /* VREG Access Type read:0x02 write:0x03 */
> +	outb(0x01, data->addr + 5); /* # of Entries: 1 Byte (8-bit) */
> +	outb(0x04, data->addr + 2); /* Mailbox AP to first data entry loc. */
> +
> +	/* Write Value field */
> +	if (cmd = SCH5636_CMD_WRITE)
> +		outb(v, data->addr + 4);
> +
> +	/* Write Address field */
> +	outb(reg & 0xff, data->addr + 6);
> +	outb(reg >> 8, data->addr + 7);
> +
> +	/* Execute the Random Access Command */
> +	outb(0x01, data->addr); /* Write 01h to the Host-to-EC register */
> +
> +	/* EM Interface Polling "Algorithm" */
> +	for (i = 0; i < max_busy_polls + max_lazy_polls; i++) {
> +		if (i >= max_busy_polls)
> +			msleep(1);
> +		/* Read Interrupt source Register */
> +		val = inb(data->addr + 8);
> +		/* Write Clear the interrupt source bits */
> +		if (val)
> +			outb(val, data->addr + 8);
> +		/* Command Completed ? */
> +		if (val & 0x01)
> +			break;
> +	}
> +	if (i = max_busy_polls + max_lazy_polls) {
> +		pr_err("Max retries exceeded reading virtual "
> +		       "register 0x%04hx (%d)\n", reg, 1);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * According to SMSC we may need to retry this, but sofar I've always
> +	 * seen this succeed in 1 try.
> +	 */
> +	for (i = 0; i < max_busy_polls; i++) {
> +		/* Read EC-to-Host Register */
> +		val = inb(data->addr + 1);
> +		/* Command Completed ? */
> +		if (val = 0x01)
> +			break;
> +
> +		if (i = 0)
> +			pr_warn("EC reports: 0x%02x reading virtual register "
> +				"0x%04hx\n", (unsigned int)val, reg);
> +	}
> +	if (i = max_busy_polls) {
> +		pr_err("Max retries exceeded reading virtual "
> +		       "register 0x%04hx (%d)\n", reg, 2);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * According to the SMSC app note we should now do:
> +	 *
> +	 * Set Mailbox Address Pointer to first location in Region 1 *
> +	 * outb(0x00, data->addr + 2);
> +	 * outb(0x80, data->addr + 3);
> +	 *
> +	 * But if we do that things don't work, so let's not.
> +	 */
> +
> +	/* Read Value field */
> +	if (cmd = SCH5636_CMD_READ)
> +		return inb(data->addr + 4);
> +
> +	return 0;
> +}
> +
> +static int sch5636_read_virtual_reg(struct sch5636_data *data, u16 reg)
> +{
> +	return sch5636_send_cmd(data, SCH5636_CMD_READ, reg, 0);
> +}
> +
> +static int sch5636_write_virtual_reg(struct sch5636_data *data,
> +				     u16 reg, u8 val)
> +{
> +	return sch5636_send_cmd(data, SCH5636_CMD_WRITE, reg, val);
> +}
> +
> +static int sch5636_read_virtual_reg16(struct sch5636_data *data, u16 reg)
> +{
> +	int lsb, msb;
> +
> +	/* Read LSB first, this will cause the matching MSB to be latched */
> +	lsb = sch5636_read_virtual_reg(data, reg);
> +	if (lsb < 0)
> +		return lsb;
> +
> +	msb = sch5636_read_virtual_reg(data, reg + 1);
> +	if (msb < 0)
> +		return msb;
> +
> +	return lsb | (msb << 8);
> +}
> +
> +static struct sch5636_data *sch5636_update_device(struct device *dev)
> +{
> +	struct sch5636_data *data = dev_get_drvdata(dev);
> +	struct sch5636_data *ret = data;
> +	int i, val;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	/* Cache the values for 1 second */
> +	if (data->valid && !time_after(jiffies, data->last_updated + HZ))
> +		goto abort;
> +
> +	for (i = 0; i < SCH5636_NO_IN; i++) {
> +		val = sch5636_read_virtual_reg(data, SCH5636_REG_IN[i]);
> +		if (unlikely(val < 0)) {
> +			ret = ERR_PTR(val);
> +			goto abort;
> +		}
> +		data->in[i] = val;
> +	}
> +
> +	for (i = 0; i < SCH5636_NO_TEMPS; i++) {
> +		if (data->temp_ctrl[i] & SCH5636_TEMP_DEACTIVATED)
> +			continue;
> +
> +		val = sch5636_read_virtual_reg(data, SCH5636_REG_TEMP_VAL[i]);
> +		if (unlikely(val < 0)) {
> +			ret = ERR_PTR(val);
> +			goto abort;
> +		}
> +		data->temp_val[i] = val;
> +
> +		val = sch5636_read_virtual_reg(data, SCH5636_REG_TEMP_CTRL(i));
> +		if (unlikely(val < 0)) {
> +			ret = ERR_PTR(val);
> +			goto abort;
> +		}
> +		data->temp_ctrl[i] = val;
> +		/* Alarms need to be explicitly write-cleared */
> +		if (val & SCH5636_TEMP_ALARM) {
> +			sch5636_write_virtual_reg(data,
> +						SCH5636_REG_TEMP_CTRL(i), val);
> +		}
> +	}
> +
> +	for (i = 0; i < SCH5636_NO_FANS; i++) {
> +		if (data->fan_ctrl[i] & SCH5636_FAN_DEACTIVATED)
> +			continue;
> +
> +		val = sch5636_read_virtual_reg16(data, SCH5636_REG_FAN_VAL[i]);
> +		if (unlikely(val < 0)) {
> +			ret = ERR_PTR(val);
> +			goto abort;
> +		}
> +		data->fan_val[i] = val;
> +
> +		val = sch5636_read_virtual_reg(data, SCH5636_REG_FAN_CTRL(i));
> +		if (unlikely(val < 0)) {
> +			ret = ERR_PTR(val);
> +			goto abort;
> +		}
> +		data->fan_ctrl[i] = val;
> +		/* Alarms need to be explicitly write-cleared */
> +		if (val & SCH5636_FAN_ALARM) {
> +			sch5636_write_virtual_reg(data,
> +						SCH5636_REG_FAN_CTRL(i), val);
> +		}
> +	}
> +
> +	data->last_updated = jiffies;
> +	data->valid = 1;
> +abort:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
> +}
> +
> +static int reg_to_rpm(u16 reg)
> +{
> +	if (reg = 0)
> +		return -EIO;
> +	if (reg = 0xffff)
> +		return 0;
> +
> +	return 5400540 / reg;
> +}
> +
> +static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
> +	char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "%s\n", DEVNAME);
> +}
> +
> +static ssize_t show_in_value(struct device *dev, struct device_attribute
> +	*devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct sch5636_data *data = sch5636_update_device(dev);
> +	int val;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	val = DIV_ROUND_CLOSEST(
> +		data->in[attr->index] * SCH5636_REG_IN_FACTOR[attr->index],
> +		255);
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static ssize_t show_in_label(struct device *dev, struct device_attribute
> +	*devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n",
> +			SCH5636_IN_LABELS[attr->index]);
> +}
> +
> +static ssize_t show_temp_value(struct device *dev, struct device_attribute
> +	*devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct sch5636_data *data = sch5636_update_device(dev);
> +	int val;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	val = (data->temp_val[attr->index] - 64) * 1000;
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static ssize_t show_temp_fault(struct device *dev, struct device_attribute
> +	*devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct sch5636_data *data = sch5636_update_device(dev);
> +	int val;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	val = (data->temp_ctrl[attr->index] & SCH5636_TEMP_WORKING) ? 0 : 1;
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static ssize_t show_temp_alarm(struct device *dev, struct device_attribute
> +	*devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct sch5636_data *data = sch5636_update_device(dev);
> +	int val;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	val = (data->temp_ctrl[attr->index] & SCH5636_TEMP_ALARM) ? 1 : 0;
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static ssize_t show_fan_value(struct device *dev, struct device_attribute
> +	*devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct sch5636_data *data = sch5636_update_device(dev);
> +	int val;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	val = reg_to_rpm(data->fan_val[attr->index]);
> +	if (val < 0)
> +		return val;
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static ssize_t show_fan_fault(struct device *dev, struct device_attribute
> +	*devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct sch5636_data *data = sch5636_update_device(dev);
> +	int val;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	val = (data->fan_ctrl[attr->index] & SCH5636_FAN_NOT_PRESENT) ? 1 : 0;
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static ssize_t show_fan_alarm(struct device *dev, struct device_attribute
> +	*devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct sch5636_data *data = sch5636_update_device(dev);
> +	int val;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	val = (data->fan_ctrl[attr->index] & SCH5636_FAN_ALARM) ? 1 : 0;
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static struct sensor_device_attribute sch5636_attr[] = {
> +	SENSOR_ATTR(name, 0444, show_name, NULL, 0),
> +	SENSOR_ATTR(in0_input, 0444, show_in_value, NULL, 0),
> +	SENSOR_ATTR(in0_label, 0444, show_in_label, NULL, 0),
> +	SENSOR_ATTR(in1_input, 0444, show_in_value, NULL, 1),
> +	SENSOR_ATTR(in1_label, 0444, show_in_label, NULL, 1),
> +	SENSOR_ATTR(in2_input, 0444, show_in_value, NULL, 2),
> +	SENSOR_ATTR(in2_label, 0444, show_in_label, NULL, 2),
> +	SENSOR_ATTR(in3_input, 0444, show_in_value, NULL, 3),
> +	SENSOR_ATTR(in3_label, 0444, show_in_label, NULL, 3),
> +	SENSOR_ATTR(in4_input, 0444, show_in_value, NULL, 4),
> +	SENSOR_ATTR(in4_label, 0444, show_in_label, NULL, 4),
> +};
> +
> +static struct sensor_device_attribute sch5636_temp_attr[] = {
> +	SENSOR_ATTR(temp1_input, 0444, show_temp_value, NULL, 0),
> +	SENSOR_ATTR(temp1_fault, 0444, show_temp_fault, NULL, 0),
> +	SENSOR_ATTR(temp1_alarm, 0444, show_temp_alarm, NULL, 0),
> +	SENSOR_ATTR(temp2_input, 0444, show_temp_value, NULL, 1),
> +	SENSOR_ATTR(temp2_fault, 0444, show_temp_fault, NULL, 1),
> +	SENSOR_ATTR(temp2_alarm, 0444, show_temp_alarm, NULL, 1),
> +	SENSOR_ATTR(temp3_input, 0444, show_temp_value, NULL, 2),
> +	SENSOR_ATTR(temp3_fault, 0444, show_temp_fault, NULL, 2),
> +	SENSOR_ATTR(temp3_alarm, 0444, show_temp_alarm, NULL, 2),
> +	SENSOR_ATTR(temp4_input, 0444, show_temp_value, NULL, 3),
> +	SENSOR_ATTR(temp4_fault, 0444, show_temp_fault, NULL, 3),
> +	SENSOR_ATTR(temp4_alarm, 0444, show_temp_alarm, NULL, 3),
> +	SENSOR_ATTR(temp5_input, 0444, show_temp_value, NULL, 4),
> +	SENSOR_ATTR(temp5_fault, 0444, show_temp_fault, NULL, 4),
> +	SENSOR_ATTR(temp5_alarm, 0444, show_temp_alarm, NULL, 4),
> +	SENSOR_ATTR(temp6_input, 0444, show_temp_value, NULL, 5),
> +	SENSOR_ATTR(temp6_fault, 0444, show_temp_fault, NULL, 5),
> +	SENSOR_ATTR(temp6_alarm, 0444, show_temp_alarm, NULL, 5),
> +	SENSOR_ATTR(temp7_input, 0444, show_temp_value, NULL, 6),
> +	SENSOR_ATTR(temp7_fault, 0444, show_temp_fault, NULL, 6),
> +	SENSOR_ATTR(temp7_alarm, 0444, show_temp_alarm, NULL, 6),
> +	SENSOR_ATTR(temp8_input, 0444, show_temp_value, NULL, 7),
> +	SENSOR_ATTR(temp8_fault, 0444, show_temp_fault, NULL, 7),
> +	SENSOR_ATTR(temp8_alarm, 0444, show_temp_alarm, NULL, 7),
> +	SENSOR_ATTR(temp9_input, 0444, show_temp_value, NULL, 8),
> +	SENSOR_ATTR(temp9_fault, 0444, show_temp_fault, NULL, 8),
> +	SENSOR_ATTR(temp9_alarm, 0444, show_temp_alarm, NULL, 8),
> +	SENSOR_ATTR(temp10_input, 0444, show_temp_value, NULL, 9),
> +	SENSOR_ATTR(temp10_fault, 0444, show_temp_fault, NULL, 9),
> +	SENSOR_ATTR(temp10_alarm, 0444, show_temp_alarm, NULL, 9),
> +	SENSOR_ATTR(temp11_input, 0444, show_temp_value, NULL, 10),
> +	SENSOR_ATTR(temp11_fault, 0444, show_temp_fault, NULL, 10),
> +	SENSOR_ATTR(temp11_alarm, 0444, show_temp_alarm, NULL, 10),
> +	SENSOR_ATTR(temp12_input, 0444, show_temp_value, NULL, 11),
> +	SENSOR_ATTR(temp12_fault, 0444, show_temp_fault, NULL, 11),
> +	SENSOR_ATTR(temp12_alarm, 0444, show_temp_alarm, NULL, 11),
> +	SENSOR_ATTR(temp13_input, 0444, show_temp_value, NULL, 12),
> +	SENSOR_ATTR(temp13_fault, 0444, show_temp_fault, NULL, 12),
> +	SENSOR_ATTR(temp13_alarm, 0444, show_temp_alarm, NULL, 12),
> +	SENSOR_ATTR(temp14_input, 0444, show_temp_value, NULL, 13),
> +	SENSOR_ATTR(temp14_fault, 0444, show_temp_fault, NULL, 13),
> +	SENSOR_ATTR(temp14_alarm, 0444, show_temp_alarm, NULL, 13),
> +	SENSOR_ATTR(temp15_input, 0444, show_temp_value, NULL, 14),
> +	SENSOR_ATTR(temp15_fault, 0444, show_temp_fault, NULL, 14),
> +	SENSOR_ATTR(temp15_alarm, 0444, show_temp_alarm, NULL, 14),
> +	SENSOR_ATTR(temp16_input, 0444, show_temp_value, NULL, 15),
> +	SENSOR_ATTR(temp16_fault, 0444, show_temp_fault, NULL, 15),
> +	SENSOR_ATTR(temp16_alarm, 0444, show_temp_alarm, NULL, 15),
> +};
> +
> +static struct sensor_device_attribute sch5636_fan_attr[] = {
> +	SENSOR_ATTR(fan1_input, 0444, show_fan_value, NULL, 0),
> +	SENSOR_ATTR(fan1_fault, 0444, show_fan_fault, NULL, 0),
> +	SENSOR_ATTR(fan1_alarm, 0444, show_fan_alarm, NULL, 0),
> +	SENSOR_ATTR(fan2_input, 0444, show_fan_value, NULL, 1),
> +	SENSOR_ATTR(fan2_fault, 0444, show_fan_fault, NULL, 1),
> +	SENSOR_ATTR(fan2_alarm, 0444, show_fan_alarm, NULL, 1),
> +	SENSOR_ATTR(fan3_input, 0444, show_fan_value, NULL, 2),
> +	SENSOR_ATTR(fan3_fault, 0444, show_fan_fault, NULL, 2),
> +	SENSOR_ATTR(fan3_alarm, 0444, show_fan_alarm, NULL, 2),
> +	SENSOR_ATTR(fan4_input, 0444, show_fan_value, NULL, 3),
> +	SENSOR_ATTR(fan4_fault, 0444, show_fan_fault, NULL, 3),
> +	SENSOR_ATTR(fan4_alarm, 0444, show_fan_alarm, NULL, 3),
> +	SENSOR_ATTR(fan5_input, 0444, show_fan_value, NULL, 4),
> +	SENSOR_ATTR(fan5_fault, 0444, show_fan_fault, NULL, 4),
> +	SENSOR_ATTR(fan5_alarm, 0444, show_fan_alarm, NULL, 4),
> +	SENSOR_ATTR(fan6_input, 0444, show_fan_value, NULL, 5),
> +	SENSOR_ATTR(fan6_fault, 0444, show_fan_fault, NULL, 5),
> +	SENSOR_ATTR(fan6_alarm, 0444, show_fan_alarm, NULL, 5),
> +	SENSOR_ATTR(fan7_input, 0444, show_fan_value, NULL, 6),
> +	SENSOR_ATTR(fan7_fault, 0444, show_fan_fault, NULL, 6),
> +	SENSOR_ATTR(fan7_alarm, 0444, show_fan_alarm, NULL, 6),
> +	SENSOR_ATTR(fan8_input, 0444, show_fan_value, NULL, 7),
> +	SENSOR_ATTR(fan8_fault, 0444, show_fan_fault, NULL, 7),
> +	SENSOR_ATTR(fan8_alarm, 0444, show_fan_alarm, NULL, 7),
> +};
> +
> +static int sch5636_remove(struct platform_device *pdev)
> +{
> +	struct sch5636_data *data = platform_get_drvdata(pdev);
> +	int i;
> +
> +	if (data->hwmon_dev)
> +		hwmon_device_unregister(data->hwmon_dev);
> +
> +	for (i = 0; i < ARRAY_SIZE(sch5636_attr); i++)
> +		device_remove_file(&pdev->dev,  &sch5636_attr[i].dev_attr);

Double space after comma.

> +
> +	for (i = 0; i < (SCH5636_NO_TEMPS * 3); i++)

Parentheses not needed.

> +		device_remove_file(&pdev->dev,
> +				   &sch5636_temp_attr[i].dev_attr);
> +
> +	for (i = 0; i < (SCH5636_NO_FANS * 3); i++)

Same here. I would use ARRAY_SIZE() anyway, it's just as correct and
won't change even if you ever add attributes to the arrays.

> +		device_remove_file(&pdev->dev,
> +				   &sch5636_fan_attr[i].dev_attr);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +static int __devinit sch5636_probe(struct platform_device *pdev)
> +{
> +	struct sch5636_data *data;
> +	int i, err, val, revision[2];
> +	char id[4];
> +
> +	data = kzalloc(sizeof(struct sch5636_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
> +	mutex_init(&data->update_lock);
> +	platform_set_drvdata(pdev, data);
> +
> +	for (i = 0; i < 3; i++) {
> +		val = sch5636_read_virtual_reg(data,
> +					       SCH5636_REG_FUJITSU_ID + i);
> +		if (val < 0) {
> +			pr_err("Could not read Fujitsu id byte at %x\n",

%#x please, to avoid any confusion.

> +				SCH5636_REG_FUJITSU_ID + i);
> +			err = val;
> +			goto error;
> +		}
> +		id[i] = val;
> +	}
> +	id[i] = 0;

I'd prefer '\0', even though it's the same.

> +
> +	if (strcmp(id, "THS")) {
> +		pr_err("Unknown Fujitsu id: '%s'\n", id);

This could print complete garbage, you have no guarantee that the bytes
are in the 32-126 range.

> +		err = -ENODEV;
> +		goto error;
> +	}
> +
> +	for (i = 0; i < 2; i++) {
> +		val = sch5636_read_virtual_reg(data,
> +					       SCH5636_REG_FUJITSU_REV + i);
> +		if (val < 0) {
> +			err = val;
> +			goto error;
> +		}
> +		revision[i] = val;
> +	}
> +	pr_info("Found %s chip at %#hx, revison: %d.%02d\n", DEVNAME,
> +		data->addr, revision[0], revision[1]);
> +
> +	/* Read all temp + fan ctrl registers to determine which are active */
> +	for (i = 0; i < SCH5636_NO_TEMPS; i++) {
> +		val = sch5636_read_virtual_reg(data, SCH5636_REG_TEMP_CTRL(i));
> +		if (unlikely(val < 0)) {
> +			err = val;
> +			goto error;
> +		}
> +		data->temp_ctrl[i] = val;
> +	}
> +
> +	for (i = 0; i < SCH5636_NO_FANS; i++) {
> +		val = sch5636_read_virtual_reg(data, SCH5636_REG_FAN_CTRL(i));
> +		if (unlikely(val < 0)) {
> +			err = val;
> +			goto error;
> +		}
> +		data->fan_ctrl[i] = val;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(sch5636_attr); i++) {
> +		err = device_create_file(&pdev->dev,
> +					 &sch5636_attr[i].dev_attr);
> +		if (err)
> +			goto error;
> +	}
> +
> +	for (i = 0; i < (SCH5636_NO_TEMPS * 3); i++) {
> +		if (data->temp_ctrl[i/3] & SCH5636_TEMP_DEACTIVATED)
> +			continue;
> +
> +		err = device_create_file(&pdev->dev,
> +					&sch5636_temp_attr[i].dev_attr);
> +		if (err)
> +			goto error;
> +	}
> +
> +	for (i = 0; i < (SCH5636_NO_FANS * 3); i++) {
> +		if (data->fan_ctrl[i/3] & SCH5636_FAN_DEACTIVATED)
> +			continue;
> +
> +		err = device_create_file(&pdev->dev,
> +					&sch5636_fan_attr[i].dev_attr);
> +		if (err)
> +			goto error;
> +	}
> +
> +	data->hwmon_dev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		data->hwmon_dev = NULL;
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	sch5636_remove(pdev);
> +	return err;
> +}
> +
> +static int __init sch5636_find(int sioaddr, unsigned short *address)
> +{
> +	u8 devid;
> +	int err = superio_enter(sioaddr);

For clarity, I'd avoid including a function call with a side effect in
variable declarations.

> +	if (err)
> +		return err;
> +
> +	devid = superio_inb(sioaddr, SIO_REG_DEVID);
> +	if (devid != SIO_SCH5636_ID) {
> +		pr_debug("Unsupported device id: 0x%02x\n",
> +			 (unsigned int)devid);
> +		err = -ENODEV;
> +		goto exit;
> +	}
> +
> +	superio_select(sioaddr, SIO_SCH5636_EM_LD);
> +
> +	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01)) {
> +		pr_warn("Device not activated\n");
> +		err = -ENODEV;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Warning the order of the low / high byte is the other way around
> +	 * as on most other superio devices!!
> +	 */
> +	*address = superio_inb(sioaddr, SIO_REG_ADDR) |
> +		   superio_inb(sioaddr, SIO_REG_ADDR + 1) << 8;
> +	if (*address = 0) {
> +		pr_warn("Base address not set\n");
> +		err = -ENODEV;
> +		goto exit;
> +	}
> +
> +exit:
> +	superio_exit(sioaddr);
> +	return err;
> +}
> +
> +static int __init sch5636_device_add(unsigned short address)
> +{
> +	struct resource res = {
> +		.start	= address,
> +		.end	= address + REGION_LENGTH - 1,
> +		.flags	= IORESOURCE_IO,
> +	};
> +	int err;
> +
> +	sch5636_pdev = platform_device_alloc(DRVNAME, address);
> +	if (!sch5636_pdev)
> +		return -ENOMEM;
> +
> +	res.name = sch5636_pdev->name;
> +	err = acpi_check_resource_conflict(&res);
> +	if (err)
> +		goto exit_device_put;
> +
> +	err = platform_device_add_resources(sch5636_pdev, &res, 1);
> +	if (err) {
> +		pr_err("Device resource addition failed\n");
> +		goto exit_device_put;
> +	}
> +
> +	err = platform_device_add(sch5636_pdev);
> +	if (err) {
> +		pr_err("Device addition failed\n");
> +		goto exit_device_put;
> +	}
> +
> +	return 0;
> +
> +exit_device_put:
> +	platform_device_put(sch5636_pdev);
> +
> +	return err;
> +}
> +
> +static struct platform_driver sch5636_driver = {
> +	.driver = {
> +		.owner	= THIS_MODULE,
> +		.name	= DRVNAME,
> +	},
> +	.probe		= sch5636_probe,
> +	.remove		= sch5636_remove,
> +};
> +
> +static int __init sch5636_init(void)
> +{
> +	int err = -ENODEV;
> +	unsigned short address;
> +
> +	if (sch5636_find(0x4e, &address) && sch5636_find(0x2e, &address))
> +		goto exit;

Please return the error code from sch5636_find, instead of hard-coding
-ENODEV.

Out of curiosity, why are you checking 0x4e first, when all other
drivers check 0x2e first?

> +
> +	err = platform_driver_register(&sch5636_driver);
> +	if (err)
> +		goto exit;
> +
> +	err = sch5636_device_add(address);
> +	if (err)
> +		goto exit_driver;
> +
> +	return 0;
> +
> +exit_driver:
> +	platform_driver_unregister(&sch5636_driver);
> +exit:
> +	return err;
> +}
> +
> +static void __exit sch5636_exit(void)
> +{
> +	platform_device_unregister(sch5636_pdev);
> +	platform_driver_unregister(&sch5636_driver);
> +}
> +
> +MODULE_DESCRIPTION("SMSC SCH5636 Hardware Monitoring Driver");
> +MODULE_AUTHOR("Hans de Goede (hdegoede@redhat.com)");

Please use < > instead of ( ) so that people can copy and paste
directly.

> +MODULE_LICENSE("GPL");
> +
> +module_init(sch5636_init);
> +module_exit(sch5636_exit);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
