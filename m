From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 13 Apr 2013 01:36:30 +0000
Subject: Re: [lm-sensors] [NEW DRIVER V4 6/7] DA9058 HWMON driver
Message-Id: <20130413013630.GC14726@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201304121312.r3CDCJte011826@latitude>
 <51682E0C.4090605@metafoo.de>
In-Reply-To: <51682E0C.4090605@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Anthony Olech <anthony.olech.opensource@diasemi.com>, Jean Delvare <khali@linux-fr.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Randy Dunlap <rdunlap@xenotime.net>, lm-sensors@lm-sensors.org, LKML <linux-kernel@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>

On Fri, Apr 12, 2013 at 05:53:48PM +0200, Lars-Peter Clausen wrote:
> On 04/12/2013 03:05 PM, Anthony Olech wrote:
> > This is the HWMON component driver of the Dialog DA9058 PMIC.
> > This driver is just one component of the whole DA9058 PMIC driver.
> > It depends on the CORE and ADC component drivers of the DA9058 MFD.
> > 
> > Signed-off-by: Anthony Olech <anthony.olech.opensource@diasemi.com>
> > Signed-off-by: David Dajun Chen <david.chen@diasemi.com>
> 
> Hi,
> 
> can't you use the generic IIO to HWMON bridge driver? And if not it's probably
> better to extent the bridge driver than writing this custom driver.
> 
I like that idea.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
