From: christophe.dr@free.fr (Christophe de =?iso-8859-1?q?Rivi=E8re?=)
Date: Mon, 15 Jan 2007 07:37:16 +0000
Subject: [lm-sensors] No smbus on asus w1n laptop in spite of quirk > no
Message-Id: <200701150837.27235.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701071107.50461.christophe.dr@free.fr>
In-Reply-To: <200701071107.50461.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le Dimanche 14 Janvier 2007 21:56, vous avez ?crit?:
>[...]but both thermal and lm85
> > modules are loaded and no crash detected.
> > What is the risk ?
> You may read completely wrong temperature, hang the bus, stop the fan,
> force processor to throttle to prevent overheat. I think no real damage
> will happen, but be careful.

OK, thanks a lot, i'll probably insert a modprobe -r thermmal 
in /etc/rc.local .

-- 
christophe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 191 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070115/98991fd6/attachment-0001.bin 
