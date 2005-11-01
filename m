From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 01 Nov 2005 16:10:29 +0000
Subject: [lm-sensors] Re: [PATCH] lm93 driver for 2.6
Message-Id: <20051101160957.1bf02bdf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051028182339.23792.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20051028182339.23792.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> This patch provides driver for lm93.
> 
> This patch originated from Eric J. Bowersox [1], but never made it to mainline.
> I just redodiffed the patch and updated to current state of i2c subsystem and
> fixed the codingstyle.
> 
> This driver needs the previous patch for i2c block read function.
> 
> Signed-Off-By: Eric J. Bowersox <ericb@aspsys.com>
> Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>
> 
> Please apply,

Here's my review of it.

A general comment first. Some code in this driver does not appear to
have been taken from Mark Hoffman's driver. Even for the part that has
been, it would probably be worth checking the CVS log for Mark's
driver. There have been several fixes to it since the first version,
and these fixes may apply to the 2.6 version of the driver too. Same
goes for the documentation (I just committed minor fixes to the lm93
documentation file, BTW).

Second, no matter how many hours I spent on this, this really only is a
*quick* review. This driver is a monster. The chip design is very
complex, I just can't read all the code in deep details. Seriously, who
needs this complexity? I wouldn't trust a chip which needs a 70 kB
driver to work properly when it comes to monitoring my hardware and
controlling its cooling. It's the largest hwmon driver we have, by far.

I'm serious. I would very much enjoy a smaller driver with only the
features users actually need. I can't believe anyone really needs to
finetune the chip to the possible extent.

Is anyone willing to be the maintainer for this driver if it is
integrated into Linux 2.6? I will not be maintaining this thing myself,
that wouldn't be serious.

> diff -Naur a/Documentation/hwmon/lm93 b/Documentation/hwmon/lm93
> --- a/Documentation/hwmon/lm93	1970-01-01 01:00:00.000000000 +0100
> +++ b/Documentation/hwmon/lm93	2005-10-23 18:21:24.055045750 +0200
> @@ -0,0 +1,410 @@
> +Kernel driver lm93
> +=========
> +
> +Supported chips:
> +  * National Semiconductor LM93
> +    Prefix 'lm93'
> +    Addresses scanned: I2C 0x2c-0x2e
> +    Datasheet: http://www.national.com/ds.cgi/LM/LM93.pdf
> +
> +Author:
> +	Mark M. Hoffman <mhoffman@lightlink.com>
> +	Ported to 2.6 by Eric J. Bowersox <ericb@aspsys.com>

So that would be Author_s_.

> +Module Parameters
> +-----------------
> +
> +(specific to LM93)
> +* init: integer
> +  Set to non-zero to force some initializations (default is 0).
> +* disable_block: integer
> +  A "0" allows SMBus block data transactions if the host supports them.  A "1"
> +  disables SMBus block data transactions.  The default is 0.
> +* vccp_limit_type: integer array (2)
> +  Configures in7 and in8 limit type, where 0 means absolute and non-zero
> +  means relative.  "Relative" here refers to "Dynamic Vccp Monitoring using
> +  VID" from the datasheet.  It greatly simplifies the interface to allow
> +  only one set of limits (absolute or relative) to be in operation at a
> +  time (even though the hardware is capable of enabling both).  There's
> +  not a compelling use case for enabling both at once, anyway.  The default
> +  is "0,0".
> +* vid_agtl: integer
> +  A "0" configures the VID pins for V(ih) = 2.1V min, V(il) = 0.8V max.
> +  A "1" configures the VID pins for V(ih) = 0.8V min, V(il) = 0.4V max.
> +  (The latter setting is referred to as AGTL+ Compatible in the datasheet.)
> +  I.e. this parameter controls the VID pin input thresholds; if your VID
> +  inputs are not working, try changing this.  The default value is "0".
> +
> +(common among sensor drivers)
> +* force: short array (min = 1, max = 48)
> +  List of adapter,address pairs to assume to be present.  Autodetection
> +  of the target device will still be attempted.  Use one of the more
> +  specific force directives below if this doesn't detect the device.
> +* force_lm93: short array (min = 1, max = 48)
> +  List of adapter,address pairs which are unquestionably assumed to contain
> +  a 'lm93' chip
> +* ignore: short array (min = 1, max = 48)
> +  List of adapter,address pairs not to scan
> +* ignore_range: short array (min = 1, max = 48)
> +  List of adapter,start-addr,end-addr triples not to scan
> +* probe: short array (min = 1, max = 48)
> +  List of adapter,address pairs to scan additionally
> +* probe_range: short array (min = 1, max = 48)
> +  List of adapter,start-addr,end-addr triples to scan additionally

