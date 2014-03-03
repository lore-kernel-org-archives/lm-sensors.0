From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 03 Mar 2014 15:59:37 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Do not accept invalid name attributes
Message-Id: <20140303155937.GA19020@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393791319-2894-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393791319-2894-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 03, 2014 at 08:49:11AM +0100, Jean Delvare wrote:
> On Sun,  2 Mar 2014 12:15:19 -0800, Guenter Roeck wrote:
> > hwmon name attributes must not include '-', as specified in
> > Documentation/hwmon/sysfs-interface. Also filter out spaces,
> > tabs, wildcards, and newline characters.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: In addition to '-', filter out zero length names as well as names
> >     containing '*', ' ', '\t', and '\n'.
> > 
> >  drivers/hwmon/hwmon.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > index e176a43..a26c385 100644
> > --- a/drivers/hwmon/hwmon.c
> > +++ b/drivers/hwmon/hwmon.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/gfp.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/pci.h>
> > +#include <linux/string.h>
> >  
> >  #define HWMON_ID_PREFIX "hwmon"
> >  #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
> > @@ -99,6 +100,10 @@ hwmon_device_register_with_groups(struct device *dev, const char *name,
> >  	struct hwmon_device *hwdev;
> >  	int err, id;
> >  
> > +	/* Do not accept invalid characters in hwmon name attribute */
> > +	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
> > +		return ERR_PTR(-EINVAL);
> > +
> >  	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
> >  	if (id < 0)
> >  		return ERR_PTR(id);
> 
> Tested-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
