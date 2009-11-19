From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Nov 2009 12:51:11 +0000
Subject: Re: [lm-sensors] ipmisensors module ported to 2.6.29
Message-Id: <20091119135111.5b2b8c63@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1258584180.8521.102.camel@pharper_desktop.arrs.arrisi.com>
In-Reply-To: <1258584180.8521.102.camel@pharper_desktop.arrs.arrisi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 Nov 2009 13:35:40 +0100, Luca Tettamanti wrote:
> On Thu, Nov 19, 2009 at 1:09 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > Would you be willing to work together with Paul to put ipmisensors code
> > into shape to be finally merged into the kernel? After it is confirmed
> > that ipmisensors won't cause trouble to ipmisensors, of course.
> 
> I _might_ be able to hijack a development machine during the weekend,
> otherwise for testing I'd have to backport to 2.6.26 (Debian) since I
> really can't do a lot of reboots to test a kernel module.

OK.

> > Then we can discuss whether a libsensors-based implementation would
> > make sense, but if you need rw access to /dev/ipmi0 then I guess a
> > user-space implementation becomes unrealistic.
> 
> But easier to test for me :P
> BTW, I did a quick recompile of ipmitool opening the device node ro:
> it still works (or at least it seems to).

This is interesting. Maybe some commands need RW and some are fine with
read-only? In that case, ipmitool should be modified to only require
write access when it really needs it. Anyway, if sensor access doesn't
require write access then a libsensors-based implementation becomes
possible.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