We decided not to mention common module parameters in the chip-specific
documentation.

> +Driver Description
> +------------------
> +
> +This driver implements support for the National Semiconductor LM93.
> +
> +

I've dropped that section on the 2.4 side, and think we should do the
same here. This is really redundant with the beginning of the file
where we list the supported devices.

> +LM93 Unique sysfs Files
> +-----------------------
> +
> +	file			description
> +	-------------------------------------------------------------
> +
> +	prochot<n>		current #PROCHOT %
> +
> +	prochot<n>_avg		moving average #PROCHOT %
> +
> +	prochot<n>_max		limit #PROCHOT %
> +
> +	prochot_short		enable or disable logical #PROCHOT pin short
> +
> +	prochot<n>_override	force #PROCHOT assertion as PWM
> +
> +	prochot_override_duty_cycle
> +				duty cycle for the PWM signal used when
> +				#PROCHOT is overridden
> +
> +	prochot<n>_interval	#PROCHOT PWM sampling interval
> +
> +	vrdhot<n>		0 means negated, 1 means asserted
> +
> +	fan<n>_smart_tach	enable or disable smart tach mode
> +
> +	pwm<n>_auto_channels	select control sources for PWM outputs
> +
> +	pwm<n>_auto_spinup_min	minimum duty cycle during spin-up
> +
> +	pwm<n>_auto_spinup_time	duration of spin-up
> +
> +	pwm_auto_prochot_ramp	ramp time per step when #PROCHOT asserted
> +
> +	pwm_auto_vrdhot_ramp	ramp time per step when #VRDHOT asserted
> +
> +	temp<n>_auto_base	temperature channel base
> +
> +	temp<n>_auto_offset[1-12]
> +				temperature channel offsets
> +
> +	temp<n>_auto_offset_hyst
> +				temperature channel offset hysteresis
> +
> +	temp<n>_auto_boost	temperature channel boost (PWMs to 100%) limit
> +
> +	temp<n>_auto_boost_hyst	temperature channel boost hysteresis
> +
> +	gpio			input state of 8 GPIO pins; read-only
> +

I'm really worried about this. So many non-standard file names! I
understand that some features are non-standard and deserve non-standard
names, but some features here are standard as far as I can see.
temp<n>_auto_base, temp<n>_auto_offset[1-12] and
temp<n>_auto_offset_hyst could be changed to fit in the standard
auto-pwm interface. Some other names (fan<n>_smart_tach,
pwm<n>_auto_spinup_min, pwm<n>_auto_spinup_time) could be discussed to
become part of the standard interface, as other chips have similar
functionalities.

If nobody is willing to work on this, then at least I would like the
lm93 driver to come with a big fat warning that the interface is not
standard and subject to change without notice anytime in the future.

