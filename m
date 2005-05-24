From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Tue, 24 May 2005 19:27:17 +0000
Subject: [lm-sensors] Speeding up i2c-algo-bit.c?
Message-Id: <20050524172703.GC17974@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

currently the bit shift algorithm in i2c-algo-bit.c is using at least
27 udelays per byte (3 per bit and another 3 per byte).

Can this be optimized for a block transfer? Does one need to check for
a timeout on each bit or is there a persistent error flag that can be
checked after a larger transaction?

The background is an i2c interface on a TV capture card which is used
for a firmware upload (a Hauppauge WinTV 150). The firmware is 14kB
and takes ~4-5 seconds of upload time on 100kHz.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.atrpms.net/pipermail/lm-sensors/attachments/20050524/0fe6b125/attachment.bin
