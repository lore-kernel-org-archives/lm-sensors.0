From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 17 Jun 2012 14:39:03 +0000
Subject: Re: [lm-sensors] [PATCH 82/95] hwmon: (w83627hf) Convert to use devm_ functions
Message-Id: <20120617143903.GC4510@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-83-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-83-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 17, 2012 at 01:55:15PM +0200, Jean Delvare wrote:
> On Fri, 15 Jun 2012 08:24:03 -0700, Guenter Roeck wrote:
> > Convert to use devm_ functions to reduce code size and simplify the code.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/w83627hf.c |   46 ++++++++++++++++------------------------------
> >  1 file changed, 16 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
> > index 5ce54a2..2cb403c 100644
> > --- a/drivers/hwmon/w83627hf.c
> > +++ b/drivers/hwmon/w83627hf.c
> > (...)
> > -      ERROR4:
> > +error:
> 
> One space before label please.
> 
Ok, done.

> Other than this:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
