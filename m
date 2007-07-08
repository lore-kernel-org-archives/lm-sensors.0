From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jul 2007 18:33:44 +0000
Subject: Re: [lm-sensors] try to run MAKEDEV if i2c-dev device files are
Message-Id: <20070708203344.45b2b7f5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070707215305.6211e914@hyperion.delvare>
In-Reply-To: <20070707215305.6211e914@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 08 Jul 2007 07:54:29 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > First of all, a question: how many i2c device nodes does your MAKEDEV
> > create? The one I have in Slackware 9.1 only creates i2c-0 and i2c-1.
> > This might not be sufficient. Not our fault though.
> 
> Mine version create i2c-0 - i2c-7

Much more reasonable.

> > Secondly, MAKEDEV was in /dev on Slackware, so maybe we could test both
> > locations?
> 
> I had laready thought about that, as it used to be in /dev with Fedora / RH 
> once too, but that was a long time ago. I thought al distro's would have fixed 
> that by now.
> 
> I'll add checking for and running of /dev/MAKEDEV to svn in a couple of minutes.

Good, thanks.

> > Then, the good news is that we should be able to drop the reference to
> > prog/mkdev/mkdev.sh, and finally delete it from the lm-sensors package
> > (in branch 3.0.0). I don't plan to move it to i2c-tools. On new systems
> > it's not needed. On old systems, MAKEDEV should do the work.

I've done that now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
