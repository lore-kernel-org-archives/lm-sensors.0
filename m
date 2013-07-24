From: Evgeniy Dushistov <dushistov@mail.ru>
Date: Wed, 24 Jul 2013 12:04:14 +0000
Subject: Re: [lm-sensors] ads11(13/14/15)
Message-Id: <20130724120414.GB22757@fifteen>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130723144209.GA13252@fifteen>
In-Reply-To: <20130723144209.GA13252@fifteen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 23, 2013 at 04:43:19PM -0700, Guenter Roeck wrote:
> On Tue, Jul 23, 2013 at 06:42:09PM +0400, Evgeniy Dushistov wrote:
> > Hi,
> > 
> > I need support for ads1113 in kernel, it very similar to ads1115,
> > I found this in mailing list archive:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2011-March/031717.html
> > 
> > And as I understand all agree about inclusion of patch for ads1115 into
> > the mainline,
> > but I can not find in traces in Linus's tree drivers/hwmod/ads1015.c
> > 
> > You decide to not include driver, why?
> > 
> Some cleanup was supposed to happen, but as far as I can see it never did.
> 

Thanks, for answer, is anybody have last version of the patch?
for example here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2011-March/031873.html

Jean Delvare wrote:
>OK, changed.

but did not post the final result.

And what should I do, if I want merge of ads1115 support to
mainline, post patch again to lm-sensors and Dirk Eibach?

-- 
/Evgeniy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
