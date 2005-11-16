From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 16 Nov 2005 18:19:57 +0000
Subject: [lm-sensors] VT8231 patch for review
Message-Id: <bx4eGUlq.1132160791.0378900.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051116150825.2410D12E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051116150825.2410D12E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Roger,

On 2005-11-16, Roger Lucas wrote:
> Firstly, I really like Quilt.  It makes the whole patch process much
> easier.

True :) I'd suggest that you add the following to your ~/.quiltrc:

QUILT_NO_DIFF_INDEX=1
QUILT_REFRESH_ARGS="--diffstat --strip-trailing-whitespace"

This will help you produce patches the kernel folks will enjoy.

> To answer the question in your last mail, "Yes, I am happy to be the
> maintainer of this driver".

Great. Then please submit a patch adding yourself to MAINTAINERS. Copy my
LM90 entry for example, and adapt to you and the VT8231. Pay attention
to the fact that the entries are alphabetically sorted.

Note that all your patches should include a "Signed-off-by" line. This
one lacked it.

> Once we go around the loop to get this into the kernel, I'll take a look
> at the user-space utility as it throws up a load of errors at the moment.
> It also seems to get the alarm wrong on the fans.

Please look into it *before* the driver is accepted into the Linux 2.6
kernel tree. Maybe the bugs are in the user-space part, but maybe not.
We better don't merge a bogus driver.

There's still one thing I am not happy with: temp 2-6. We agreed to
export the raw register value for the diode-based temperature (temp1)
because there's nothing better we can do, but for the thermistor-based
ones we should be able to export the value as a voltage.

The BIOS porting guide states that the register value is equal to 253 -
R6/(R6+R5) * 210, where R5 is a thermisor (10K@25C) and R6 is a 10K
resistor. These 253 and 210 constants are inherent to the chip and do
not depend on the motherboard. R6 and R5 form a standard thermistor
divider, effectively converting a temperature into a voltage.

So I believe we should have the following for temp 2-6:

TEMP_FROM_REG(reg)    ((253 - (reg)) * 1000 / 210)

TEMP_TO_REG(val)      (253 - (val) * 210 / 1000)

Of course we would then need to update the formula in sensors.conf.eg.

To the code itself now:

> 	Copyright (c) 2005 Roger Lucas <roger@planbit.co.uk>
> 		      2002 Mark D. Studebaker <mdsxyz123@yahoo.com>

I think you have to repeat "Copyright (c)" before "2002".

> #define VT8231_REG_TEMP_LOW01	0x49
> #define VT8231_REG_TEMP_LOW25	0x4d
> (...)
> **     All the on-chip hardware temperature comparisons for the alarms
>                                                               are only
> **     8-bits wide, and compare against the 8 MSBs of the temperature.
>                                                               The bits
> **     in the registers VT8231_REG_TEMP_LOW12 and VT8231_REG_TEMP_LOW36
>                                                                    are
> **     ignored.

Conflicting conventions.

> 	u8 fan[2];		/* Register value */
> 	u8 fan_min[2];		/* Register value */
> (...)
> 		for (i = 1; i < 3; i++) {
> 			data->fan[i - 1] = vt8231_read_value(client,
> 						VT8231_REG_FAN(i));
> 			data->fan_min[i - 1] = vt8231_read_value(client,
> 						VT8231_REG_FAN_MIN(i));
> 		}

Array overflow! Sorry for not noticing before.

> static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in5, NULL, 5);
> static SENSOR_DEVICE_ATTR(in5_min, S_IRUGO | S_IWUSR, show_in5_min,
>                           set_in5_min, 5);
> static SENSOR_DEVICE_ATTR(in5_max, S_IRUGO | S_IWUSR, show_in5_max,
>                           set_in5_max, 5);

Please use DEVICE_ATTR instead. You are not using the extra parameter in
the callback functions.

> /* Temperatures */
> static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
> 		char *buf)
> {
> 	struct sensor_device_attribute *sensor_attr >                                          to_sensor_dev_attr(attr);
> 	int nr = sensor_attr->index;
> 	struct vt8231_data *data = vt8231_update_device(dev);
> 	return sprintf(buf, "%d\n",  data->temp[nr] * 250);
> }

Double space on last line.

> /* NOTE THAT THESE MAP THE LINUX TEMPERATURE SENSOR NUMBERING (1-6) TO
>                                                                THE VIA
> ** TEMPERATURE SENSOR NUMBERING (0-5)
> */

No caps please. Yelling never makes you more right.

