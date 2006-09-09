From: vsu@altlinux.ru (Sergey Vlasov)
Date: Sat, 09 Sep 2006 18:02:56 +0000
Subject: [lm-sensors] [PATCH] watchdog: add support for w83697hg chip
Message-Id: <20060909220256.d4486a4f.vsu@altlinux.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <87fyf5jnkj.fsf@willow.rfc1149.net>
	<1157815525.6877.43.camel@localhost.localdomain>
In-Reply-To: <1157815525.6877.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Samuel Tardieu <sam@rfc1149.net>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sat, 09 Sep 2006 16:25:25 +0100 Alan Cox wrote:

> Ar Mer, 2006-09-06 am 12:29 +0200, ysgrifennodd Samuel Tardieu:
> > +static unsigned char
> > +w83697hg_get_reg(unsigned char reg)
> > +{
> > +	outb_p(reg, W83697HG_EFIR);
> > +	return inb_p(W83697HG_EFDR);
> > +}
> 
> No kernel level locking anywhere in the driver. Yet you could have two
> people accessing it at once.

Actually the situation is worse.  This driver pokes at SuperIO
configuration registers, which are shared by all logical devices of the
SuperIO chip.  There are other drivers which touch these registers -
e.g., drivers/hwmon/w83627hf.c handles the hardware monitor part of this
chip; many other hwmon drivers handle other SuperIO devices.  Hardware
monitor drivers access the SuperIO config during initialization and do
not request that port region, therefore loading hwmon drivers when
w83697hf_wdt is loaded can lead to conflicts.

More places which seem to touch SuperIO config:

  - drivers/parport/parport_pc.c
  - drivers/net/irda/nsc-ircc.c
  - drivers/net/irda/smsc-ircc2.c
  - drivers/net/irda/via-ircc.h

I can find at least two attempts to fix the SuperIO problem:

  - a SuperIO subsystem proposed by Evgeniy Polyakov (cc'd);

  - a simple SuperIO locks coordinator proposed by Jim Cromie (also
    cc'd; http://thread.gmane.org/gmane.linux.drivers.sensors/10052 -
    can't find actual patches).

However, the mainline kernel still does not have anything for proper
SuperIO access locking.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060909/b34f08ee/attachment.bin 