> +Sample Configuration File
> +-------------------------
> +
> +Here is a sample LM93 chip config for sensors.conf:
> +
> +---------- cut here ----------
> +chip "lm93-*"
> +
> +# VOLTAGE INPUTS
> +
> +	# labels and scaling based on datasheet recommendations
> +	label in1	"+12V1"
> +	compute in1	@ * 12.945, @ / 12.945
> +	set in1_min	12 * 0.90
> +	set in1_max	12 * 1.10
> +
> +	label in2	"+12V2"
> +	compute in2	@ * 12.945, @ / 12.945
> +	set in2_min	12 * 0.90
> +	set in2_max	12 * 1.10
> +
> +	label in3	"+12V3"
> +	compute in3	@ * 12.945, @ / 12.945
> +	set in3_min	12 * 0.90
> +	set in3_max	12 * 1.10
> +
> +	label in4	"FSB_Vtt"
> +
> +	label in5	"3GIO"
> +
> +	label in6	"ICH_Core"
> +
> +	label in7	"Vccp1"
> +
> +	label in8	"Vccp2"
> +
> +	label in9	"+3.3V"
> +	set in9_min	3.3 * 0.90
> +	set in9_max	3.3 * 1.10
> +
> +	label in10	"+5V"
> +	set in10_min	5.0 * 0.90
> +	set in10_max	5.0 * 1.10
> +
> +	label in11	"SCSI_Core"
> +
> +	label in12	"Mem_Core"
> +
> +	label in13	"Mem_Vtt"
> +
> +	label in14	"Gbit_Core"
> +
> +	# Assuming R1/R2 = 4.1143, and 3.3V reference
> +	# -12V = (4.1143 + 1) * (@ - 3.3) + 3.3
> +	label in15	"-12V"
> +	compute in15 @ * 5.1143 - 13.57719, (@ + 13.57719) / 5.1143
> +	set in15_min	-12 * 0.90
> +	set in15_max	-12 * 1.10
> +
> +	label in16	"+3.3VSB"
> +	set in16_min	3.3 * 0.90
> +	set in16_max	3.3 * 1.10
> +
> +# TEMPERATURE INPUTS
> +
> +	label temp1	"CPU1"
> +	label temp2	"CPU2"
> +	label temp3	"LM93"
> +
> +# TACHOMETER INPUTS
> +
> +	label fan1	"Fan1"
> +	set fan1_min	3000
> +	label fan2	"Fan2"
> +	set fan2_min	3000
> +	label fan3	"Fan3"
> +	set fan3_min	3000
> +	label fan4	"Fan4"
> +	set fan4_min	3000
> +
> +# PWM OUTPUTS
> +
> +	label pwm1	"CPU1"
> +	label pwm2	"CPU2"

This belongs to userspace, I don't want this in the kernel
documentation. I would suggest to drop that part from the 2.4
documentation file as well. Why not add this to sensors.conf.eg like
all other chip drivers do?

> diff -Naur a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> --- a/drivers/hwmon/Kconfig	2005-10-20 08:23:05.000000000 +0200
> +++ b/drivers/hwmon/Kconfig	2005-10-23 18:21:24.059046000 +0200
> @@ -281,6 +281,17 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called lm92.
>  
> +config SENSORS_LM93
> +	tristate "National Semiconductor LM93 and compatibles"

There is no known LM93 compatible chip to date.

> diff -Naur a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
> --- a/drivers/hwmon/lm93.c	1970-01-01 01:00:00.000000000 +0100
> +++ b/drivers/hwmon/lm93.c	2005-10-23 21:22:55.000000000 +0200
> (...)
> +#include <linux/config.h>

Not needed.

OTOH, <linux/jiffies.h> would be needed and is missing.

> +static int disable_block = 0;
> +module_param(disable_block, bool, 0);
> +MODULE_PARM_DESC(disable_block,
> +	"Set to non-zero to disable SMBus block data transactions.");
> +
> +static int init = 0;
> +module_param(init, bool, 0);
> +MODULE_PARM_DESC(init, "Set to non-zero to force chip initialization.");
> +
> +static int vccp_limit_type[2] = {0,0};
> +module_param_array(vccp_limit_type, int, NULL, 0);
> +MODULE_PARM_DESC(vccp_limit_type, "Configures in7 and in8 limit modes.");
> +
> +static int vid_agtl = 0;
> +module_param(vid_agtl, int, 0);
> +MODULE_PARM_DESC(vid_agtl, "Configures VID pin input thresholds.");

Do not explicitely initialize static global variables to 0.

> +/* For each registered client, we need to keep some data in memory. That
> +   data is pointed to by client->data. The structure itself is dynamically
> +   allocated, at the same time the client itself is allocated. */

client->data is not supposed to be used directly. i2c_get_clientdata
should be used instead.

Not sure this comment is really worth keeping anyway. The code speaks
for itself and doesn't get out-of-date like such comments tend to
become.

