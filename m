From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 07 Jul 2009 06:00:22 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Update Texas Instruments
Message-Id: <20090707060022.GA4518@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090706202845.GA4415@ubuntu>
In-Reply-To: <20090706202845.GA4415@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 06, 2009 at 11:19:56PM +0200, Jean Delvare wrote:
> On Mon, 6 Jul 2009 22:28:46 +0200, Andre Prendel wrote:
> > Support for TI's TMP411 sensor chip is in mainline since
> > 2.6.31-rc1. So now we can refer to the tmp401 driver.
> > ---
> > 
> > Index: sensors/prog/detect/sensors-detect
> > =================================> > --- sensors.orig/prog/detect/sensors-detect	2009-07-06 22:12:13.000000000 +0200
> > +++ sensors/prog/detect/sensors-detect	2009-07-06 22:12:23.000000000 +0200
> > @@ -904,7 +904,7 @@
> >  		i2c_detect => sub { lm90_detect(@_, 9); },
> >  	}, {
> >  		name => "Texas Instruments TMP411",
> > -		driver => "to-be-written",
> > +		driver => "tmp401",
> >  		i2c_addrs => [0x4c..0x4e],
> >  		i2c_detect => sub { lm90_detect(@_, 10); },
> >  	}, {
> 
> Yup, please commit.

Done.

> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
