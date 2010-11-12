From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 12 Nov 2010 22:39:38 +0000
Subject: Re: [lm-sensors] Location for thermal drivers
Message-Id: <20101112223938.4f2675d7@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289594026.22931.388.camel@groeck-laptop>
	<AANLkTimERGh2yGGX_E_N4ajxg_-0QTFS54QSKj2+AAfF@mail.gmail.com>
	<1289599600.22931.406.camel@groeck-laptop>
In-Reply-To: <1289599600.22931.406.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: Phil Pokorny <ppokorny@penguincomputing.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

> > Why does drivers/thermal exist if there are no drivers in it and no maintainer?

It has a maintainer - they are just not listed in MAINTAINERS only in the
file itself.

> > 
> The framework resides there. Drivers supporting it are in various
> platform directories.
> 
> As for why there are no drivers - only the framework - in
> drivers/thermal, and why there is no maintainer - no idea.

Well I could put it in arch/x86/platform/mrst now we have that structure
from 2.6.37-rc1 onwards

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
