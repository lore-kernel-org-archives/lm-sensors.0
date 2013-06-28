From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 28 Jun 2013 16:35:40 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: Add a simple driver to read the MXS SoC temperature
Message-Id: <20130628163540.GA26547@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372236673-20725-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20130626143927.GB31998@roeck-us.net>
 <20130627091732.GP5803@lukather>
 <20130627142758.GA5812@roeck-us.net>
 <51CC91E8.50605@free-electrons.com>
 <51CD9B19.90407@metafoo.de>
 <51CDA2BF.5050501@free-electrons.com>
 <51CDAABB.4020505@metafoo.de>
In-Reply-To: <51CDAABB.4020505@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Shawn Guo <shawn.guo@linaro.org>, Jean Delvare <khali@linux-fr.org>, jimwall@q.com, brian@crystalfontz.com, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org

On Fri, Jun 28, 2013 at 05:24:43PM +0200, Lars-Peter Clausen wrote:
> On 06/28/2013 04:50 PM, Alexandre Belloni wrote:
> > On 28/06/2013 16:18, Lars-Peter Clausen wrote:
> >> On 06/27/2013 09:26 PM, Alexandre Belloni wrote:
> >>>
> >>> They are already registered as IIO_TEMP but only implement read_raw. Also,
> >>>
> >>> iio_hwmon_read_val() is using iio_read_channel_processed() and that will
> >>> basically only read one of the 2 channels. As I documented, you actually
> >>> need to read both channel 8 and channel 9 and then compute the value in
> >>> Kelvins. I'm not sure how you want me to do that in the current framework.
> >> What are these two channels actually measuring? Is the value of a single
> >> channel meaningful on it's own? If not it might make sense to update the IIO
> >> driver to just have one temperature channel.
> > 
> > It's not actually meaningful on its own. So, what you would do is expose
> > one iio channel for two ADC channels and do the computation in read_raw
> > ? or read_processed ? Then using iio-hwon to export it. ?
> > 
> > Regards,
> > 
> 
> Yes, return channel9 - channel8 as the raw value for the temperature channel
> and provide proper scale and offset values, so that
> iio_read_channel_processed() will return the correct value.
> 
Agreed.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
