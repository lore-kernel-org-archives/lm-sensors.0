From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Jun 2013 14:27:58 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: Add a simple driver to read the MXS SoC temperature
Message-Id: <20130627142758.GA5812@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372236673-20725-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20130626143927.GB31998@roeck-us.net>
 <20130627091732.GP5803@lukather>
In-Reply-To: <20130627091732.GP5803@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Shawn Guo <shawn.guo@linaro.org>, Jean Delvare <khali@linux-fr.org>, jimwall@q.com, brian@crystalfontz.com, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org

On Thu, Jun 27, 2013 at 11:17:32AM +0200, Maxime Ripard wrote:
> On Wed, Jun 26, 2013 at 07:39:27AM -0700, Guenter Roeck wrote:
> > On Wed, Jun 26, 2013 at 10:51:12AM +0200, Alexandre Belloni wrote:
> > > The low resolution ADC of the mxs is able to read an internal temperature
> > > sensor, expose that using hwmon.
> > > 
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > ---
> > 
> > Wouldn't it make more sense to use iio-hwmon and improve it if necessary ?
> 
> Actually, I wonder if we should not just put the hwmon driver
> capabilities directly into the mxs-lradc driver, just like it's already
> been done in this driver for the touchscreen support.
> 
> The probing of this hwmon driver doesn't really belong to the DT, it's
> not really realistic to probe it from the machine definition, and it
> really is the IP that is wired that way.
> 
Merging iio-hwmon functionality into an adc driver seems just as bad
(or even worse) as copying it into a new driver.

If the lradc driver knows that the ADC channels are temperature sensors, it
should register them with the iio subsystem as IIO_TEMP type. Then you should
be able to use iio_hwmon as is.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
