From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-Id: <20050206153600.2d8fb127.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4202BBF9.3020104@mvista.com>
	<3s6eEus2.1107510325.6106480.khali@localhost>
In-Reply-To: <3s6eEus2.1107510325.6106480.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Dobriyan <adobriyan@mail.ru>, "Mark A. Greer" <mgreer@mvista.com>
Cc: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

Hi all,

Quoting myself:
> I am as surprised as you are to see this here. I2C_ALGO_AU1550 should
> really be made a different value. There is also a problem with
> I2C_ALGO_PCA and I2C_ALGO_SIBYTE having the same value, which was
> already reported to Greg some days ago if memory serves. I think I
> will send a patch against 2.6.10-rc3 to Linus this evening, which
> fixes the broken algo IDs. That way Mark can keep the algorithm ID he
> is using right now, and each algorithm will get its own, unique ID, as
> should be.

I've changed my mind since. There isn't anything critical here and
pushing random patches to Linus right before he releases 2.6.11 wouldn't
have been particularly subtle. So I instead sent a patch to Greg, as can
be seen here:
http://archives.andrew.net.au/lm-sensors/msg29405.html

So Mark, providing Greg accepts this patch, you can assume that
I2C_ALGO_MV64XXX is already properly defined in Greg's tree (where your
own patch will end up) so you don't need to add it yourself. You will
still have to define I2C_HW_MV64XXX though.

Thanks,
-- 
Jean Delvare
