From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 01 Jun 2013 04:20:53 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon (ds1621): Remove detection function
Message-Id: <20130601042053.GC4081@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1369326142-30781-1-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1369326142-30781-1-git-send-email-rob.coulson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 31, 2013 at 08:09:01PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 24 May 2013 07:56:40 -0700, Guenter Roeck wrote:
> > On Fri, May 24, 2013 at 09:05:50AM +0200, Jean Delvare wrote:
> > > Hi Robert,
> > > 
> > > On Thu, 23 May 2013 09:22:22 -0700, Robert Coulson wrote:
> > > > Due to a lack of device and vendor identification registers, the
> > > > Dallas/Maxim DS16xx devices cannot be uniquely detected, sometimes
> > > > resulting in false positives. Therefore, the detection function is
> > > > being removed in favor of explicit device instantiation.
> > > > 
> > > > Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
> > > > ---
> > > >  Documentation/hwmon/ds1621 |   25 +++++++++++------------
> > > >  drivers/hwmon/ds1621.c     |   48 --------------------------------------------
> > > >  2 files changed, 12 insertions(+), 61 deletions(-)
> > > > 
> > > > v2:
> > > > - removed detect function references in ds1621 documentation
> > > > - replaced deprecated with removed and fixed a spelling error
> > > > v3:
> > > > - removed scanned addresses info, tables, and list
> > > > (...)
> > > 
> > > Thanks for the update, looks good to me.
> > > 
> > > Acked-by: Jean Delvare <khali@linux-fr.org>
> > > 
> > > Guenter, please pick and apply.
> > 
> > Applied to -next.
> 
> Was this patch lost somehow? I can't see it in your tree.
> 
Usually I keep it local for a day or two to ensure it passes nightly testing.
In this case, I simply forgot to push the branch into the upstream repo.
Too much work last week, sorry. It is now available.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
