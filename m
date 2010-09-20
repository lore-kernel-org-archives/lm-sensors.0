From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Mon, 20 Sep 2010 10:43:55 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] Makefile and Kconfig changes for
Message-Id: <FF55437E1F14DA4BAEB721A458B6701706C5991EB3@dbde02.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284632612-25339-1-git-send-email-j-keerthy@ti.com>
 <20100916140617.GA14165@ericsson.com>
In-Reply-To: <20100916140617.GA14165@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>



> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Thursday, September 16, 2010 7:36 PM
> To: J, KEERTHY
> Cc: linux-omap@vger.kernel.org; lm-sensors@lm-sensors.org; Krishnamoorthy,
> Balaji T
> Subject: Re: [lm-sensors] [PATCH 2/2] Makefile and Kconfig changes for
> twl4030-madc driver
> 
> On Thu, Sep 16, 2010 at 06:23:32AM -0400, Keerthy wrote:
> > Makefile amd Kconfig Changes for twl4030-madc driver inclusion.
> >
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> >  arch/arm/mach-omap2/Kconfig |    4 ++++
> >  drivers/hwmon/Kconfig       |    4 ++++
> >  drivers/hwmon/Makefile      |    1 +
> >  3 files changed, 9 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index b48bacf..139137b 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -170,6 +170,8 @@ config MACH_OMAP_3430SDP
> >  	depends on ARCH_OMAP3
> >  	default y
> >  	select OMAP_PACKAGE_CBB
> > +	select HWMON
> > +	select TWL4030_MADC
> >
> >  config MACH_NOKIA_N800
> >         bool
> > @@ -206,6 +208,8 @@ config MACH_OMAP_ZOOM3
> >  	depends on ARCH_OMAP3
> >  	default y
> >  	select OMAP_PACKAGE_CBP
> > +	select HWMON
> > +	select TWL4030_MADC
> >
> >  config MACH_CM_T35
> >  	bool "CompuLab CM-T35 module"
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> 
> While it may make sense to have the above changes in a separate patch,
> the two files below should be part of patch #1, since they
> are logically part of the driver, and the driver itself won't
> make any sense in the code without being enabled in Kconfig/Makefile.
>
I will club them into a single patch.
 
> > index 4d4d09b..47d66b9 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -39,6 +39,10 @@ config HWMON_DEBUG_CHIP
> >
> >  comment "Native drivers"
> >
> > +config TWL4030_MADC
> 
> Please use SENSORS_TWL4030_MADC or SENSORS_TWL4030 to be in line
> with all other definitions. Also, please retain alphabetical order.
> 
> > +	tristate
> > +	depends on HWMON && TWL4030_CORE
> > +
> HWMON is really redundant here and should be removed.
>
I will remove it. 

> >  config SENSORS_ABITUGURU
> >  	tristate "Abit uGuru (rev 1 & 2)"
> >  	depends on X86 && EXPERIMENTAL
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index e3c2484..24b3b17 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_SENSORS_W83792D)	+= w83792d.o
> >  obj-$(CONFIG_SENSORS_W83793)	+= w83793.o
> >  obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
> >  obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
> > +obj-$(CONFIG_TWL4030_MADC)      += twl4030-madc.o
> >
> Again, please retain alphabetical order. There is a reason for the other
> sensors
> to be out of order (see comments in the Makefile), but presumably that
> does
> not apply this one. If it does, please add comment/reason indicating
> that/if
> this is the case.
> 
I will retain the alphabetical order

> >  obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
> >  obj-$(CONFIG_SENSORS_ABITUGURU3)+= abituguru3.o
> > --
> > 1.7.0.4
> >
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
