From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Sep 2009 10:56:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: include <linux/io.h> instead of
Message-Id: <20090903125606.71c3aa86@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BD79186B4FD85F4B8E60E381CAEE190901BE9DA3@mi8nycmail19.Mi8.com>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901BE9DA3@mi8nycmail19.Mi8.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Wed, 2 Sep 2009 17:07:42 -0600, Jim Cromie wrote:
> On Wed, Sep 2, 2009 at 7:04 AM, Jean Delvare <khali@linux-fr.org> wrote:
> 
> > On Thu, 13 Aug 2009 16:56:56 -0400, H Hartley Sweeten wrote:
> > > Drivers should be including <linux/io.h> instead of <asm/io.h>.
> > >
> > > Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> > > Cc: Alistair John Strachan <alistair@devzero.co.uk>
> > > Cc: Nicolas Boichat <nicolas@boichat.ch>
> > > Cc: Juerg Haefliger <juergh@gmail.com>
> > > Cc: Jean Delvare <khali@linux-fr.org>
> > > Cc: Frank Seidel <frank@f-seidel.de>
> > > Cc: Jim Cromie <jim.cromie@gmail.com>
> > > Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
> > > Cc: Roger Lucas <vt8231@hiddenengine.co.uk>
> >
> > Applied, thanks.
> 
> wheres the tree ?
> I checked at git.kernel.org, didnt find /hwmon/
> 
> I found this googling, it looks old. (july last year iirc)
> http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=summary

In my private, unofficial hwmon tree:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/

> Also, wrt ack, I withheld it, cuz I hadnt gotten around to
> looking for it in a single tree (or to see whether it was already)
> 
> Since I never compiled it, ack'g seemed a bit overstating
> what a glance told me; that it looked sensible, and based on other work.
> 
> What would you have liked to hear from me in this case ?

Just your Acked-by, meaning you have no objection to the change.
Obviously Hartley and myself already test-built the code.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
