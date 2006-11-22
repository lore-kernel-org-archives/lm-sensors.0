From: waltergoossens@home.nl (waltergoossens at home.nl)
Date: Wed, 22 Nov 2006 13:53:27 +0000
Subject: [lm-sensors] RFC patch to support max7311
Message-Id: <7922149.1164203607186.JavaMail.root@webmail2.tilbu1>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello everyone,

I wrote a patch for the max7311 IO Expander. It basically exposes all "registers" of the chip to userspace via sysfs.
This driver is tested on an XScale (ixp425) with kernel 2.6.17.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c_max7311_support.patch
Type: text/x-patch
Size: 12229 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061122/b3fc17a5/attachment.bin 
