From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Jul 2009 20:32:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add WM835x PMIC hardware monitoring
Message-Id: <20090715223202.192a2cd9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1247671762-19506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1247671762-19506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 15 Jul 2009 21:27:44 +0100, Mark Brown wrote:
> On Wed, Jul 15, 2009 at 10:09:37PM +0200, Jean Delvare wrote:
> 
> > I'm pretty busy at the moment and normally I wouldn't go for a driver
> > review, but this one seems simple enough and as I recall, I owe you
> > one. So I'll review your code as my time permits, stay tuned.
> 
> Thanks.  I just realised that I sent you the wrong version of the patch
> (got confused juggling a fairly large patch queue) - I'll follow up
> later tonight or tomorrow with a fixed one, please wait for that.
> Apologies for the noise.

OK, no problem.

> Is there someone else I should send hwmon stuff to instead if you don't
> normally review this?  There is no entry in MAINTAINERS.

You'd send the patch to the list and hope that someone will pick it and
review it. But chances are thin. Other possibilities are finding
someone else interested in support for that specific chip and have
him/her review and test your driver. Then usually Andrew Morton can
pick the patch and push it upstream.

Or you can volunteer to be the new hwmon subsystem maintainer and send
the patch to Linus yourself ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
