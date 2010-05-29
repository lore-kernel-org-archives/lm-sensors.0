From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 May 2010 10:03:27 +0000
Subject: Re: [lm-sensors] PMBus support in Linux
Message-Id: <20100529120327.43e4f856@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1275063391.2631.137.camel@groeck-laptop>
	<20100529023401.GB12507@pengutronix.de>
	<20100529093929.38e03e06@hyperion.delvare>
	<20100529081633.GA7428@pengutronix.de>
In-Reply-To: <20100529081633.GA7428-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Sat, 29 May 2010 10:16:33 +0200, Wolfram Sang wrote:
> 
> > There is an i2c-tools package for user-space utilities, I see no point
> > to add such code to the kernel tree.
> 
> Obviously correct. Are there any problems picking up GPL3 code?

No problem, we already have a mix of licenses in this package, and I
don't mind adding one more.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
