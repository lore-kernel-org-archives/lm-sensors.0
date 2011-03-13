From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 13 Mar 2011 14:40:10 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon/abituguru*: Update my email
Message-Id: <20110313144010.GC10535@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300020634-7724-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1300020634-7724-3-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 13, 2011 at 10:29:47AM -0400, Jean Delvare wrote:
> On Sun, 13 Mar 2011 15:03:06 +0100, Jean Delvare wrote:
> > On Sun, 13 Mar 2011 13:50:34 +0100, Hans de Goede wrote:
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > >  MAINTAINERS                |    2 +-
> > >  drivers/hwmon/abituguru.c  |    4 ++--
> > >  drivers/hwmon/abituguru3.c |    4 ++--
> > >  3 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 4fd2ca8..a3ffcc9 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -198,7 +198,7 @@ F:	Documentation/scsi/aacraid.txt
> > >  F:	drivers/scsi/aacraid/
> > >  
> > >  ABIT UGURU 1,2 HARDWARE MONITOR DRIVER
> > > -M:	Hans de Goede <j.w.r.degoede@hhs.nl>
> > > +M:	Hans de Goede <hdegoede@redhat.com>
> > >  L:	lm-sensors@lm-sensors.org
> > >  S:	Maintained
> > >  F:	drivers/hwmon/abituguru.c
> > > diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
> > > index 8f07a9d..0e05aa1 100644
> > > --- a/drivers/hwmon/abituguru.c
> > > +++ b/drivers/hwmon/abituguru.c
> > > @@ -1,5 +1,5 @@
> > >  /*
> > > -    abituguru.c Copyright (c) 2005-2006 Hans de Goede <j.w.r.degoede@hhs.nl>
> > > +    abituguru.c Copyright (c) 2005-2006 Hans de Goede <hdegoede@redhat.com>
> > >  
> > >      This program is free software; you can redistribute it and/or modify
> > >      it under the terms of the GNU General Public License as published by
> > > @@ -1505,7 +1505,7 @@ static void __exit abituguru_exit(void)
> > >  	platform_driver_unregister(&abituguru_driver);
> > >  }
> > >  
> > > -MODULE_AUTHOR("Hans de Goede <j.w.r.degoede@hhs.nl>");
> > > +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> > >  MODULE_DESCRIPTION("Abit uGuru Sensor device");
> > >  MODULE_LICENSE("GPL");
> > >  
> > > diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
> > > index 48d21e2..034cebf 100644
> > > --- a/drivers/hwmon/abituguru3.c
> > > +++ b/drivers/hwmon/abituguru3.c
> > > @@ -1,7 +1,7 @@
> > >  /*
> > >      abituguru3.c
> > >  
> > > -    Copyright (c) 2006-2008 Hans de Goede <j.w.r.degoede@hhs.nl>
> > > +    Copyright (c) 2006-2008 Hans de Goede <hdegoede@redhat.com>
> > >      Copyright (c) 2008 Alistair John Strachan <alistair@devzero.co.uk>
> > >  
> > >      This program is free software; you can redistribute it and/or modify
> > > @@ -1266,7 +1266,7 @@ static void __exit abituguru3_exit(void)
> > >  	platform_driver_unregister(&abituguru3_driver);
> > >  }
> > >  
> > > -MODULE_AUTHOR("Hans de Goede <j.w.r.degoede@hhs.nl>");
> > > +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> > >  MODULE_DESCRIPTION("Abit uGuru3 Sensor device");
> > >  MODULE_LICENSE("GPL");
> > >  
> > 
> > Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> Oh, actually I've added this patch to my own hwmon tree, as it has no
> dependencies on patches already in Guenter's tree, contrary to the
> other two patches in this set.
> 
Ok.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
