From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 16 Jan 2013 16:04:38 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (it87) Add support for IT8771E
Message-Id: <20130116160438.GA8484@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100225090135.4fefd2f6@hyperion.delvare>
In-Reply-To: <20100225090135.4fefd2f6@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 16, 2013 at 03:28:05PM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sun,  2 Dec 2012 11:17:47 -0800, Guenter Roeck wrote:
> > From: Kelly Anderson <kelly@silka.with-linux.com>
> > 
> > Assume that IT8771E is fully compatible with IT8728F.
> > 
> > Contributions-by: Kelly Anderson <kelly@silka.with-linux.com>
> 
> This is a non-standard tag, I'd rather just credit Kelly in the patch
> description to make checkpatch happy.
> 
Ok.

> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  Documentation/hwmon/it87 |   10 +++++++---
> >  drivers/hwmon/Kconfig    |    2 +-
> >  drivers/hwmon/it87.c     |   25 ++++++++++++++++++++-----
> >  3 files changed, 28 insertions(+), 9 deletions(-)
> 
> The patch looks alright, feel free to commit:
> 
> Reviewed-by: Jean Delvare <khali@linux-fr.org>
> 
> The IT8772E patch touches exactly the same areas and is so similar that
> I would suggest merging them both into a single patch, having them
> separated adds no value IMHO.
> 
Done.

> I have updated sensors-detect and the wiki already, as well as the
> standalone it87 driver.
> 
Great. Thanks a lot!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
