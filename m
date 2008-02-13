From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Feb 2008 13:53:51 +0000
Subject: Re: [lm-sensors] hwmon: (vt8231) Add individual alarm files
Message-Id: <20080213145351.0fec6f41@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106154602.3f81ae40@hyperion.delvare>
In-Reply-To: <20080106154602.3f81ae40@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 13 Feb 2008 08:06:33 -0500, Mark M. Hoffman wrote:
> Hi:
> 
> > On Thu, 17 Jan 2008 00:05:28 -0000, Roger Lucas wrote:
> > > My mail address is changing soon so I have a patch below to correct
> > > my e-mail addresses in the source code.  I have a special address for
> > > the vt8231 kernel development so that I can filter the spam on it more
> > > aggressively - it does seem to get heavily harvested...
> > > (...)
> > > Signed-off-by: Roger Lucas <vt8231@hiddenengine.co.uk>
> > > 
> > > --- linux-2.6.24-rc8-orig/drivers/hwmon/vt8231.c        2008-01-16 22:59:25.000000000 +0000
> > > +++ linux-2.6.24-rc8/drivers/hwmon/vt8231.c     2008-01-16 23:57:27.000000000 +0000
> > > @@ -2,7 +2,7 @@
> > >         vt8231.c - Part of lm_sensors, Linux kernel modules
> > >                                 for hardware monitoring
> > > 
> > > -       Copyright (c) 2005 Roger Lucas <roger@planbit.co.uk>
> > > +       Copyright (c) 2005 Roger Lucas <vt8231@hiddenengine.co.uk>
> > >         Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
> > >                            Aaron M. Marsh <amarsh@sdf.lonestar.org>
> > > 
> > > @@ -999,7 +999,7 @@
> > >         }
> > >  }
> > > 
> > > -MODULE_AUTHOR("Roger Lucas <roger@planbit.co.uk>");
> > > +MODULE_AUTHOR("Roger Lucas <vt8231@hiddenengine.co.uk>");
> > >  MODULE_DESCRIPTION("VT8231 sensors");
> > >  MODULE_LICENSE("GPL");
> 
> * Jean Delvare <khali@linux-fr.org> [2008-01-17 12:35:19 +0100]:
> > You probably want to update your address in MAINTAINERS as well.
> 
> Here's what I applied... no need to ACK, but let me know if I somehow
> screwed it up.
> 
> commit 8ce37033ec889deda806384a39787deb516cf501
> Author: Roger Lucas <vt8231@hiddenengine.co.uk>
> Date:   Wed Feb 13 07:52:06 2008 -0500
> 
>     hwmon: (vt8231) Update maintainer email address
>     
>     Signed-off-by: Roger Lucas <vt8231@hiddenengine.co.uk>
>     
>     (modified MAINTAINERS entry also - MMH)
>     
>     Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c40f0ae..d3f36f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4259,7 +4259,7 @@ S:	Maintained
>  
>  VT8231 HARDWARE MONITOR DRIVER
>  P:	Roger Lucas
> -M:	roger@planbit.co.uk
> +M:	vt8231@hiddenengine.co.uk
>  L:	lm-sensors@lm-sensors.org
>  S:	Maintained
>  
> diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
> index ed4b898..5bc5727 100644
> --- a/drivers/hwmon/vt8231.c
> +++ b/drivers/hwmon/vt8231.c
> @@ -2,7 +2,7 @@
>  	vt8231.c - Part of lm_sensors, Linux kernel modules
>  				for hardware monitoring
>  
> -	Copyright (c) 2005 Roger Lucas <roger@planbit.co.uk>
> +	Copyright (c) 2005 Roger Lucas <vt8231@hiddenengine.co.uk>
>  	Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
>  			   Aaron M. Marsh <amarsh@sdf.lonestar.org>
>  
> @@ -999,7 +999,7 @@ static void __exit sm_vt8231_exit(void)
>  	}
>  }
>  
> -MODULE_AUTHOR("Roger Lucas <roger@planbit.co.uk>");
> +MODULE_AUTHOR("Roger Lucas <vt8231@hiddenengine.co.uk>");
>  MODULE_DESCRIPTION("VT8231 sensors");
>  MODULE_LICENSE("GPL");
>  

Looks OK to me.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
