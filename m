From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 12 Nov 2010 23:11:55 +0000
Subject: Re: [lm-sensors] Location for thermal drivers
Message-Id: <1289603515.20815.6.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289594026.22931.388.camel@groeck-laptop>
	 <AANLkTimERGh2yGGX_E_N4ajxg_-0QTFS54QSKj2+AAfF@mail.gmail.com>
	 <1289599600.22931.406.camel@groeck-laptop>
	 <20101112223938.4f2675d7@lxorguk.ukuu.org.uk>
In-Reply-To: <20101112223938.4f2675d7@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Phil Pokorny <ppokorny@penguincomputing.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, 2010-11-12 at 17:39 -0500, Alan Cox wrote:
> > > Why does drivers/thermal exist if there are no drivers in it and no maintainer?
> 
> It has a maintainer - they are just not listed in MAINTAINERS only in the
> file itself.
> 
> > > 
> > The framework resides there. Drivers supporting it are in various
> > platform directories.
> > 
> > As for why there are no drivers - only the framework - in
> > drivers/thermal, and why there is no maintainer - no idea.
> 
> Well I could put it in arch/x86/platform/mrst now we have that structure
> from 2.6.37-rc1 onwards

I thought the driver is for Medfield ? Is that the same ? Or do you mean
you would add platform/medfield ? That might be another option.

Then there is drivers/platform/x86/intel_menlow.c, which has the thermal
driver code for Menlow.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
