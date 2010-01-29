From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Jan 2010 17:26:46 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (s3c-hwmon): S3C hwmon requires
Message-Id: <20100129182646.57f79f58@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1264694548-30722-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1264694548-30722-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 Jan 2010 16:58:52 +0000, Mark Brown wrote:
> On Fri, Jan 29, 2010 at 05:46:02PM +0100, Jean Delvare wrote:
> 
> > Which tree are you looking at? I can't find an option named S3C_ADC.
> > 
> > What I do see is CONFIG_S3C24XX_ADC, however it seems to be
> > platform-specific, so I doubt you can just "select" it on ARCH_S3C64XX.
> 
> -next, it's in Ben Dook's current S3C tree.
> 
> > Looking at the source tree, I also don't see ADC support for
> > ARCH_S3C64XX at all, so I am curious if this patch was correct:
> 
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027712.html
> 
> > Maybe it's correct for some external tree and/or linux-next, but not
> > Linus' current kernel.
> 
> > So, Mark, I can't take your patch, and Ben, I'll remove the other patch
> > from my tree right now. These changes should go together with the
> > related platform changes. Carrying them in the hwmon tree when all the
> > related changes are in another tree can only cause trouble.
> 
> OK, the hwmon patches should just lift straight on to Ben's current tree
> (the ADC generalisation is already there).  I guess Ben might want your
> ack for the hwmon side?

I'm not the hwmon subsystem maintainer, and the changes are not related
to this subsystem anyway, they are really platform integration changes
rather than driver changes, but you and Ben have my ack for both
patches if it makes you feel better ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
