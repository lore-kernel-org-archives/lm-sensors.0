From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 29 Oct 2012 15:37:31 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/9] hwmon: (it87) Introduce support for tempX_offset sysfs attribute
Message-Id: <20121029153731.GA14525@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Mon, Oct 29, 2012 at 11:08:30AM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sun, 28 Oct 2012 11:19:56 -0700, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: The macro to calculate IT87_REG_TEMP_OFFSET was broken. Use array instead.
> >     When writing the temperature offset attribute, set the flag to enable it.
> >     Add documentation describing the new attributes.
> > 
> >  Documentation/hwmon/it87 |    9 +++++++++
> >  drivers/hwmon/it87.c     |   25 ++++++++++++++++++++++---
> >  2 files changed, 31 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
> > index 87850d8..92ce617 100644
> > --- a/Documentation/hwmon/it87
> > +++ b/Documentation/hwmon/it87
> > @@ -209,3 +209,12 @@ doesn't use CPU cycles.
> >  Trip points must be set properly before switching to automatic fan speed
> >  control mode. The driver will perform basic integrity checks before
> >  actually switching to automatic control mode.
> > +
> > +
> > +Temperature offset attributes
> > +-----------------------------
> > +
> > +The driver supports temp[1-3]_offset sysfs attributes to adjust the reported
> > +temperature for thermal diodes or diode connected thermal transistors.
> 
> diode-connected
> 
> > +If a temperature sensor is configured for thermistors, the attribute values
> > +are ignored.
> > diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> > index 82f7924..fe2cdd4 100644
> > --- a/drivers/hwmon/it87.c
> > +++ b/drivers/hwmon/it87.c
> > @@ -203,6 +203,8 @@ static const u8 IT87_REG_FAN[]		= { 0x0d, 0x0e, 0x0f, 0x80, 0x82 };
> >  static const u8 IT87_REG_FAN_MIN[]	= { 0x10, 0x11, 0x12, 0x84, 0x86 };
> >  static const u8 IT87_REG_FANX[]		= { 0x18, 0x19, 0x1a, 0x81, 0x83 };
> >  static const u8 IT87_REG_FANX_MIN[]	= { 0x1b, 0x1c, 0x1d, 0x85, 0x87 };
> > +static const u8 IT87_REG_TEMP_OFFSET[]	= { 0x56, 0x57, 0x59 };
> 
> Not all supported chips have these registers. For example, the IT8712F
> rev. D doesn't have registers at 0x56 and 0x57, and register 0x59
> apparently adjusts the offset for all 3 temperature channels. Also the
> value is expressed as a reference voltage, not an offset in degrees C:
> 
> "Thermal Diode Zero Degree Voltage value (default: 0.664V 156h)."
> 
> (I don't quite understand how they can make 156h fit in an 8-bit
> register, but that a different problem.)
> 
> So you will have to check all chips and revisions for support and only
> create the sysfs attributes if the chip supports per-channel, degree C
> offsets. A quick grep suggests that even the latest IT8705F and IT8712F
> chip revisons had a voltage value in these registers, so support would
> start with the IT8716F.
> 
Actually, I did check all chip revisions for which I have documentation.

I have the following datasheets:
	IT8705F rev. 0.4 (chip revision 3)
	IT8712F rev. 0.7 (chip revision 6)
	IT8712F rev. 0.81 (chip revision 7)

In all those specifications, the registers exist and are called "Thermal Diode
Zero Degree Adjust {1|2|3} Register".

Kind of odd (and a bit scary) that they would remove the registers with later
chip revisions. Anyway, I'll have to see if I can find any additional versions
of the specifications.

Maybe I should simply drop the attributes for IT8705F and IT8712F ?

