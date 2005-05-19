From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: i2c & lm_sensors for RH
Message-Id: <20030810190733.GA18582@puariko.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802172008.GA10034@puariko.nirvana>
In-Reply-To: <20030802172008.GA10034@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have uploaded

o latest RH kernel with i2c/lm_sensors 2.8.0 patched in
o lm_sensors 2.8.0 userland
o bttv with i2c 2.8.0 patches
o ivtv with i2c 2.8.0 patches
o saa7134 with i2c 2.8.0 patches

for the current three RH releases (9, 8.0 and 7.3)
at http://atrpms.physik.fu-berlin.de/

Many thanks for all the help!!! I hope those rpms will be helpful to
the lm_sensors community!

There is another i2c application that break with the i2c changes:
lirc. At least the current CVS code bails out. Could you provide a
patch for the CVS bits (non-CVS is far to old)? :)

Thanks, Axel.
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030810/1a8540d3/attachment.bin
