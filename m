From: thomas.jarosch@intra2net.com (Thomas Jarosch)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [patch] i2c 2.9.1 compile fix
Message-Id: <200504291721.34111.thomas.jarosch@intra2net.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

attached is a patch to fix i2c-algo-bit.c compilation.
It was lacking the KERNEL_VERSION macro.

Please CC: comments.

Cheers,
Thomas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.4.30-i2c-2.9.1-fix.patch
Type: text/x-diff
Size: 449 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050429/90bfa117/linux-2.4.30-i2c-2.9.1-fix.bin
