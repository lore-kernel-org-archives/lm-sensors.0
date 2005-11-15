From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Nov 2005 20:14:01 +0000
Subject: [lm-sensors] RE: vt8231.c and VRM-VID
Message-Id: <20051115201421.0d6ab38f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051108155337.7896512E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051108155337.7896512E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

Once again, sorry for the delay. Hopefully we're not too far from a
version of the vt8231 driver which would be acceptable for integration
into Linux 2.6.

> Sorry to keep sending more patches...  When I tried Rudolf's patch
> for the VRM, I couldn't get the VID to work properly.  On
> investigation, it turned out that this register ALSO does not exist
> on the VT8231.  Whoever ported the original code to the VT8231
> didn't check that all the registers ACTUALLY EXISTED on the VT8231
> device!!!  No comment.
> 
> Anyhow, I have now checked that all the registers left do actually
> exist and that the driver isn't reading garbage from the device.
> This has resulted in the removal of the PWM controls (as in my mail
> below) and now also the VID detection as this isn't supported in
> the chip either.

I share your feelings. Once again I'd like Mark to comment on this. If
these registers really do not exist, then we should drop support from
the Linux 2.4 driver and libsensors as well. I'm guessing that the
dead code is simply a legacy from vt1211.c, but I don't have a
datasheet for the VT1211 chip so I can't really tell. Does anyone have
a datasheet?

> I also tidied up my code changes for creating the temp/voltage
> files.  Don't know what planet I was on with the original code - it
> was horrible.

I didn't remember it was, but well, that was long ago ;)

> Anyhow, revision 4 is attached.  Hopefully this is the last one.

It's not, but you always need to hope :)

> Rudolf's VRM patch works perfectly BTW, and has ended up in this
> revision 4 code release as it is part of the updated kernel HWMON
> source I am now working from.  I hope that this isn't a problem - I
> can always remove that section of the patch and send a revised
> version if it is.

When you submit a patch for review, it is ALWAYS to your advantage that
the patch is as small as possible, because people are likely to be
short on time *cough* so you better don't frighten them. And the
cleaner the patch, the higher the review probability.

You should consider using quilt [1] or a similar tool to handle your
patches. It would solve this issue, would help you get rid of trailing
whitespace, and would also let you add diffstat output to the patch
file, which is very convenient for the reviewer.

[1] http://savannah.nongnu.org/projects/quilt

To the code itself now...

First of all: there isn't much left from Mark's original code in the
new driver. Aaron and you did the work. You should just credit Mark
for writing the Linux 2.4 driver in the first place, but make it
clearer that Aaron and you wrote this one driver. In particular, you
could set youself as the MODULE_AUTHOR.

Side question, would you accept to become the maintainer for the
Linux 2.6 version of the vt8231 driver once it is in?

I'm not detailing on the fact that temp0 cannot be used, I've said it
before already.

>    The default value for the input channel configuration is used (Reg 0x4A=0x07)
>    which sets the selected inputs marked with '*' below if multiple options are
>    possible:

I'm not sure I agree with the "default value" here. Do you refer to the
power-up default value for this register? What you should really trust
is the value the driver will read from this register. This gives the
BIOS a chance to setup the chip properly according to the hardware
setup. Looks like this is what the driver does, but this comment could
be clearer about that.

> /* ins numbered 0-5 */
> /* fans numbered 1-2 */
> #define VT8231_REG_FAN_MIN(nr) (0x3a + (nr))
> #define VT8231_REG_FAN(nr)	 (0x28 + (nr))
> 
> static const u8 regtemp[]    = { 0x1f, 0x21, 0x22, 0x23, 0x24, 0x25 };
> static const u8 regtempmax[] = { 0x39, 0x3d, 0x2b, 0x2d, 0x2f, 0x31 };
> static const u8 regtempmin[] = { 0x3a, 0x3e, 0x2c, 0x2e, 0x30, 0x32 };
> 
> static const u8 regvolt[]    = { 0x21, 0x22, 0x23, 0x24, 0x25, 0x26 };
> static const u8 regvoltmax[] = { 0x3d, 0x2b, 0x2d, 0x2f, 0x31, 0x33 };
> static const u8 regvoltmin[] = { 0x3e, 0x2c, 0x2e, 0x30, 0x32, 0x34 };
> 
> /* temps numbered 0-5 */
> #define VT8231_REG_TEMP_LOW01	0x49
> #define VT8231_REG_TEMP_LOW25	0x4d

Can you please reorder it all so that the comments will properly
preceed the register definitions they refer to? Also, the fan
macros are weirdly misaligned.

> /* temps 0-5 */
> #define ISTEMP(i, ch_config) ((i) < 0 ? 0 : \
> 			      (i) = 0 ? 1 : \
> 			      (i) > 5 ? 0 : \
> 			      ((ch_config) >> ((i)+1)) & 0x01)
> /* voltages 0-6 */
> #define ISVOLT(i, ch_config) ((i) < 0 ? 0 : \
> 			      (i) > 5 ? 0 : \
> 			      (i) = 5 ? 1 : \
> 			      !(((ch_config) >> ((i)+2)) & 0x01))

