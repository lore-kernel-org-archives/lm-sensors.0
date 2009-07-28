From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Jul 2009 07:26:47 +0000
Subject: Re: [lm-sensors] [PATCH 12/22] hwmon: WM831x PMIC hardware
Message-Id: <20090728092647.23ff0eaa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090727134527.GA12849@rakim.wolfsonmicro.main>
	<1248702372-29534-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20090727214419.5a503821@hyperion.delvare>
	<20090727204614.GA4386@sirena.org.uk>
In-Reply-To: <20090727204614.GA4386@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, 27 Jul 2009 21:46:14 +0100, Mark Brown wrote:
> On Mon, Jul 27, 2009 at 09:44:19PM +0200, Jean Delvare wrote:
> > On Mon, 27 Jul 2009 14:46:02 +0100, Mark Brown wrote:
> > > +#define WM831X_NAMED_VOLTAGE(id, name) \
> > > +	static SENSOR_DEVICE_ATTR(in##id##_input, S_IRUGO, show_voltage,\
> > > +				  NULL, name);		\
> > 
> > I guess you could just call WM831X_VOLTAGE(id, name).
> 
> That clashes with the unnamed voltage above.  I could also call them
> _NAMED and _UNNAMED, I suppose.

Sorry for not being clear. I simply meant you could write the following:

define WM831X_VOLTAGE(id, name) \
	static SENSOR_DEVICE_ATTR(in##id##_input, S_IRUGO, show_voltage, \
				  NULL, name)

#define WM831X_NAMED_VOLTAGE(id, name) \
	WM831X_VOLTAGE(id, name);					\
	static SENSOR_DEVICE_ATTR(in##id##_label, S_IRUGO, show_label,	\
				  NULL, name)

Which makes it more obvious that WM831X_NAMED_VOLTAGE is WM831X_VOLTAGE
+ label. But it's really up to you which way you prefer.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
