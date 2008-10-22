From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 22 Oct 2008 09:59:43 +0000
Subject: Re: [lm-sensors] [PATCH] Allow it87.c to handle IT8720
Message-Id: <20081022115943.1fd9d7d6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810061033g3630dc2dwabb4d3c2a3f17337@mail.gmail.com>
	<20081007223623.684281f2@hyperion.delvare>
In-Reply-To: <20081007223623.684281f2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Marc Spaggiari <jean-marc@spaggiari.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Jean-Marc,

On Tue, 7 Oct 2008 22:36:23 +0200, Jean Delvare wrote:
> Hi Jean-Marc,
> 
> On Mon, 6 Oct 2008 13:33:56 -0400, Jean-Marc Spaggiari wrote:
> > The goal of this patch is to allow it87.c to handle IT8720 chipset
> > like IT8718 in order to retreive voltage, temperatures and fans speed
> > from sensors tools.
> > 
> > JMS
> > 
> > Patch also attached.
> > 
> > --- linux-2.6.27-rc8/drivers/hwmon/it87.c.orig  2008-10-02 09:04:44.000000000 -0400
> > +++ linux-2.6.27-rc8/drivers/hwmon/it87.c       2008-10-06 13:27:08.000000000 -0400
> > @@ -14,6 +14,7 @@

<snip, me reviewing the patch>

> Other than that - and the lack of Signed-off-by line - your patch looks
> OK to me.

Any chance to have an updated patch from you by the end of the day, so
that it makes it into kernel 2.6.28? The merge window is closing really
soon now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
