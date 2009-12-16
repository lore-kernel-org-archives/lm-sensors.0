From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Dec 2009 09:27:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for VIA CPU core
Message-Id: <20091216102714.76e511dc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090609083406.GE25316@prithivi.gnumonks.org>
In-Reply-To: <20090609083406.GE25316@prithivi.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 15 Dec 2009 21:27:32 +0100, Andre Prendel wrote:
> On Thu, Dec 10, 2009 at 08:39:04PM +0100, Jean Delvare wrote:
> > --- linux-2.6.33-rc0.orig/drivers/hwmon/Kconfig	2009-12-10 18:57:39.000000000 +0100
> > +++ linux-2.6.33-rc0/drivers/hwmon/Kconfig	2009-12-10 18:57:44.000000000 +0100
> > @@ -822,6 +822,14 @@ config SENSORS_TMP421
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called tmp421.
> >  
> > +config SENSORS_VIA_CPUTEMP
> > +	tristate "VIA CPU temperature sensor"
> > +	depends on X86
> > +	help
> > +	  If you say yes here you get support for the temperature
> > +	  sensor inside your CPU. Supported all are all known variants
> 
> There's a typo (all are all) since Harald's first version.

Fixed, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