The "< 0" and "> 5" tests shouldn't be needed, right? Don't have
these macros handle values they should never be called with please.
You're not preventing bugs from happening by doing so, but will make
them harder to track.

Also, isn't it rather voltages 0-_5_?

> /* NB  The values returned here are NOT temperatures.  The calibration curves
> **     for the thermistor curves are board-specific and must go in the
> **     sensors.conf file.  Temperature sensors 0 and 1 are ten bits, whilst
> **     temperature sensors 2-5 are eight bits, so we scale all the values to be
> **     equivalent to ten bits for consistency.

This doesn't seem to match the code. Isn't VT8231_REG_TEMP_LOW25
supposed to contain the 2 lower bits of temperature channels 2-5?

> **     TEMP_TO_REG() sets the hardware comparisons and these are all use the 8 
> **     MSBs so we apply scaling in the macro to compensate.

Rephrase please.

> */
> #define TEMP_TO_REG(val) (SENSORS_LIMIT((val)>>2, 0, 255))

Doesn't look right to me. I'd expect something like:

#define TEMP_TO_REG(val) SENSORS_LIMIT(((val) + 500) / 1000, 0, 255)

Note that you can safely drop the outermost pair of parentheses here.

I'm also quite surprised that you have a single conversion macro
for the thermistor-based and the diode-based channels.

> #define IN_TO_REG(val)   (SENSORS_LIMIT((val), 0, 255))

This doesn't make much sense. Please include all the conversion
factors into the macro. If you don't want to or cannot, just discard
this macro and call SENSORS_LIMIT directly.

> /* But this chip saturates back at 0, not at 255 like all the other chips.
>    So, 0 means 0 RPM */

Please drop the meaningless "but".

> static inline u8 FAN_TO_REG(long rpm, int div)
> {
> 	if (rpm = 0)
> 		return 0;
> 	return SENSORS_LIMIT((1310720 + rpm * div / 2) / (rpm * div), 1, 255);
> }
> 
> #define FAN_FROM_REG(val, div) ((val)=0?0:1310720/((val)*(div)))

Isn't it a bit odd to round in one direction but truncate in the other?
Quite frankly I wouldn't bother rounding at all. Due to the way the
measurement is done, the values we manipulate are already truncated
anyway.

> 	u16 temp[6];		/* Register value 10 bit */

Please say in the comment if the 10 bits are aligned on the left or right.

>	u8 vrm;

Isn't it supposed to be gone? I see may references remaining in the code.
vrm is useless for a chip without VID inputs!

> 	u8 uch_config;

You only use this one as a local variable each time, so you don't have
to make is a member of this structure. But see below.

> static int vt8231_detect(struct i2c_adapter *adapter);
> static int vt8231_detach_client(struct i2c_client *client);
> (...)
> static struct vt8231_data *vt8231_update_device(struct device *dev);
> static void vt8231_init_client(struct i2c_client *client);

You could group all forward declarations together.

> static ssize_t show_in(struct device *dev, struct device_attribute *attr,
> 		char *buf)
> {
> 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> 	int nr = sensor_attr->index;

I see you are now using dynamic callbacks. This is great :)

> 	switch(nr)
> 	{

Iirk. Watch your coding style. Space between "switch" and the opening
parenthesis. Opening curly brace goes at the end of the line.

I will not notify the same coding style error again, as it would be
quite boring to read, but please check the whole file when I tell you
about any coding style issue. Same holds for a number of other
comments, BTW.

> 		case 5: // in5 is scaled to 3.3v internally
> 			// No floating point so 1/(0.0958*0.6296 ~= 1657/100 

No C++ style comments please. Capital V for Volt. Missing closing
parenthesis too.

> 			return sprintf(buf, "%d\n", 
> 				(int)(((data->in[nr] - 3) * 1657) / 100));

Useless cast?

I would write it: 
  (data->in[nr] - 3) * 10000 / (958 * 20 / 54)
This is way easier to check against the datasheet. I think the
compiler will handle the arithmetics anyway so the final code is just
as fast.

> 		default:
> 			// No floating point so 1/(0.0958 ~= 1044/100 
> 			return sprintf(buf, "%d\n", 
> 				(int)(((data->in[nr] - 3) * 1044) / 100));
> 	};
> }

Ditto. Also, it is obvious to me that you should have two seperate
sysfs callbacks, one for in5 and one for the other ins. Do not abuse
the dynamic sysfs callback mechanism.

You have an unneeded semi-colon at the end of the switch statement,
please clear it. Also note that it is common to omit the extra
indentation for case labels, so as to keep the intentation depth
to a minimum.

> #define show_in_offset(offset)					\
> static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,		\
> 		show_in, NULL, offset);
> #define limit_in_offset(offset)					\
> 
> static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
> 		show_in_min, set_in_min, offset);		\
> static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
> 		show_in_max, set_in_max, offset);

These macros shouldn't have a trailing semi-colon, as the caller will
add one. Also, why did you define two separate macros? You're calling
them in pairs anyway.

> /* 3 temperatures */

