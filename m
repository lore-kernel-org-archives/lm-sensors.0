From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Thu, 13 Nov 2008 11:54:36 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <20081113115436.GA21134@roarinelk.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Howdy Jean,

On Thu, Nov 13, 2008 at 11:05:22AM +0100, Jean Delvare wrote:
> Hi Manuel,
> 
> On Wed, 12 Nov 2008 23:06:03 +0100, Manuel Lauss wrote:
> > Good evening,
> > 
> > On Wed, Nov 12, 2008 at 09:39:49PM +0100, Jean Delvare wrote:
> > > Yes, this version of the patch looks all OK to me. It simply needed
> > > some fixes to apply properly on top of Kaiwan's lm70 fixes.
> > > 
> > > Can you please test the following two patches:
> > > http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm70-01-fix-byte-order.patch
> > > http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm70-02-ti-tmp121-support.patch
> > > 
> > > and confirm that things work fine for you with them applied?
> > 
> > Actually I made a new one fixing a few things David pointed out and rebased
> > on top of Kaiwan's patch.  And, it's run-tested too ;-)

[patch snipped]
 
> Applied, thanks. I had to fix one hunk manually to apply after David's
> changes, hopefully I got it right. At least it builds ;)
> 
> Updated patches at:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm70-01-fix-byte-order.patch
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm70-02-ti-tmp121-support.patch

Works fine.

Thank you!
	Manuel Lauss

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
