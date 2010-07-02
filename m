From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Jul 2010 08:31:44 +0000
Subject: Re: [lm-sensors] [PATCH/RFC] hwmon: Add support for W83667HG-B
Message-Id: <20100702083144.GD12911@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1278021735-21188-1-git-send-email-guenter.roeck@ericsson.com>
 <20100702092011.0acd753f@hyperion.delvare>
 <20100702080704.GA12911@ericsson.com>
 <20100702101345.6fe9d27a@hyperion.delvare>
In-Reply-To: <20100702101345.6fe9d27a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Jim Cromie <jim.cromie@gmail.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, Andrew Morton <akpm@linux-foundation.org>, Ethan Lawrence <e.law87@yahoo.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lars4910@hotmail.com" <lars4910@hotmail.com>, "birdie@permonline.ru" <birdie@permonline.ru>, "jadcock@cox.net" <jadcock@cox.net>

On Fri, Jul 02, 2010 at 04:13:45AM -0400, Jean Delvare wrote:
> On Fri, 2 Jul 2010 01:07:04 -0700, Guenter Roeck wrote:
> > On Fri, Jul 02, 2010 at 03:20:11AM -0400, Jean Delvare wrote:
> > > On Thu, 1 Jul 2010 15:02:15 -0700, Guenter Roeck wrote:
> > > > @@ -63,6 +64,7 @@ static const char * w83627ehf_device_names[] = {
> > > >  	"w83627dhg",
> > > >  	"w83627dhg",
> > > >  	"w83667hg",
> > > > +	"w83667hg-b",
> > > 
> > > Dashes aren't allowed in hwmon device names. For consistency with what
> > > we did for the W83627DHG-Pg, you should simply drop the "-b". It's a small
> > > detail of little interest for the user anyway.
> >
> > Ok. Actually, since the only real difference was in the registers which
> > are not not used anywhere, I'll drop the enum type (w83667hg_b) as well.
> 
> Makes sense. It can be added later if needed.
> 
> > I'll also add a check for the HG-I.
> 
> Do you have a datasheet for that one too?
> 
No. However, since we have a tester, we will have test coverage,
so I figured it should be worth a try. If it doesn't work
I can still drop it from the final patch.

I suspect it is the same as the HG with a different chip ID.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