Not really. I'd say "Up to 6 temperatures".

> static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
> 		char *buf)
> {
> 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> 	int nr = sensor_attr->index;
> 	struct vt8231_data *data = vt8231_update_device(dev);
> 	return sprintf(buf, "%d\n",  data->temp[nr]);
> }

That would be data->temp[nr] * 250, at least for the diode-based one.
The thermistor-based would need some extra computation I think.

> 	vt8231_write_value(client, regtempmin[nr],
>			data->temp_min[nr]);

Fits on a single line.

> struct strDeviceAttrTable cfgInfoTemp[] = {
> 	CFG_INFO_TEMP(0),
> 	CFG_INFO_TEMP(1),
> 	CFG_INFO_TEMP(2),
> 	CFG_INFO_TEMP(3),
> 	CFG_INFO_TEMP(4),
> 	CFG_INFO_TEMP(5),
> 	{ .id = -1 }
> };
> 
> struct strDeviceAttrTable cfgInfoVolt[] = {
> 	CFG_INFO_VOLT(0),
> 	CFG_INFO_VOLT(1),
> 	CFG_INFO_VOLT(2),
> 	CFG_INFO_VOLT(3),
> 	CFG_INFO_VOLT(4),
> 	CFG_INFO_VOLT(5),
> 	{ .id = -1 }
> };

These should be defined static.

Another general note: the kernel developers usually avoid
mixedCaseVarNames. This is C, not Java.

> 	return sprintf(buf, "%d\n",
> 		FAN_FROM_REG(data->fan_min[nr],
> 			DIV_FROM_REG(data->fan_div[nr])));

Fits in one less line.

> static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
> 		const char *buf, size_t count)
> {
> 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> 	int nr = sensor_attr->index - 1;
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct vt8231_data *data = i2c_get_clientdata(client);
> 	int val = simple_strtoul(buf, NULL, 10);
> 	down(&data->update_lock);
> 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
> 	vt8231_write_value(client, VT8231_REG_FAN_MIN(nr+1), data->fan_min[nr]);
> 	up(&data->update_lock);
> 	return count;
> }

Starts being quite dense... Maybe you could add a blank line before
down()? It would also be more efficient to have the "- 1" offset at
the sysfs file creation rather than in the callback.

> 	down(&data->update_lock);
> 	int old = vt8231_read_value(client, VT8231_REG_FANDIV);

Variable declarations must precede any code. The register read
doesn't need to happen with the lock held anyway.

> 			dev_err(&client->dev, "fan_div value %ld not "
> 			      "supported. Choose one of 1, 2, 4 or 8!\n", val);

Indentation.

It's considered good practice that the fan min limit is preserved when
the fan clock divider changes. Most drivers in Linux 2.6 now do.

> /**** VRM and VID *****/

This part can go away entirely.

> static struct i2c_driver vt8231_driver = {
> 	.owner		= THIS_MODULE,
> 	.name		= "vt8231",
> 	.id		= I2C_DRIVERID_VT8231,
> 	.flags		= I2C_DF_NOTIFY,
> 	.attach_adapter	= vt8231_detect,
> 	.detach_client	= vt8231_detach_client,
> };

You don't need I2C_DF_NOTIFY for ISA drivers no more. You don't need
no .id either.

> 	{ PCI_DEVICE( PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231_4) },

No space after opening parenthesis.

> 	if (force_addr)
> 		isa_address = force_addr & 0xFF00;
> 
> 	if (force_addr) {

You could merge both tests.

> 	/* Reserve the ISA region */
> 	if (!request_region(isa_address, VT8231_EXTENT, vt8231_pci_driver.name)) {

Line too long.

> 	data->valid = 0;

I don't think you actually need to initialize this one, as kzalloc did
it already.

> 	for(i=0; cfgInfoTemp[i].id >= 0; i++)
> 	{
> 		struct strDeviceAttrTable *pEntry = &cfgInfoTemp[i];
> 		if ( ISTEMP(pEntry->id, data->uch_config) )
> 		{

Horrible coding style. Please fix.

> 	if ((err = i2c_detach_client(client))) {
> 		return err;
> 	}

You could drop the curly braces.

> 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> 	    || !data->valid) {
> 		data->uch_config = vt8231_read_value(client,
> 						VT8231_REG_UCH_CONFIG);

On second thought, what's the point in reading it over and over?
You only created the sysfs files corresonding to the initial
configuration, so if this configuration register was to change, the
driver would silently break anyway.

It's probably more efficient, and not less safe, to keep and trust
the original reading.

> 		for (i = 1; i < 3; i++) {
> 			data->fan[i - 1] = vt8231_read_value(client,
> 						VT8231_REG_FAN(i));
> 			data->fan_min[i - 1] = vt8231_read_value(client,
> 						VT8231_REG_FAN_MIN(i));
> 		}

You should be able to get rid of the offsets by defining the macros
differently.

> module_init(sm_vt8231_init);
> module_exit(sm_vt8231_exit);
> 

No blank line at end of file please.

Pfew, done it :)

Thanks,
-- 
Jean Delvare
