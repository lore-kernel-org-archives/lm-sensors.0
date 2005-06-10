From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 10 Jun 2005 19:42:56 +0000
Subject: [lm-sensors] [PATCH]: Add automatic PWM mode to it87.c
Message-Id: <20050610194224.063dbc67.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <429CEBC2.80609@hasw.net>
In-Reply-To: <429CEBC2.80609@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

> > http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012597.html
> > 
> > This will also have the advantage that you'll see how the new sysfs
> > callbacks can be written, and this should hopefully make your code
> > much more simple.
> 
> Ok, is this patch against 2.6.12-rc5? Because it fails to apply.

It was against Greg's current i2c tree as I wrote it. The easier for you
would be to start from 2.6.12-rc6 + this patch:

http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.12-rc6-i2c.patch.gz

Or the latest -mm, at your option (but be aware that
linux-2.6.12-rc6-mm1 has a few known issues WRT hardware monitoring.)

Both include the all the latest it87 patches.

> it87: Found IT8705F chip at 0x290, revision 3

Hey, lucky you. I'd like to have this one, but unfortunately mine is
revision 2 only. So, yours implements the newer auto-pwm model, while
mine implements the old one. You might even get VID readings if your
chip was wired for this.

-- 
Jean Delvare
