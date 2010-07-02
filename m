From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Jul 2010 14:09:44 +0000
Subject: Re: [lm-sensors] [PATCH/RFC] hwmon: Add support for W83667HG-B
Message-Id: <20100702140944.GA14032@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1278021735-21188-1-git-send-email-guenter.roeck@ericsson.com>
 <20100702092011.0acd753f@hyperion.delvare>
 <20100702080704.GA12911@ericsson.com>
 <20100702101345.6fe9d27a@hyperion.delvare>
 <20100702083144.GD12911@ericsson.com>
 <20100702115123.18e95e14@hyperion.delvare>
In-Reply-To: <20100702115123.18e95e14@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Jim Cromie <jim.cromie@gmail.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, Andrew Morton <akpm@linux-foundation.org>, Ethan Lawrence <e.law87@yahoo.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lars4910@hotmail.com" <lars4910@hotmail.com>, "birdie@permonline.ru" <birdie@permonline.ru>, "jadcock@cox.net" <jadcock@cox.net>

On Fri, Jul 02, 2010 at 05:51:23AM -0400, Jean Delvare wrote:
> On Fri, 2 Jul 2010 01:31:44 -0700, Guenter Roeck wrote:
> > On Fri, Jul 02, 2010 at 04:13:45AM -0400, Jean Delvare wrote:
> > > On Fri, 2 Jul 2010 01:07:04 -0700, Guenter Roeck wrote:
> > > > I'll also add a check for the HG-I.
> > > 
> > > Do you have a datasheet for that one too?
> > > 
> > No. However, since we have a tester, we will have test coverage,
> > so I figured it should be worth a try. If it doesn't work
> > I can still drop it from the final patch.
> 
> FYI, I have a datasheet, which unfortunately I am not allowed to share.
> Please let me know if you want me to look up something for you.
> 
How about the changed registers ? Would give us an idea if the chip is closer to 
667 or to 667-B.

> > I suspect it is the same as the HG with a different chip ID.
> 
> Beware, it's a different device number (677 vs. 667) so I would expect
> more differences.
> 
Ah, I missed that. I thought it was 667-I. Yes, you are right, that suggests
more differences.

Guenter

> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
