From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Oct 2007 13:27:40 +0000
Subject: Re: [lm-sensors] [PATCH] i2c: Fix NACK detection in i2c-pasemi
Message-Id: <20071025152740.482447e3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071024155917.GA25312@lixom.net>
In-Reply-To: <20071024155917.GA25312@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Olof,

On Wed, 24 Oct 2007 17:13:04 -0500, Olof Johansson wrote:
> On Wed, Oct 24, 2007 at 11:39:34PM +0200, Jean Delvare wrote:
> > Hi Olof,
> > 
> > > +	/* Got NACK? */
> > > +	if (status & SMSTA_MTN)
> > > +		return -ENODEV;
> > 
> > What does the SMSTA_MTN bit mean exactly? If it is raised by any NACK,
> > then it doesn't necessarily mean "no device". It can also mean that the
> > slave didn't like the transaction for any reason. In this case -ENODEV
> > is too specific and you should instead return -ENXIO or maybe -EINVAL.
> > 
> > It's up to i2c-core to convert the error code to -ENODEV if it happens
> > during device probing.
> 
> Yes, it could be raised by any NACK. Want me to respin and resend or
> are you OK with editing before committing?

I'll edit it myself, no problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
