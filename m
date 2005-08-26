From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 26 Aug 2005 00:03:11 +0000
Subject: [lm-sensors] Re: [PATCH] drivers/hwmon/*: kfree() correct pointers
Message-Id: <20050826000231.35b97af9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050825205629.22372.qmail@lwn.net>
	<20050825214913.GA31605@mipter.zuzino.mipt.ru>
In-Reply-To: <20050825214913.GA31605@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jonathan Corbet <corbet@lwn.net>

Hi Alexey,

> The adm9240 driver, in adm9240_detect(), allocates a structure.  The
> error path attempts to kfree() ->client field of it (second one),
> resulting in an oops (or slab corruption) if the hardware is not
> present.
> 
> ->client field in adm1026, adm1031, smsc47b397 and smsc47m1 is the
> first in ${HWMON}_data structure, but fix them too.

Already fixed in Greg's i2c tree and -mm for quite some time now...

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-i2c/i2c-hwmon-class-01.patch

Thanks,
-- 
Jean Delvare
