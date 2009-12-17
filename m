From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Dec 2009 21:37:48 +0000
Subject: Re: [lm-sensors] Temperature for AMD Phenum ll X4 955 with
Message-Id: <20091217223748.720decc9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <e37498430912050507t7324549du284eaf9c046a58d@mail.gmail.com>
In-Reply-To: <e37498430912050507t7324549du284eaf9c046a58d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nima,

Please avoid top-posting.

On Thu, 17 Dec 2009 02:39:51 +0330, nima chavooshi wrote:
> Thanks for announcement and developing
> Can I apply that patch on 2.6.30-2??

It should work, yes. Maybe you'll have conflicts in Kconfig and
Makefile but these should be trivial to fix.

> May you give some information about F71889FG? what thing does this chip
> monitor ??

This is a full-features monitoring chip: 9 voltage inputs, 3
temperature inputs, 4 fan inputs and 4 PWM outputs (for fan control.)
What is monitored exactly depends on how the chip is wired on your
board though.

> The link for F71889FG is corrupted!!

I just double-checked, it works fine for me. That being said, the patch
in question applies on top of 3 cleanup patches for the f71882fg
driver, so you would have to apply these first. It might be easier to
pick the f71882fg.c file as it exists in Linus' tree, and build the
driver out-of-tree. I've put the files there for you:

http://khali.linux-fr.org/devel/misc/f71882fg/

While I was there I did the same for k10temp:

http://khali.linux-fr.org/devel/misc/k10temp/

Hopefully it will help you test the drivers.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
