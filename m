From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 May 2010 07:39:29 +0000
Subject: Re: [lm-sensors] PMBus support in Linux
Message-Id: <20100529093929.38e03e06@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1275063391.2631.137.camel@groeck-laptop>
	<20100529023401.GB12507@pengutronix.de>
In-Reply-To: <20100529023401.GB12507-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Sat, 29 May 2010 04:34:01 +0200, Wolfram Sang wrote:
> 
> CCing lm-sensors and David...
> 
> On Fri, May 28, 2010 at 09:16:31AM -0700, Guenter Roeck wrote:
> 
> > does anyone know if there is an effort to add infrastructure for PMBus
> > support (or support for specific PMBus devices) to Linux ?
> 
> I found this:
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022969.html
> 
> Hmm, sitting ontop of SMBus, it makes perfect sense to use i2c-dev (David knows
> what he is doing, of course ;)). But having no repo and all, it is hard to
> maintain this utility. Is there any chance to pick it up in the kernel-tree?
> tools/i2c/ or such? Hmm, it's GPL v3...

There is an i2c-tools package for user-space utilities, I see no point
to add such code to the kernel tree.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
