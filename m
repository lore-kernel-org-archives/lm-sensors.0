From: Ian Pilcher <arequipeno@gmail.com>
Date: Mon, 12 Oct 2009 21:43:25 +0000
Subject: Re: [lm-sensors] "Dummy" sensor driver?
Message-Id: <4AD3A2FD.1090400@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hb011f$2p0$1@ger.gmane.org>
In-Reply-To: <hb011f$2p0$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/12/2009 03:52 PM, Jean Delvare wrote:
> We have a dummy i2c adapter driver, named i2c-stub (written by Mark M.
> Hoffman originally.) You can emulate up to 10 chips on it, supporting
> the basic SMBus transactions most I2C-based hwmon devices use. So, if
> you have a register dump from such a device, you can emulate it on any
> machine. I do that all the times when working on hwmon drivers for
> hardware I don't have.

Perfect!

> For example this works very well with the lm90 driver. If you want
> dumps from lm90-compatible chips, just let me know and I'll send them
> to you. This should also works reasonably well with most National
> Semiconductor and Analog Device chips. Just Winbond chips don't work
> well because they use banks and i2c-stub doesn't have support for that.

Please do send them.  My desktop system has a Winbond chip, so a dump
from it presumably wouldn't do any good.

> I wrote a helper script, which is in recent versions of the i2c-tools
> package, to load dumps to i2c-stub automatically (named
> i2c-stub-from-dump).

Thanks!

-- 
====================================
Ian Pilcher                                         arequipeno@gmail.com
====================================

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
