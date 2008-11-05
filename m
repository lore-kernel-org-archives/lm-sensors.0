From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 05 Nov 2008 17:50:22 +0000
Subject: Re: [lm-sensors] How to pass board specific info to I2C driver
Message-Id: <20081105185022.59190a69@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CF6163088BDE8747873ADAA4AF922BF258D76E@zmy16exm21.fsl.freescale.net>
In-Reply-To: <CF6163088BDE8747873ADAA4AF922BF258D76E@zmy16exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Vincent,

On Mon, 27 Oct 2008 16:52:06 +0800, Hu Mingkai-B21284 wrote:
> I'm working on an ADC chip (MCP3021) driver under Linux 2.6.27.
> We used these two chips to monitor the CPU core current and 
> platform current individually, which is converted to voltage as 
> the ADC chip's input.
> As you know, the driver shouldn't contain the board specific info,
> such as, the chip's work voltage, the ratio of voltage and current.
> So how to pass these info to the driver module?

Most of the times, you simply don't have to, because it is handled in
user-space (by the libsensors configuration file.)

One thing that makes sense to pass to the driver is the chip's work
voltage, if measurements depend on it. This isn't something libsensors
handles (nor do I think it should).

Lastly, the conversion from current to voltage is not something we
handle really well, I have to admit. This is basically the same as ADC
being used for temperature measurements using a thermistor. It is
possible to convert the numerical value using libsensors, however it
will not change the unit which is displayed after the value, so it gets
very confusing. We have a ticket opened for this feature:
http://lm-sensors.org/ticket/2258
But this is really only a placeholder, nothing has been implemented yet
and I have no clear idea how we would do it. I wouldn't have any
objection to handling it in your driver for the time being, as long as
the default behavior is that voltage inputs are exposed as such, and
only if platform data is provided, that requires a conversion to
current, such a conversion is done.

> Here is the way I can think of:
> 1. to use dts file to pass the info to the module.
>     This way make the driver is bound to OF implement.

I don't think that would make your driver OF-dependent. Every device
can have platform data associated with it. So you could convert the OF
data to driver-specific platform data and the driver doesn't even have
to know that it has been instantiated through OF.

> 2. to use the module parameter.
>     For different chips, the work voltage and the ratio may be
>     different, but the chip uses the same driver.

That's not really practical as you found out yourself. If the platform
code knows the work voltage and other parameters for the given system
then filling platform data inside the kernel and passing it to the
driver is the way to go.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
