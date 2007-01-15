From: christophe.dr@free.fr (christophe)
Date: Mon, 15 Jan 2007 22:41:14 +0000
Subject: [lm-sensors] No smbus on asus w1n laptop in spite of quirk > no
Message-Id: <200701152341.24349.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701071107.50461.christophe.dr@free.fr>
In-Reply-To: <200701071107.50461.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le Lundi 15 Janvier 2007 18:00, vous avez ?crit?:
> Hi Christophe,
> > >[...]
> > > You may read completely wrong temperature, hang the bus, stop the fan,
> > > force processor to throttle to prevent overheat. I think no real damage
> > > will happen, but be careful.
> >
> > OK, thanks a lot, i'll probably insert a modprobe -r thermmal
> > in /etc/rc.local .
>
> You should be able to prevent it from being loaded at all, which would
> be even better. Adding "blacklist thermal" to /etc/modprobe.conf or
> whatever your distribution has, should do the trick.

Ok i'll do that, thanks.

-- 
christophe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 191 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070115/8b1d0b01/attachment.bin 
