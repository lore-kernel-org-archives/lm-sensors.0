From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Possible bug in i2c_register_entry ?
Message-Id: <20040929070831.M24929@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <6C25030C55C5D84FBEFD632E96673065310998@mtlmail1.Co.Corp.VerintSystems.com>
In-Reply-To: <6C25030C55C5D84FBEFD632E96673065310998@mtlmail1.Co.Corp.VerintSystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Bonjour Louis-Martin,

> I'm writing a device driver for a Philips PCA9555 chip, which is a 
> 16-bit I/O port with interrupt I2C device.

I remember we have been discussing about this chip some times ago. A guy named
MonMotha was working on a driver like one year ago.

Chosen mailing-list threads:
http://archives.andrew.net.au/lm-sensors/msg03241.html
http://archives.andrew.net.au/lm-sensors/msg06033.html

You will find driver code at the end of the second thread, in case you want to
compare with what you have.

> Since our project in for an embedded system, the driver itself it 
> tightly bound to the way the chip is integrated into our hardware. I 
> doubt it is of any interest for anyone outside, considering it 
> relies on a homebrewed CPLD for interrupt management.

I understand your point. I will be working with a PCA9556 myself pretty soon,
and am facing the same problem. The chip could be used for completely
different things in other systems, so writing a generic driver doesn't seem to
make much sense. Maybe I'll end up writing a driver though, with a low-level
interface only accessible to other kernel modules and not user-space. I have
to think about it a little more.

The idea of having a driver for these chip is that we don't want people to
rewrite code which already exists.

> However, before doing that, I "backported" the LM77 driver found in 
> Linux 2.6 to Linux 2.4. If you are interested in getting it, I will 
> be glad to provide it. Just tell me where to submit it, and maybe 
> give me 1 hour to remove customizations I made for supporting our 
> embedded platform (like interrupts)! The basic functionality (temp 
> read/write) should run fine on any host hardware (PC / Mac / 
> whatever).

Yes, we are interested. The prefered form is a patch against the latest
lm_sensors2 CVS tree. Note that we are in a feature freeze state for now,
until we release 2.8.8. This should happen within a week or two. You can still
provide a patch now and we'll apply it later.

Ideally the patch would contain a kernel driver in kernel/chips, changes to
kernel/chips/Module.mk for it to be recognized, updates to libsensors, a new
section in etc/sensors.conf.eg, updates to prog/sensors, an update to
doc/chips/SUMMARY and documentation in doc/chips/lm77. If you only provide
part of this, this is welcome too.

> Thanks for getting back to me.
> Merci !

Tout le plaisir est pour moi :)

-- 
Jean Delvare
http://khali.linux-fr.org/