> #define CFG_INFO_TEMP(id)	{ id - 1, \
> 				&sensor_dev_attr_temp##id##_input.dev_attr, \
> 				&sensor_dev_attr_temp##id##_min.dev_attr, \
> 				&sensor_dev_attr_temp##id##_max.dev_attr }
> #define CFG_INFO_VOLT(id)	{ id, \
> 				&sensor_dev_attr_in##id##_input.dev_attr, \
> 				&sensor_dev_attr_in##id##_min.dev_attr, \
> 				&sensor_dev_attr_in##id##_max.dev_attr, \
> 				}
> 
> struct str_device_attr_table {
> 	int	id;
> 	struct device_attribute *input;
> 	struct device_attribute *min;
> 	struct device_attribute *max;
> };
> 
> static struct str_device_attr_table cfg_info_temp[] = {
> 	CFG_INFO_TEMP(1),
> 	CFG_INFO_TEMP(2),
> 	CFG_INFO_TEMP(3),
> 	CFG_INFO_TEMP(4),
> 	CFG_INFO_TEMP(5),
> 	CFG_INFO_TEMP(6),
> 	{ .id = -1 }
> };
> 
> static struct str_device_attr_table cfg_info_volt[] = {
> 	CFG_INFO_VOLT(0),
> 	CFG_INFO_VOLT(1),
> 	CFG_INFO_VOLT(2),
> 	CFG_INFO_VOLT(3),
> 	CFG_INFO_VOLT(4),
> 	CFG_INFO_VOLT(5),
> 	{ .id = -1 }
> };

You can make these tables smaller. First, use the ARRAY_SIZE macro
instead of a list terminator. Second, you can easily deduce the value of
.id from the position in the array (in fact, .id *is* the position in
the array) so you don't need this field.

> static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
> 		char *buf)
> {
> 	struct sensor_device_attribute *sensor_attr >                                           to_sensor_dev_attr(attr);
> 	int nr = sensor_attr->index - 1;

That "- 1" should no more be there, right?

> 	vt8231_write_value(client, VT8231_REG_FAN_MIN(nr+1),
>                                                    data->fan_min[nr]);

I think I said it before, but why don't you change the definition of
VT8231_REG_FAN and VT8231_REG_FAN_MIN to:

#define VT8231_REG_FAN_MIN(nr)	(0x3b + (nr))
#define VT8231_REG_FAN(nr)	(0x29 + (nr))

And then call them with 0..1 rather than 1..2? This would make the code
more simple and easier to check against the datasheet.

> 	/* Correct the fan minimum speed */
> 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));

You additionally need to write the value to the chip, else it will be
overwritten on next update.

> int vt8231_detect(struct i2c_adapter *adapter)
> {
> 	struct i2c_client *new_client;

BTW, feel free to name it simply "client" if you want to. This "new_"
prefix really doesn't add any value.

> 	/* Fill in the remaining client fields and put into the global
>                                                                list */
>	strcpy(new_client->name, "vt8231");

Ideally this should be strlcpy(new_client->name, "vt8231",
I2C_NAME_SIZE);

> 		for (i = 0; i < 6; i++) {
> 			if (ISTEMP(i, data->uch_config)) {
> 				data->temp[i] = vt8231_read_value(client,
> 						       regtemp[i]) << 2;
> 				switch(i) {
> 				case 0:	j = (vt8231_read_value(client,
> 						VT8231_REG_TEMP_LOW01)
> 					      >> 6) & 0x03;
> 					break;
> 
> 				case 1:	j = (vt8231_read_value(client,
> 						VT8231_REG_TEMP_LOW01)
> 					      >> 4) & 0x03;
> 					break;
> 				case 2:
> 				case 3:
> 				case 4:
> 				case 5:	j = (vt8231_read_value(client,
> 					  	VT8231_REG_TEMP_LOW25)
> 						 >> ((i-2)*2)) & 0x03;
> 					break;
> 
> 				default: j = 0;
> 					break;
> 				}
> 				data->temp[i] |= j;
> (...)
> 			}
> 		}

I just realized how inefficient this part is. What about the following
instead:

u16 low = vt8231_read_value(client, VT8231_REG_TEMP_LOW01);
low = (low >> 6) | ((low & 0x30) >> 2); /* swap and shift */
    | (vt8231_read_value(client, VT8231_REG_TEMP_LOW25) << 4);
for (i = 0; i < 6; i++) {
	if (ISTEMP(i, data->uch_config)) {
		data->temp[i] = (vt8231_read_value(client, regtemp[i]) << 2)
		              | ((low >> 2*i) & 0x03);
(...)
	}
}

(You can even drop j if you do that.)

> module_init(sm_vt8231_init);
> module_exit(sm_vt8231_exit);
> 
> 

No blank lines at end of file please ;)

Thanks a lot for your good work! Keep it up, we're getting closer :)

--
Jean Delvare
