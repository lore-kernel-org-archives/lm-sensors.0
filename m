From: Olof Johansson <olof@lixom.net>
Date: Wed, 24 Oct 2007 22:13:04 +0000
Subject: Re: [lm-sensors] [PATCH] i2c: Fix NACK detection in i2c-pasemi
Message-Id: <20071024221304.GA31462@lixom.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071024155917.GA25312@lixom.net>
In-Reply-To: <20071024155917.GA25312@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 24, 2007 at 11:39:34PM +0200, Jean Delvare wrote:
> Hi Olof,
> 
> > +	/* Got NACK? */
> > +	if (status & SMSTA_MTN)
> > +		return -ENODEV;
> 
> What does the SMSTA_MTN bit mean exactly? If it is raised by any NACK,
> then it doesn't necessarily mean "no device". It can also mean that the
> slave didn't like the transaction for any reason. In this case -ENODEV
> is too specific and you should instead return -ENXIO or maybe -EINVAL.
> 
> It's up to i2c-core to convert the error code to -ENODEV if it happens
> during device probing.

Yes, it could be raised by any NACK. Want me to respin and resend or
are you OK with editing before committing?


Thanks for your feedback,

-Olof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
