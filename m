From: ebrower@usa.net (Eric)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [RFC/PATCH] lost arbitration detection for PCF8584
Message-Id: <112JBsTvy2928S01.1108842444@uwdvg001.cms.usa.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4216C459.1060703@usa.net>
In-Reply-To: <4216C459.1060703@usa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



------ Original Message ------
Received: Sat, 19 Feb 2005 01:43:12 AM PST
From: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
To: Eric Brower <ebrower@usa.net>Cc: lm78@stimpy.netroedge.com
Subject: Re: [RFC/PATCH] lost arbitration detection for PCF8584

> Hi,
> 
>   the patch is looks fine to me, except these lines:
> 
> > @@ -414,8 +452,8 @@
> >  
> >  static u32 pcf_func(struct i2c_adapter *adap)
> >  {
> > -       return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | 
> > -              I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING; 
> > +       return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
> > +              I2C_FUNC_PROTOCOL_MANGLING; 
> >  }
>   Why you've removed I2C_FUNC_I2C?

It was not on purpose-- I've been working between two BK trees and one
apparently was older than the other so the change propagated-- that section of
the patch can certainly be dropped.  My appologies for not trimming that bogus
section.

E





