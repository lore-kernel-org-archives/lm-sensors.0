From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Apr 2011 16:06:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Change I2C detection class
Message-Id: <20110416180631.16b922e1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110416141713.333d6e51@endymion.delvare>
In-Reply-To: <20110416141713.333d6e51@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat, 16 Apr 2011 07:58:24 -0700, Guenter Roeck wrote:
> On Sat, Apr 16, 2011 at 08:17:13AM -0400, Jean Delvare wrote:
> > While the JC42-compatible chips are temperature sensors, I2C_CLASS_SPD
> > makes more sense because these chips always live on memory modules.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Guenter, what do you think?
> > 
> I don't know. Seems odd to define a device based on its location instead of its functionality.

The class isn't "defining a device". It should really be called
"probing class" or "auto-detection class". As a matter of fact, many
hwmon devices don't set their class to I2C_CLASS_HWMON because they
don't detect devices in the first place.

> What is the device class used for anyway ? I browsed through the code, but did not find it.

In i2c-core.c:i2c_detect():

	/* Stop here if the classes do not match */
	if (!(adapter->class & driver->class))
		return 0;

I2C classes are used to limit the probing scope of i2c device drivers.
They are pretty much arbitrary as long as things work (i.e. common I2C
chips as hardware monitoring and SPD EEPROMs on PC motherboards are
properly detected, and no misdetections happen.)

Back to my patch: I am currently working on implementing SMBus
multiplexing for Asus Z8NA boards. On these boards, all I2C devices
except the memory modules are on the SMBus directly, while memory module
slots are all behind a multiplexer. They are split in 2 or 3 groups,
each of which corresponds to one multiplexer position.

I am considering several options to support this topology. One option
is to set the class of the trunk to I2C_CLASS_HWMON only (i.e. remove
I2C_CLASS_SPD), and enable auto-detection with class = I2C_CLASS_SPD on
segments behind the multiplexer. This will work fine for SPD EEPROMs,
but not for JC42 thermal sensors, unless the jc42 driver switches to
class I2C_CLASS_SPD. Thus my proposal. This option is the most simple
to implement and thus has my preference (unless I find a problem with
it at some point...)

Note that this isn't only needed for these Asus boards. There are other
Supermicro [1] boards which need exactly the same. And Tyan boards have
used multiplexing in the past, this should help them too. The SMBus
multiplexing approach is mandatory for any board with more than 8
memory slots (AT24C02 chips have only 3 2-state pins for I2C address
selection), and many server boards these days have 12 or even 18.

[1] http://marc.info/?l=linux-i2c&m0260345621586&w=2

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