> +struct lm93_data {

No i2c_client? See below.

> +	struct class_device *class_dev;
> +	struct semaphore lock;

This semaphore isn't used anywhere.

> +	enum chips type;

Not needed, there's a single type supported.

> +/* min, max, and nominal register values, per channel (u8) */
> +static const u8 lm93_vin_reg_min[16] = {
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xae,
> +};
> +static const u8 lm93_vin_reg_max[16] = {
> +	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +	0xff, 0xfa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xd1,
> +};
> +
> +/* min, max, and nominal voltage readings, per channel (mV)*/
> +static const unsigned long lm93_vin_val_min[16] = {
> +	0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 3000,
> +};
> +static const unsigned long lm93_vin_val_max[16] = {
> +	1236, 1236, 1236, 1600, 2000, 2000, 1600, 1600,
> +	4400, 6500, 3333, 2625, 1312, 1312, 1236, 3600,
> +};

This all suggests that 

> +/* 0 <= nr <= 3 */
> +static int LM93_TEMP_AUTO_OFFSET_FROM_REG(u8 reg, int nr, int mode)
> +{
> +	/* temp1-temp2 (nr=0,1) use lower nibble */
> +	if (nr < 2)
> +		return LM93_TEMP_OFFSET_FROM_REG(reg & 0x0f, mode);
> +
> +	/* temp3-temp4 (nr=2,3) use upper nibble */
> +	else
> +		return LM93_TEMP_OFFSET_FROM_REG(reg >> 4 & 0x0f, mode);
> +}

Add parentheses around (reg >> 4).

> +
> +/* TEMP: 1/10 degrees C (0C to +15C (mode 0) or +7.5C (mode non-zero))
> +   REG: 1.0C/bit (mode 0) or 0.5C/bit (mode non-zero)
> +   0 <= nr <= 3 */
> +static u8 LM93_TEMP_AUTO_OFFSET_TO_REG(u8 old, int off, int nr, int mode)
> +{
> +	u8 new = LM93_TEMP_OFFSET_TO_REG(off, mode);
> +
> +	/* temp1-temp2 (nr=0,1) use lower nibble */
> +	if (nr < 2)
> +		return (old & 0xf0) | (new & 0x0f);
> +
> +	/* temp3-temp4 (nr=2,3) use upper nibble */
> +	else
> +		return (new << 4 & 0xf0) | (old & 0x0f);
> +}

Same here, and several times after that in the rest of the file.

> +/* alarm bitmask definitions
> +   The LM93 has nearly 64 bits of error status... I've pared that down to
> +   what I think is a useful subset in order to fit it into 32 bits.
> +
> +   Especially note that the #VRD_HOT alarms are missing because we provide
> +   that information as values in another /proc file.
> +
> +   If libsensors is extended to support 64 bit values, this could be revisited.
> +*/

It's very unlikely that libsensors will ever support 64 bit values.
Instead, splitting the value into multiple files would make sense:
  alarms_in
  alarms_temp
  alarms_fan
These would preferably be standard, i.e. all bits used in order and
matching the input number, rather than respecting the arbitrary
internal order of the chip. This would let us stop defining ALARM
bitmasks for libsensors in our 2.4 drivers.

Note that this (or something similar) is required if we want a
chip-indepdent sysfs interface. This is also very convenient for
2.6-only drivers.

> +#define LM93_ALARM_IN1		0x00000001
> +#define LM93_ALARM_IN2		0x00000002
> +#define LM93_ALARM_IN3		0x00000004
> +#define LM93_ALARM_IN4		0x00000008
> +#define LM93_ALARM_IN5		0x00000010
> +#define LM93_ALARM_IN6		0x00000020
> +#define LM93_ALARM_IN7		0x00000040
> +#define LM93_ALARM_IN8		0x00000080
> +#define LM93_ALARM_IN9		0x00000100
> +#define LM93_ALARM_IN10		0x00000200
> +#define LM93_ALARM_IN11		0x00000400
> +#define LM93_ALARM_IN12		0x00000800
> +#define LM93_ALARM_IN13		0x00001000
> +#define LM93_ALARM_IN14		0x00002000
> +#define LM93_ALARM_IN15		0x00004000
> +#define LM93_ALARM_IN16		0x00008000
> +#define LM93_ALARM_FAN1		0x00010000
> +#define LM93_ALARM_FAN2		0x00020000
> +#define LM93_ALARM_FAN3		0x00040000
> +#define LM93_ALARM_FAN4		0x00080000
> +#define LM93_ALARM_PH1_ERR	0x00100000
> +#define LM93_ALARM_PH2_ERR	0x00200000
> +#define LM93_ALARM_SCSI1_ERR	0x00400000
> +#define LM93_ALARM_SCSI2_ERR	0x00800000
> +#define LM93_ALARM_DVDDP1_ERR	0x01000000
> +#define LM93_ALARM_DVDDP2_ERR	0x02000000
> +#define LM93_ALARM_D1_ERR	0x04000000
> +#define LM93_ALARM_D2_ERR	0x08000000
> +#define LM93_ALARM_TEMP1	0x10000000
> +#define LM93_ALARM_TEMP2	0x20000000
> +#define LM93_ALARM_TEMP3	0x40000000

All these defines don't belong there.

> +#define show_in_reg(rop,ROP) \

"rop"?

> +static ssize_t show_temp_auto_offset(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
> +	int nr = s_attr->index & 0xFF;
> +	int ofs = (s_attr->index >> 8) & 0xFF;

What are these maskings for?

> +static ssize_t store_fan_smart_tach(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
> +	int nr = s_attr->index;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	down(&data->update_lock);
> +
> +	/* sanity test, ignore the write otherwise */
> +	if (0 <= val && val <= 2) {

No, don't ignore it. Return an error instead.

> +		/* can't enable if pwm freq is 22.5KHz */
> +		if (val) {
> +			u8 ctl4 = lm93_read_byte(client,
> +				LM93_REG_PWM_CTL(val-1,LM93_PWM_CTL4));

Missing space after comma. And there are many many mores all around in
the file.

> +static u8 lm93_block_buffer[I2C_SMBUS_BLOCK_MAX];
> +
> +/*
> +	read block data into values, retry if not expected length
> +	fbn => index to lm93_block_read_cmds table
> +		(Fixed Block Number - section 14.5.2 of LM93 datasheet)
> +*/
> +static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
> +{
> +	int i, result=0;
> +
> +	for (i = 1; i <= MAX_RETRIES; i++) {
> +		result = i2c_smbus_read_block_data(client, 
> +			lm93_block_read_cmds[fbn].cmd, lm93_block_buffer);
> +
> +		if (result = lm93_block_read_cmds[fbn].len) {
> +			break;
> +		} else {
> +			dev_warn(&client->dev, "lm93: block read data failed, "
> +				 "command 0x%02x.\n", 
> +				 lm93_block_read_cmds[fbn].cmd);
> +			mdelay(i + 3);
> +		}
> +	}
> +
> +	if (result = lm93_block_read_cmds[fbn].len) {
> +		memcpy(values,lm93_block_buffer,lm93_block_read_cmds[fbn].len);
> +	} else {
> +		/* <TODO> what to do in case of error? */
> +	}
> +}

lm93_block_buffer should be local to lm93_read_block.

In case of error, we should at least print a message in the logs, like
the other read functions do.

> +static struct lm93_data *lm93_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	const unsigned long interval = HZ + (HZ / 2);
> +
> +	down(&data->update_lock);
> +
> +	if (time_after(jiffies - data->last_updated, interval) ||
> +		time_before(jiffies, data->last_updated) || !data->valid) {

I don't see how the time_before part is needed. The other drivers don't
have it. time_after takes care of the jiffies value wrapping just fine.

> +static int lm93_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> (...)
> +	if (!(client = kzalloc(sizeof(struct i2c_client) +
> +			       sizeof(struct lm93_data), GFP_KERNEL))) {
> +		dev_dbg(&adapter->dev, "lm93: out of memory!\n");
> +		err = -ENOMEM;
> +		goto ERROR0;
> +	}

This is an old-style memory allocation model we are no more using since
April 2004. Even revision 1.1 of the lm93 driver in lm_sensors CVS does
not use it. Can anyone explain where this code does come from?

Please fix this kzalloc call.

> +static int lm93_detach_client(struct i2c_client *client)
> +{
> +	struct lm93_data *data = i2c_get_clientdata(client);
> +	int err = 0;
> +
> +	if (data)
> +		hwmon_device_unregister(data->class_dev);

How could data be NULL?

> +
> +	if ((err = i2c_detach_client(client))) {
> +		dev_err(&client->dev, "lm93: Client deregistration failed; "
> +			"client not detached.\n");
> +	}

Missing return, we can't free the client data if for some reason we
failed to detach it. Also, the error message was refactored into
i2c_detach_client, so it can be dropped here.

Anyone willing to review the code is welcome to do so. It's so large
that it would be very surprising that no bug are left it.

We also need someone to test this code in deep, on a real LM93 chip,
before we can put this in Linux 2.6.

Thanks,
-- 
Jean Delvare
