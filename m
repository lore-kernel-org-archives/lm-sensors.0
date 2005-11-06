From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 06 Nov 2005 17:00:54 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <20051106170022.5c6a5bda.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

> Updated patch attached.  I love it when you inherit loads of code that you
> end up fixing... :-)

I finished reviewing your code (at last! sorry for the delay), here we go.

First of all, please delete all trailing whitespace in vt8231.c. There
are a lot of these.

And a generic comment: I *know* that some of the problems here are
not yours, they come from the original driver. Don't take it
personally ;) but we need to fix them all before the driver can
be accepted in Linux 2.6.

> diff -Naur reference/drivers/hwmon/Kconfig linux-2.6.14/drivers/hwmon/Kconfig
> --- reference/drivers/hwmon/Kconfig	2005-10-28 01:02:08.000000000 +0100
> +++ linux-2.6.14/drivers/hwmon/Kconfig	2005-11-01 17:35:18.000000000 +0000
> @@ -350,6 +350,18 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called via686a.
>  
> +config SENSORS_VT8231
> +	tristate "VT8231"
> +	depends on HWMON && I2C && PCI && EXPERIMENTAL
> +	select HWMON_VID
> +	select I2C_ISA
> +	help
> +	  If you say yes here then you get support for the integrated sensors
> +	  in the Via VT8231 device.

VIA should never be spelled Via.

> diff -Naur reference/drivers/hwmon/vt8231.c linux-2.6.14/drivers/hwmon/vt8231.c
> --- reference/drivers/hwmon/vt8231.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.14/drivers/hwmon/vt8231.c	2005-11-01 18:06:17.000000000 +0000
> @@ -0,0 +1,785 @@
> +static int force_addr;
> +module_param(force_addr, int,0644);
> +MODULE_PARM_DESC(force_addr, "Initialize the base address of the sensors");

The "0644" doesn't make sense. It means that a sysfs file will be created
for this parameter. Given that the parameter is only needed at
initialization time, the created file will be of no use. Use "0" to
not create a file.

Also, missing space before comma.

> +/* pwm numbered 1-2 */
> +#define VT8231_REG_PWM(nr) (0x5f + (nr))
> +#define VT8231_REG_PWM_CTL 0x51
> +
> +/* The VT8231 registers */

You could move the PWM register definitions below, else that comment
is somewhat confusing.

> +/* We define the sensors as follows. Somewhat convoluted to minimize
> +   changes from via686a.
> +	Sensor		Voltage Mode	Temp Mode
> +	--------	------------	---------
> +	Reading 1			temp3
> +	Reading 3			temp1	not in vt8231
> +	UCH1/Reading2	in0		temp2
> +	UCH2		in1		temp4
> +	UCH3		in2		temp5
> +	UCH4		in3		temp6
> +	UCH5		in4		temp7
> +	3.3V		in5
> +	-12V		in6			not in vt8231
> +*/

What is the benefit in mentioning the inputs which the VT8231 does not
have?

It's a bit confusing (and non-standard) to have temperatures starting
at temp2 :(

> +static const u8 regtemp[] = { 0x20, 0x21, 0x1f, 0x22, 0x23, 0x24, 0x25 };
> +static const u8 regover[] = { 0x39, 0x3d, 0x1d, 0x2b, 0x2d, 0x2f, 0x31 };
> +static const u8 reghyst[] = { 0x3a, 0x3e, 0x1e, 0x2c, 0x2e, 0x30, 0x32 };
> +
> +/* temps numbered 1-7 */

So that would be 2-7. This suggests that the first "column" in the above
arrays is never used, so it should be deleted.

> +#define ALARMS_FROM_REG(val) (val)

Please discard that macro and use the value directly instead.

> +#define DIV_TO_REG(val) ((val)=8?3:(val)=4?2:(val)=1?0:1)

In Linux 2.6 we have changed to a different strategy. Instead of
defaulting to an arbitrary divider value when an unsupported value
is requested, we report the error to userspace. See the various other
Linux 2.6 drivers for examples.

> +#define PWM_FROM_REG(val) (val)

You can drop that one too.

> +#define PWM_TO_REG(val) SENSORS_LIMIT((val), 0, 255)

For this one too, it is advisable to return an error on invalid
values. See it87.c for an example.

> +#define TEMP_FROM_REG(val) (long)((val)*10)
> +#define TEMP_FROM_REG10(val) (long)(((val)*10)/4)
> +#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
> +			 ((val)+5)/10), 0, 255))

These do not look correct to me. They suggest that you are exporting
the values to userspace with LSB = 0.1 degree C. The standard is 0.001
degree C, as documented in Documentation/hwmon/sysfs-interface. I am
surprised that you got correct temperature readings, unless you also
hacked libsensors.

