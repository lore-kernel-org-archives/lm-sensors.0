From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 01 Jul 2007 21:37:33 +0000
Subject: Re: [lm-sensors] THMC50 and ADM1022 support for 2.6 kernel
Message-Id: <20070701233733.452acb3e.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070701205003.71ae723b@hyperion.delvare>
In-Reply-To: <20070701205003.71ae723b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 1 Jul 2007 20:50:03 +0200

Thank you for valuable input. I removed wrappers and changed data types

Jean Delvare <khali@linux-fr.org> wrote:
> 
> > > +	struct thmc50_data *data;
> > > +	struct device *dev;
> > > +	int err = 0;
> > > +	const char *type_name = "";
> > > +
> > > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> > 
> > Some type of warning would be nice here, instead of silently failing.
> > 
> > > +		goto exit;
> 
> I disagree. There may be several I2C buses on the system, for example
> one with no THMC50 chip and which doesn't support this functionality,
> and one with a THMC50 chip and which does support this functionality.
> Printing a warning when the first bus is being probed would be quite
> misleading.
> 
> As a matter of fact, none of the other i2c-based hardware monitoring
> drivers print error messages in this case. One driver (max6650) prints
> a debugging message.
> 

The driver will print debugging message to keep you and Mark Hoffman happy.
> 
> > > +static void thmc50_init_client(struct i2c_client *client)
> > > +{
> > > +	struct thmc50_data *data = i2c_get_clientdata(client);
> > > +
> > > +	data->config_reg |= 0x23;
> > > +	thmc50_write_value(client, THMC50_REG_CONF, data->config_reg);
> > > +	data->analog_out = thmc50_read_value(client, THMC50_REG_ANALOG_OUT);
> > > +	/* set up to at least 1 */
> > > +	if (data->analog_out = 0 ) {
> > > +		data->analog_out = 1;
> > > +		thmc50_write_value(client, THMC50_REG_ANALOG_OUT, data->analog_out);
> > > +	}
> > > +}
> 
> Why do you change the value of the analog output? Loading a hardware
> monitoring driver should NOT change the state of the system.
> 

The analog output has range from 0 to 255. The 0 value is the least value possible but
it is not 0 voltage on output pin. It simply must be adjusted to the range 1-255
to conform with sysfs. I choose this way as the simplest. Another possibility is
to scale this value when set and displayed from 1-255 (sysfs) to 0-255 (chip) range.

The sysfs 0 value for pwm1 is translated to setting a special bit which cuts off the
fan power completely (this works on my motherboard and it is given in reference
design, but I cannot guarantee it is connected this way on all boards). 

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
