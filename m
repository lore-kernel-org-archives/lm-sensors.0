From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 12 Oct 2012 17:06:59 +0000
Subject: Re: [lm-sensors] [Patch v4 5/7] HWMON: DA9055 HWMON driver
Message-Id: <20121012170659.GA16189@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349702807.17349.8.camel@dhruva>
In-Reply-To: <1349702807.17349.8.camel@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 12, 2012 at 03:09:21PM +0530, Ashish Jangam wrote:
> On Fri, 2012-10-12 at 14:43 +0530, Ashish Jangam wrote:
> > 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:linux@roeck-us.net] 
> > Sent: Monday, October 08, 2012 9:05 PM
> > To: Ashish Jangam
> > Cc: Samuel Ortiz; lm-sensors@lm-sensors.org; David Dajun Chen
> > Subject: Re: [Patch v4 5/7] HWMON: DA9055 HWMON driver
> > 
> > On Mon, Oct 08, 2012 at 06:56:47PM +0530, Ashish Jangam wrote:
> > > This is the HWMON patch for DA9055 PMIC and has got dependency on the
> > > DA9055 MFD core.
> > > 
> > > This patch monitors the DA9055 PMIC's ADC channels vddout, junction temperature
> > > and auxiliary channels.
> > > 
> > > This patch is functionally tested on Samsung SMDKV6410.
> > > 
> > > Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> > > Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>
> > 
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > I assume this will be pushed upstream together with the aother patches in the
> > series.
> > 
> Its only dependent DA9055 MFD code is present in linux-next so you may
> have to upstream this patch. 

Ok, I'll add it to my -next tree.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
