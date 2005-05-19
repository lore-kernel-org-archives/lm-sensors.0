From: jeff@jdfiles.org (Jeff Sacksteder)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: i2c for Alpha
Message-Id: <200310141734.29401.jeff@jdfiles.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I have worked out my build issues with my distribution(Gentoo) by way
> > of an additional patch. Apparently 'i2c-velleman.c' needs a bit like
> > this...
> >
> > +#include <asm/param.h>
> >
> > Can this be included in 2.9?
>
> Reported and fixed back in July, so it's OK in 2.8.1 already.

Moving on to lm-sensors 2.8.0, the build fails with the error-

kernel/busses/i2c-nforce2.c:362: `GFP_KERNEL' undeclared (first use in this 
function)

Is there a known fix for this?

