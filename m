From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 16:08:28 +0000
Subject: Re: [lm-sensors] [PATCH 09/13] MAINTAINERS: Drop maintainer for MAX1668 hwmon driver
Message-Id: <1327421308.2649.172.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327088365-11149-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327088365-11149-10-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-01-24 at 02:47 -0500, Jean Delvare wrote:
> On Fri, 20 Jan 2012 11:39:21 -0800, Guenter Roeck wrote:
> > David no longer has access to MAX1688 hardware, so drop him from the maintainers
> > list.
> > 
> > Cc: David George <dgeorgester@gmail.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  MAINTAINERS |    7 -------
> >  1 files changed, 0 insertions(+), 7 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 89b70df..0ed538c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4267,13 +4267,6 @@ S:	Orphan
> >  F:	drivers/video/matrox/matroxfb_*
> >  F:	include/linux/matroxfb.h
> >  
> > -MAX1668 TEMPERATURE SENSOR DRIVER
> > -M:	"David George" <david.george@ska.ac.za>
> > -L:	lm-sensors@lm-sensors.org
> > -S:	Maintained
> > -F:	Documentation/hwmon/max1668
> > -F:	drivers/hwmon/max1668.c
> > -
> >  MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
> >  M:	"Hans J. Koch" <hjk@hansjkoch.de>
> >  L:	lm-sensors@lm-sensors.org
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> Cleaning up these entries is always good, but please give David the
> opportunity to ack before pushing upstream.
> 

Makes sense.

David, 

can you send me a formal Ack ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
