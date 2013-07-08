From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Jul 2013 16:51:22 +0000
Subject: Re: [lm-sensors] Displaying Voltage as Temperature?!?
Message-Id: <20130708165122.GA20683@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <51DAC98E.3090203@aeryon.com>
In-Reply-To: <51DAC98E.3090203@aeryon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 08, 2013 at 10:15:42AM -0400, Chris Pattenden wrote:
> Howdy.
> 
> I have a thermistor connected to a voltage sensing port (in0_input)
> on my ADC chip. I have everything running (i.e, /etc/sensors.conf
> has the voltage->temperature conversion curve programmed into a
> 'convert' line and 'sensors' is displaying the correct temperature)
> but the temperature is being displayed as "+21.0 V". Obviously, I'd
> like to display "+21.0 C".
> 
> Is there any way to force sensors to display the reading as a
> temperature without rewriting my ADC driver to fake a temperature
> sensing device (which it isn't)?
> 
Short answer is no.

One possibility might be to implement your ADC driver as iio driver
and then use the ntc_thermistor driver. That would require OF support
in your platform, though, and might make it necessary to add another
set of tables to the ntc_thermistor driver if you use a different
thermistor.

It might also be possible to tell an iio driver that a specific channel
is connected to a thermistor, and ask it to return a temperature instead
of a voltage. In that case you could use an iio driver and connect it to
iio_hwmon. I don't know enough about iio to know for sure and/or to
provide details, though.

A third option would be to enhance libsensors to add support for the
functionality you are asking for (ie replace one sensor type with another
via configuration file). There is actually a ticket open for that:
	http://www.lm-sensors.org/ticket/2258

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