> > +
> >  #define IT87_REG_FAN_MAIN_CTRL 0x13
> >  #define IT87_REG_FAN_CTL       0x14
> >  #define IT87_REG_PWM(nr)       (0x15 + (nr))
> > @@ -263,7 +265,7 @@ struct it87_data {
> >  	u16 fan[5];		/* Register values, possibly combined */
> >  	u16 fan_min[5];		/* Register values, possibly combined */
> >  	u8 has_temp;		/* Bitfield, temp sensors enabled */
> > -	s8 temp[3][3];		/* [nr][0]=temp, [1]=min, [2]=max */
> > +	s8 temp[3][4];		/* [nr][0]=temp, [1]=min, [2]=max, [3]=offset */
> >  	u8 sensor;		/* Register value */
> >  	u8 fan_div[3];		/* Register encoding, shifted right */
> >  	u8 vid;			/* Register encoding, combined */
> > @@ -538,10 +540,19 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
> >  
> >  	mutex_lock(&data->update_lock);
> >  	data->temp[nr][index] = TEMP_TO_REG(val);
> > +	if (index = 3) {
> > +		u8 reg = it87_read_value(data, IT87_REG_BEEP_ENABLE);
> > +		if (!(reg & 0x80)) {
> > +			reg |= 0x80;
> > +			it87_write_value(data, IT87_REG_BEEP_ENABLE, reg);
> > +		}
> > +	}
> >  	it87_write_value(data,
> >  			 index = 1 ? IT87_REG_TEMP_LOW(nr)
> > -				    : IT87_REG_TEMP_HIGH(nr),
> > +				    : index = 2 ? IT87_REG_TEMP_HIGH(nr)
> > +						 : IT87_REG_TEMP_OFFSET[nr],
> 
> This starts being a little difficult to read. Plus you have more tests
> on the index value than you could have. What about introducing a local
> variable in which you would store the register number, and use that
> later in the code? You can use a switch/case for that, this will be a
> lot more indentation-friendly.
> 
Ok.

> >  			 data->temp[nr][index]);
> > +	data->valid = 0;
> 
> I see no reason for doing that unconditionally. This is only needed
> when changing an offset, not a limit, right?
> 
Ok.

> >  	mutex_unlock(&data->update_lock);
> >  	return count;
> >  }
> > @@ -549,12 +560,15 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
> >  static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
> >  static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGOWU, show_temp, set_temp, 0, 1);
> >  static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGOWU, show_temp, set_temp, 0, 2);
> > +static SENSOR_DEVICE_ATTR_2(temp1_offset, S_IRUGOWU, show_temp, set_temp, 0, 3);
> >  static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 1, 0);
> >  static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGOWU, show_temp, set_temp, 1, 1);
> >  static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGOWU, show_temp, set_temp, 1, 2);
> > +static SENSOR_DEVICE_ATTR_2(temp2_offset, S_IRUGOWU, show_temp, set_temp, 1, 3);
> >  static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 2, 0);
> >  static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGOWU, show_temp, set_temp, 2, 1);
> >  static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGOWU, show_temp, set_temp, 2, 2);
> > +static SENSOR_DEVICE_ATTR_2(temp3_offset, S_IRUGOWU, show_temp, set_temp, 2, 3);
> >  
> >  static ssize_t show_type(struct device *dev, struct device_attribute *attr,
> >  			 char *buf)
> > @@ -1376,11 +1390,12 @@ static const struct attribute_group it87_group_in[9] = {
> >  	{ .attrs = it87_attributes_in[8] },
> >  };
> >  
> > -static struct attribute *it87_attributes_temp[3][6] = {
> > +static struct attribute *it87_attributes_temp[3][7] = {
> >  {
> >  	&sensor_dev_attr_temp1_input.dev_attr.attr,
> >  	&sensor_dev_attr_temp1_max.dev_attr.attr,
> >  	&sensor_dev_attr_temp1_min.dev_attr.attr,
> > +	&sensor_dev_attr_temp1_offset.dev_attr.attr,
> >  	&sensor_dev_attr_temp1_type.dev_attr.attr,
> >  	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
> >  	NULL
> > @@ -1388,6 +1403,7 @@ static struct attribute *it87_attributes_temp[3][6] = {
> >  	&sensor_dev_attr_temp2_input.dev_attr.attr,
> >  	&sensor_dev_attr_temp2_max.dev_attr.attr,
> >  	&sensor_dev_attr_temp2_min.dev_attr.attr,
> > +	&sensor_dev_attr_temp2_offset.dev_attr.attr,
> >  	&sensor_dev_attr_temp2_type.dev_attr.attr,
> >  	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
> >  	NULL
> > @@ -1395,6 +1411,7 @@ static struct attribute *it87_attributes_temp[3][6] = {
> >  	&sensor_dev_attr_temp3_input.dev_attr.attr,
> >  	&sensor_dev_attr_temp3_max.dev_attr.attr,
> >  	&sensor_dev_attr_temp3_min.dev_attr.attr,
> > +	&sensor_dev_attr_temp3_offset.dev_attr.attr,
> >  	&sensor_dev_attr_temp3_type.dev_attr.attr,
> >  	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
> >  	NULL
> 
> As creation of these attributes will be conditional, you'll have to
> move them to their own array I'm afraid.
> 
Yes, I know. The tricky part is to find chip revisions which don't support the
registers.

> > @@ -2360,6 +2377,8 @@ static struct it87_data *it87_update_device(struct device *dev)
> >  				it87_read_value(data, IT87_REG_TEMP_LOW(i));
> >  			data->temp[i][2] > >  				it87_read_value(data, IT87_REG_TEMP_HIGH(i));
> > +			data->temp[i][3] > > +				it87_read_value(data, IT87_REG_TEMP_OFFSET[i]);
> 
> Ideally this would be conditional too.
> 
Ok.

> >  		}
> >  
> >  		/* Newer chips don't have clock dividers */
> 
> 
> -- 
> Jean Delvare
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
