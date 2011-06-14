From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Tue, 14 Jun 2011 02:25:07 +0000
Subject: Re: [lm-sensors] [PATCH v6] drivers/hwmon NTC Thermistor Initial
Message-Id: <23243243.117601308018306441.JavaMail.weblogic@epv6ml03>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307949359-27587-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1307949359-27587-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Guenter Roeck<guenter.roeck@ericsson.com>
> On Mon, Jun 13, 2011 at 03:15:59AM -0400, Donggeun Kim wrote:
> > This patch adds support for NTC Thermistor series. In this release, the
> > following thermistors are supported: NCP15WB473, NCP18WB473, NCP03WB473,
> > and NCP15WL333. This driver is based on the datasheet of MURATA.
> > 
> > The driver in the patch does conversion from the raw ADC value
> > (either voltage or resistence) to temperature. In order to use
> > voltage values as input, the circuit schematics should be provided
> > with the platform data. A compensation table for each type of thermistor
> > is provided for the conversion.
> > 
> > Signed-off-by: Donggeun Kim 
> > Signed-off-by: MyungJoo Ham 
> > Signed-off-by: KyungMin Park 
> > 
> Hi folks,
> 
> Almost there.

Great.

> 
> [ ... ]
> 
> >  include/linux/ntc.h     |   53 ++++++
> 
> Please move this file to include/linux/platform_data/ntc.h.
> 
> One question, though: ntc.[ch] is quite high level and suggests a wider scope than just thermistors.
> Would it make sense to use ntc_thermistor.[ch] instead ?

Yes, I think it is alright to use ntc_thermistor.[ch] as well because NTC is just a type of thermistor.

> 
> [ ... ]
> > +       if ((data->mintemp != INT_MAX) || (data->maxtemp != INT_MIN)) {
> 
> The inner ( ) are unnecessary. Please remove.
> 
> Thanks,
> Guenter
> 
> 

Cheers,
MyungJoo
Samsung Electronics
cell: +82-10-6714-2858 / office: +82-31-279-8033
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