Looking further in sensors.conf.eg, it looks like the VT8231 expresses
each temperature as a voltage, which libsensors then converts to a
temperature. This is a rare, but not unique, case. The pc87360
driver does something similar for temp4-6. In this case, the value
must be exported in sysfs with LSB = 1 mV, as voltages do.

Even then, the formulas in sensors.conf.eg look very complex to me.
We will have to look into that and make some sense out of them

> +#define IN_FROM_REG(val) ((long)(val))
> +#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 5)/10), 0, 255))

Voltage values must be exported to userspace with LSB = 1 mV, this
is a standard. This doesn't seem to be the case here. IN_TO_REG is also
nonsensical: you multiply by 10, then immediately divide the result by
10?

Seeing the conversion formulas in sensors.conf.eg, I think I understand
that the VT8231 differs much from the other chips. Most of the conversion
formula (the common part) should be moved inside the driver if we want
to respect the sysfs standard. This will break the compatibility between
the 2.4 and the 2.6 vt8231 drivers, but we don't seem to have the choice.

> +static inline int vt8231_read_value(struct i2c_client *client, u8 reg)
> +{
> +	return (inb_p(client->addr + reg));
> +}

Please drop the redundant parentheses.

> +/* following are the sysfs callback functions */

Generic comment about sysfs callback functions:

A new possibility, known as "dynamic sysfs callbacks", was recently
introduced. Not all hardware monitoring drivers use it yet, but I would
like new drivers to do, so that we don't have to convert them later.

These dynamic callbacks let you get rid of a large part of the macros
above, by giving you the possibility to pass an integer parameter to
the callback functions, making it possible to use the same callback
function for several sysfs files.

See the it87 driver for an example. If would be very great if you could
convert the vt8231 driver to do the same. This greatly improves the code
readability, and makes the compiled object significantly smaller as
well.

> +static ssize_t set_in_min(struct device *dev, const char *buf, 
> +		size_t count, int nr) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct vt8231_data *data = i2c_get_clientdata(client);
> +	unsigned long val = simple_strtoul(buf, NULL, 10);
> +	data->in_min[nr] = IN_TO_REG(val);
> +	vt8231_write_value(client, VT8231_REG_IN_MIN(nr), 
> +			data->in_min[nr]);
> +	return count;
> +}

All "set" callback functions should hold data->update_lock while they
manipulate any data field. If not, you have a race condition if another
sysfs file is being read (triggering an update) while you write to this
one.

See any other hwmon files for an example, it's really easy.

> +/* show_temp_offset(1); */

Delete that line, no point in keeping comments about something which
doesn't exist.

> +/**** VRM and VID *****/
> +static ssize_t show_vid(struct device *dev, struct device_attribute *attr, 
> +			char *buf) {
> +	struct vt8231_data *data = vt8231_update_device(dev);
> +	return sprintf(buf, "%ld\n", (long)vid_from_reg(data->cpu0_vid, data->vrm)); 
> +}

The (long) cast is not needed, simply use %d instead of %ld.

> +static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
> +
> +static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, 
> +			char *buf) {
> +	struct vt8231_data *data = vt8231_update_device(dev);
> +	return sprintf(buf, "%ld\n", (long)data->vrm);
> +}

Same here.

> +static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, 
> +			const char *buf, size_t count) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct vt8231_data *data = i2c_get_clientdata(client);
> +	int val = simple_strtol(buf, NULL, 10);
> +	printk("Setting VRM to \"%s\" = %d\n", buf, val);
> +	data->vrm = val;
> +	return count;
> +}

Drop that printk, it's pretty useless.

