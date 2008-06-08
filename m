From: Ben Dooks <ben-linux@fluff.org>
Date: Sun, 08 Jun 2008 15:58:56 +0000
Subject: Re: [lm-sensors] [patch 2.6.25] lm75: cleanup/reorg
Message-Id: <20080608155856.GD31817@trinity.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804211210.53652.david-b@pacbell.net>
In-Reply-To: <200804211210.53652.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 08, 2008 at 10:44:44AM -0400, Mark M. Hoffman wrote:
> Hi David:
> 
> * David Brownell <david-b@pacbell.net> [2008-04-21 12:10:53 -0700]:
> > Minor cleanup and reorg of the lm75 code.
> > 
> >  - Kconfig provides a larger list of lm75-compatible chips
> > 
> >  - A top comment now says what the driver does (!) ... as in, just
> >    what sort of sensor is this??
> > 
> >  - Section comments now delineate the various sections of the driver:
> >    hwmon attributes, driver binding, register access, module glue.
> >    One driver binding function moved out of the attribute section,
> >    as did the driver struct itself.
> > 
> >  - Minor tweaks to legacy probe logic:  correct a comment, and
> >    remove a pointless variable.
> > 
> >  - Whitespace, linelength, and comment fixes.  
> > 
> > This patch should include no functional changes.  It's preparation
> > for adding new-style (driver model) I2C driver binding.
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > Acked-by: Jean Delvare <khali@linux-fr.org>
> > Acked-by: Laurent Pinchart <laurentp@cse-semaphore.com>

I've run some testing on these with our TI TMP101 based systems,
and it works for us. I would recommend these going into the next
kernel release.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
