From: atull <atull@opensource.altera.com>
Date: Wed, 01 Oct 2014 22:20:14 +0000
Subject: Re: [lm-sensors] [PATCH v4 4/4] pmbus: ltc2978: add regulator support
Message-Id: <alpine.DEB.2.02.1410011713150.5194@atx-linux-37>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141001213613.GA29312@roeck-us.net>
In-Reply-To: <20141001213613.GA29312@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com

On Wed, 1 Oct 2014, Guenter Roeck wrote:

> On Wed, Oct 01, 2014 at 03:18:20PM -0500, atull@opensource.altera.com wrote:
> > From: Alan Tull <atull@opensource.altera.com>
> > 
> > Add simple on/off regulator support for ltc2978 and
> > other pmbus parts supported by ltc2978.c
> > 
> > Signed-off-by: Alan Tull <atull@opensource.altera.com>
> > 
> > v2: Remove '#include <linux/regulator/machine.h>'
> >     Only one regulator per pmbus device
> >     Get regulator_init_data from pdata or device tree
> > 
> > v3: Support multiple regulators for each chip
> >     Move most code to pmbus_core.c
> >     fixed values for on/off
> > 
> > v4: fix a #endif comment
> >     simplify probe code, remove added switch statement
> >     remove BUG_ON(), add error message and fix num_regulators
> > ---
> >  drivers/hwmon/pmbus/Kconfig   |    7 +++++++
> >  drivers/hwmon/pmbus/ltc2978.c |   37 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > index 6e1e493..79117b7 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -56,6 +56,13 @@ config SENSORS_LTC2978
> >  	  This driver can also be built as a module. If so, the module will
> >  	  be called ltc2978.
> >  
> > +config SENSORS_LTC2978_REGULATOR
> > +	boolean "Regulator support for LTC2974, LTC2978, LTC3880, and LTC3883"
> 
> We will need to update this and SENSORS_LTC2978 and add LTC2977 as well as
> LTM4646 to the list of supported chips.
> 
> Guenter

I will add the whole list to the 'help' sections of SENSORS_LTC2978 and
SENSORS_LTC2978_REGULATOR.

For the tristate/boolean lines, I can't fit the whole list, so I will
leave them as they are.  Or I could change to 'LTC2978 and compatibles' as
many others in this Kconfig have.

Alan

> 
> > +	depends on SENSORS_LTC2978 && REGULATOR
> > +	help
> > +	  If you say yes here you get regulator support for Linear
> > +	  Technology LTC2974, LTC2978, LTC3880, and LTC3883.
> > +

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
