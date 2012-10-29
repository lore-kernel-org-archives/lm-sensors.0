From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 29 Oct 2012 13:45:04 +0000
Subject: Re: [lm-sensors] [PATCH 1/9] hwmon: (it87) Save temperature registers in 2-dimensional array
Message-Id: <20121029134504.GA4053@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 29, 2012 at 08:34:59AM +0100, Jean Delvare wrote:
> On Sun, 28 Oct 2012 20:29:38 -0700, Guenter Roeck wrote:
> > On Sun, Oct 28, 2012 at 10:39:54PM +0100, Jean Delvare wrote:
> > > On Sun, 28 Oct 2012 11:19:53 -0700, Guenter Roeck wrote:
> > > > +#define S_IRUGOWU	(S_IRUGO | S_IWUSR)
> > > 
> > > I'm not a big fan of this being defined in a single driver. If you
> > > think it helps, then it would help several hundred drivers, not just
> > > this one, so it should be defined in <linux/stat.h>, not locally.
> > > 
> > It helps me avoid the 80-column limit later on.
> 
> Line splits aren't that terrific, are they?
> 
> Actually, as the maintainer of the it87 driver (just remembered that
> tonight) I would prefer line splits to a driver-specific define using a
> (kind of) general name-space.
> 
Ok, I'll change it.

> > I agree, it would be great to have this and similar definitions in
> > a global include file, I am just not sure if there would be much
> > of a chance to get it accepted there.
> 
> Just try and see how your proposal is received?
> 
Maybe ...

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
