From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 24 Sep 2012 16:09:32 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Versatile Express hwmon driver
Message-Id: <1348502972.27071.16.camel@hornet>
List-Id: <lm-sensors.vger.kernel.org>
References: <1348246591-2409-1-git-send-email-mail@pawelmoll.com>
 <20120924155947.GA14060@roeck-us.net>
In-Reply-To: <20120924155947.GA14060@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 2012-09-24 at 16:59 +0100, Guenter Roeck wrote:
> On Fri, Sep 21, 2012 at 05:56:31PM +0100, Pawel Moll wrote:
> > From: Pawel Moll <pawel.moll@arm.com>
> > 
> > hwmon framework driver for Versatile Express sensors, providing
> > information about board level voltage (only when regulator driver
> > is not configured), currents, temperature and power/energy usage.
> > Labels for the values can be defined as DT properties.
> > 
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> 
> After my concern was clarified ...
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks a lot!

> I assume this will go upstream through the arm tree ?

I was planning to push the subsystem patches (hwmon, regulator etc.)
through respective maintainers, so through your tree - the driver
depends on VEXPRESS_CONFIG so won't cause any build issues before the
infrastructure is in place. Of course if you'd rather see it go through
arm-soc, I'll add it to that branch. Just let me know what is your
preference.

Cheers!

Pawel



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
