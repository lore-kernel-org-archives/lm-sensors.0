From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 09 Jan 2012 00:14:27 +0000
Subject: Re: [lm-sensors] [PATCH v2] Add support for new attributes to
Message-Id: <20120109001427.GA24906@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111106224622.GA28914@ericsson.com>
In-Reply-To: <20111106224622.GA28914@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sun, Jan 08, 2012 at 04:45:02PM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
[ ... ]
> >  
> >  static const struct sensor_subfeature_list power_inst_sensors[] = {
> > +	{ SENSORS_SUBFEATURE_POWER_AVERAGE, NULL, 0, "avg" },
> 
> I'm confused. This one was missing on purpose. For power sensors we
> consider instantaneous and averaging sensors as different types. The
> code in function print_chip_power is pretty clear about this. So, just
> as all _INPUT subfeatures aren't listed in limit arrays,
> SENSORS_SUBFEATURE_POWER_AVERAGE must not be listed.
> 
I looked this up again.

The idea was to support display of both instantaneous power and average power
if both is provided by the chip/driver.

With the above, this is displayed as follows: 

power: 55mW (avg: 50mW, highest: 70mW)

In other words, average power is displayed as limit, similar to lowest/highest values,
if instantaneous power is supported as well. If not, it is still displayed as before.

power: 50mW (highest: 70mW)

Do you have a better idea how to handle this case ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
