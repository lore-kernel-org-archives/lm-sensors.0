From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 Jul 2007 21:17:48 +0000
Subject: Re: [lm-sensors] THMC50 and ADM1022 support for 2.6 kernel
Message-Id: <20070703231748.30ba4f72@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070701205003.71ae723b@hyperion.delvare>
In-Reply-To: <20070701205003.71ae723b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Sun, 1 Jul 2007 23:37:33 +0200, Krzysztof Helt wrote:
> > > > +static void thmc50_init_client(struct i2c_client *client)
> > > > +{
> > > > +	struct thmc50_data *data = i2c_get_clientdata(client);
> > > > +
> > > > +	data->config_reg |= 0x23;
> > > > +	thmc50_write_value(client, THMC50_REG_CONF, data->config_reg);
> > > > +	data->analog_out = thmc50_read_value(client, THMC50_REG_ANALOG_OUT);
> > > > +	/* set up to at least 1 */
> > > > +	if (data->analog_out = 0 ) {
> > > > +		data->analog_out = 1;
> > > > +		thmc50_write_value(client, THMC50_REG_ANALOG_OUT, data->analog_out);
> > > > +	}
> > > > +}
> > 
> > Why do you change the value of the analog output? Loading a hardware
> > monitoring driver should NOT change the state of the system.
> 
> The analog output has range from 0 to 255. The 0 value is the least value possible but
> it is not 0 voltage on output pin. It simply must be adjusted to the range 1-255
> to conform with sysfs. I choose this way as the simplest. Another possibility is
> to scale this value when set and displayed from 1-255 (sysfs) to 0-255 (chip) range.
>
> The sysfs 0 value for pwm1 is translated to setting a special bit which cuts off the
> fan power completely (this works on my motherboard and it is given in reference
> design, but I cannot guarantee it is connected this way on all boards). 

I see. Scaling from 1-255 to 0-255 would be counterproductive, but is
it really what you want to do? You say that a register value doesn't
stop the fan, suggesting that the analog output isn't 0V? Do you know
how much it is? For example, if the full analog output is 2.5 V and a
register value of 0 means an output of 1.0 V, then you want to map the
register values 0 to 255 to sysfs values 102 to 255. 0 would stop the
fan, and values from 1 to 101 would behave the same as 102 (i.e.
minimum non-stop speed). See what I mean?

This is just a proposal anyway, your current implementation is
probably acceptable as well.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