> +int vt8231_detect(struct i2c_adapter *adapter)
> +{
> (...)
> +	/* Reserve the ISA region */
> +	if (!request_region(isa_address, VT8231_EXTENT, type_name)) {
> +		dev_err(&adapter->dev, "region 0x%x already in use!\n", 
> +			   isa_address);
> +		return -ENODEV;
> +	}

Please use vt8231_pci_driver.name to reserve the region (you'll need
to forward-declare it).

> +	if (!(data = kzalloc(sizeof(struct vt8231_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		goto exit_release;
> +	}
> +
> (...)
> +	new_client->flags = 0;

I don't think you need to explicitely set it to 0, as kzalloc did it
for you. We'd need to fix all other drivers too.


> +	/* Fill in the remaining client fields and put into the global list */
> +	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);

As this is now the only usage of type_name, you'd better put the string
verbatim here.

You forgot to create sysfs files for PWM?

> +static int vt8231_detach_client(struct i2c_client *client)
> +{
> (...)
> +	if ((err = i2c_detach_client(client))) {
> +		dev_err(&client->dev, 
> +		   "Client deregistration failed, client not detached.\n");
> +		return err;
> +	}

Please drop the log message, it was refactored into i2c_detach_client
some times ago.

> +	release_region(client->addr, VT8231_EXTENT);
> +	kfree(i2c_get_clientdata(client));

You can user "data" instead.

> +static struct vt8231_data *vt8231_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct vt8231_data *data = i2c_get_clientdata(client);
> +	int i, j;
> +
> +	down(&data->update_lock);
> +
> +	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
> +		(jiffies < data->last_updated) || !data->valid) {

Use time_after() instead of direct jiffies comparisons.

> +		data->uch_config = vt8231_read_value(client, 
> +						VT8231_REG_UCH_CONFIG);

I now realize that there is no sysfs file to change this value.
I'm fine with that, as I believe this is the BIOS' job to properly
configure the chip. However, we should then be consistent and
modify the other parts of the driver accordingly. In particular,
the driver should not create the sysfs files for the channels which
are not in use. That way, the code below wouldn't have to repeatedly
set unused values to 0.

> +		for (i = 0; i <= 5; i++) {
> +			if(ISVOLT(i, data->uch_config)) {
> +				data->in[i] = vt8231_read_value(client, 
> +							VT8231_REG_IN(i));
> +				data->in_min[i] = vt8231_read_value(client, 
> +							VT8231_REG_IN_MIN(i));
> +				data->in_max[i] = vt8231_read_value(client, 
> +							VT8231_REG_IN_MAX(i));
> +			} else {
> +				data->in[i] = 0;
> +				data->in_min[i] = 0;
> +				data->in_max[i] = 0;
> +			}
> +		}

I'd have a clear preference for "< 6" instead of <=5.

> +		for (i = 2; i <= 7; i++) {
> +			if(ISTEMP(i, data->uch_config)) {
> +				data->temp[i - 1] = vt8231_read_value(client, 
> +						       VT8231_REG_TEMP(i)) << 2;
> +				switch(i) {
> +					case 1:
> +						/* ? */
> +						j = 0;
> +						break;

This case can obviously be dropped.

> +					case 2:
> +						j = (vt8231_read_value(client, 
> +							VT8231_REG_TEMP_LOW2) &
> +							0x30) >> 4;
> +						break;
> +					case 3:
> +						j = (vt8231_read_value(client, 
> +							VT8231_REG_TEMP_LOW3) &
> +							0xc0) >> 6;
> +						break;
> +					case 4:
> +					case 5:
> +					case 6:
> +					case 7:
> +					default:

Either keep only default, or drop it.

> +						j = (vt8231_read_value(client, 
> +						  	VT8231_REG_TEMP_LOW47)
> +							 >> ((i-4)*2)) & 0x03;	
> +						break;
> +	
> +				}
> (...)
> +		for (i = 1; i <= 2; i++) {
> +			data->fan[i - 1] = vt8231_read_value(client, 
> +						VT8231_REG_FAN(i));
> +			data->fan_min[i - 1] = vt8231_read_value(client, 
> +						VT8231_REG_FAN_MIN(i));
> +			data->pwm[i - 1] = vt8231_read_value(client, 
> +						VT8231_REG_PWM(i));
> +		}

I don't get it. We already read the fan registers earlier in this
function!

> +		data->cpu0_vid= vt8231_read_value(client, VT8231_REG_VID) 
> +					& 0x1f;

Missing space before "=" sign.

> +static struct pci_device_id vt8231_pci_ids[] = {
> +	{
> +		.vendor		 = PCI_VENDOR_ID_VIA, 
> +		.device		 = PCI_DEVICE_ID_VIA_8231_4, 
> +		.subvendor	= PCI_ANY_ID, 
> +		.subdevice	= PCI_ANY_ID, 
> +	}, 
> +	{ 0, }
> +};

Please use the PCI_DEVICE macro. Also add a call to
MODULE_DEVICE_TABLE (see via686a).

> +static int __devinit vt8231_pci_probe(struct pci_dev *dev, 
> +				const struct pci_device_id *id)
> +{
> (...)
> +	if (force_addr)
> +		isa_address = force_addr; /* so detect will get called */

No more needed, detect will get called anyway.

> +	if (!isa_address) {
> +		dev_err(&dev->dev, "No Via 8231 sensors found.\n");
> +		return -ENODEV;
> +	}

Drop that test, it was previously unneeded if you read the
code carefully, and now it is a bug.

> +static void __exit sm_vt8231_exit(void)
> +{
> +	pci_unregister_driver(&vt8231_pci_driver);
> +	if (s_bridge != NULL) {
> +		i2c_isa_del_driver(&vt8231_driver);
> +		pci_dev_put(s_bridge);
> +		s_bridge = NULL;
> +	}
> +}
> +
> +

Drop the second blank line.

"Other than that, it's OK" as I use to say ;)

Yeah, I know there are many many fixes needed. But nothing impossible
if you are motivated enough. And if you have questions we're here to
answer them.

I now answer your other questions:

> I am not so sure I am very keen on the intelligence for the auto-div
> calculation moving into the driver.  I think this code should be in the
> sensors utility.

There was a debate long ago about this. Some people (at least Mark M.
Hoffman) advocated a user-space solution. I tend to agree in general
that putting policy into the kernel is bad, and also about the fact
that drivers must be as simple as possible. However, after checking the
facts, I came to the conclusion that doing this in the kernel was OK.
The main reason is that a user-space helper would need to know many
things which the drivers do not currently export: the list of divider
for each fan input, either the clock frequency, the register width.
Additionally, letting userspace change the divider means that the
driver needs additional code to preserve the min limit when this
happens. As I found I'd need more code to do all this than the
in-driver auto-fan-div takes, I decided for that second option.

Anyway, not all drivers do that. Those which do use slightly different
rules. It's not all settled yet. If anyone provides a userspace daemon
and modifies some drivers so that we can see how the userspace approach
would work, that's fine with me.

> On the other hand, however, the way the DIV_TO_REG() function was coded, it
> would be almost impossible for any application to determine the legal values
> for DIV without knowing the details of the device.  Any illegal value would
> end up with DIV set at zero - not very helpful.

The old code defaulted to a divider of 2 actually. But see my comments
in the code above, 2.6 does things differently.

> As an alternative, this
> attached patch includes a code revision that sets DIV to the smallest legal
> DIV value that is the same as or larger than the requested DIV value.
> Hence, the mapping is as below:
> 
> 	Requested DIV   Set DIV
> 		1		1
> 		2		2
> 		3		4
> 		4		4
> 		5		8
> 		6		8
> 		7		8
> 		8		8
> 		8+		8

I prefer an explicit -EINVAL with no divider change on invalid value,
as all drivers in 2.6 now tend to do.

> From this sequence, the DIV returned is predictable and an application can
> very quickly determine the legal DIV values and make its calculations
> accordingly.
> 
> With this revised code, if you ask for a low limit 1000 RPM with a divisor
> of 4, you get a low limit of 1285 RPM returned.  If you ask for a low limit
> of 1000 RPM with a divisor of 5 then you get a low limit of 999 RPM returned
> with a divisor of 8.

The div returned is not predictable. Some chips have dividers up to
128. Some chips (it87) have different rules for the different channels
(fan3 only has possible dividers 2 and 8). Unless the chip explicitely
lists the possible dividers, there is no possible auto-div
implementation in user-space. We are *not* going to set random div
values and see if it works. This would generate actual register writes
and execute a lot of code. Let's not probe for something we already
have the knowledge of and simply needs to be exported.

Also, the only thing all chips share is the fact that the dividers are
powers of 2. So it's pretty pointless to try to support other inputs
from user-space. Nobody sane will try them.

> Consider the pseudo-code below:
> 
> set_div = 1;
> set_rpm_div(set_div);
> set_low_limit_rpm(requested_limit_rpm);
> 
> while( get_low_limit_rpm() > requested_limit_rpm )
> {
> 	true_div = get_rpm_div();
> 	if (set_div > true_div)
> 	{
> 		break; // we have exceeded the DIV range
> 	}
> 	// Try next div value
> 	set_div = true_div + 1;
> 	set_rpm_div(set_div);
> 	set_low_limit_rpm(requested_limit_rpm);
> }
> 
> This will iterate through the valid DIV values and stop when it reaches the
> best RPM match or the highest valid DIV setting.

Sorry, I can't make any sense of this pseudo code. What part is in user
space? What part is in the driver? "set_low_limit_rpm" can mean about
anything. It can be in userspace (sensors, libsensors), it can be a
request to the driver, it can be a register write.

If you want to propose something, please explain it with words.

> I feel that this should be up in the application, however, and not in the
> driver.  IMHO, the drivers should be a simple as possible.

As said above, I usually tend to agree, but in the facts, in this one
case, the code is much more simple and efficient when in the drivers.

It would probably make sense to have a helper module for all drivers
though, so as to not duplicate the code.

Thanks,
-- 
Jean Delvare
