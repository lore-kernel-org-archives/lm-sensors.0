From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Jun 2005 23:13:12 +0000
Subject: [lm-sensors] Re: [PATCH] I2C: add i2c driver for TPS6501x
Message-Id: <20050623231242.0be0c244.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1119417466126@kroah.com>
	<11194174663452@kroah.com>
In-Reply-To: <11194174663452@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Greg, David,

> [PATCH] I2C: add i2c driver for TPS6501x
> 
> This adds an I2C driver for the TPS6501x series of power management
> chips. It's used on many OMAP based boards, and this driver has been
> widely used in the Linux-OMAP trees over the last year or so.

There is a pending cleanup patch for this driver. It was posted by David
on the lm-sensors mailing list on May 27th:
  http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012409.html
Greg, Can you please add this patch to your i2c tree?

Note that I am not entierly happy with this driver even after the patch
is applied. It tries to load several times when the initial attempt
fails. That's ugly and inefficient. The retries should be done on failed
bus reads, rather than reloading the driver entirely on each error, so
that as few actions as possible are retried. Or the bus driver could be
improved to deal with errors at a lower level.

David, could you please work on a patch implementing either solution?

Thanks,
-- 
Jean Delvare
