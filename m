From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: [PATCH] i2c-sis630 fixes for 2.6.0-test7
Message-Id: <200310101904.19719.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

attached you can find a patch that should fix i2c-sis630 driver for 2.6.0-X 
kernel. With i2c-sis630 from stock 2.6.0-X we have oops and driver was not 
correct registered against i2c-core.

Changes:
	1) fixed a oops while modprobing
	2) added check for buffer overflow for i2c block data read transaction
	3) added 'force' modprobe parameter. It's allow more easily testing for not 
yet supported SiS chips.

Please apply... Thanks.

-- 
Best regards,
Dipl.-Ing.
Alexander Malysh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-sis630.diff
Type: text/x-diff
Size: 5640 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031010/3ae9d41c/i2c-sis630.bin
