From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Upcoming rpms: i2c headers under /usr/include/i2c
Message-Id: <20050103011512.GG7814@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041230173527.GF10397@neu.nirvana>
In-Reply-To: <20041230173527.GF10397@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 02, 2005 at 11:26:13AM +0100, Jean Delvare wrote:
> > Where should kernel space headers for building depending kernel
> > modules go? You need the "i2c-kernheaders" at least for building
> > the lm_sensors kernel modules.

> > Perhaps /usr/include/linux is for userland
> > interfacing the kernel, but then there is no FHS place for
> > kernel-kernel headers (they are assumed to be hiding in the kernel
> > source only). Perhaps per kernel /lib/modules/.../{source,build}
> > locations would have been more appropriate.
> 
> I have no idea where the correct location would be, so anything you come
> with is fine with me.

Perhaps indeed /usr/include/i2c/linux/i2c?

And I2C_HEADERS need to point (and default) to /usr/include/i2c, while

#include <linux/i2c/....>

picks the header either from a proper Linux kernel tree or from
I2C_HEADERS.

If not /usr/include/i2c then perhaps /usr/local/include/i2c to be in
sync with the other /usr/local defaults.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050103/aecfac20/attachment.bin
