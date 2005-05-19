From: sig@netdot.net (Aaron VanDevender)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: sysconf generation
Message-Id: <1030668028.1578.41.camel@lazlo.netdot.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I noticed a problem with the way the sensors-detect script is generating
the /etc/sysconfig/lm_sensors file. Its numbering modules like MODULE_1
MODULE_2 MODULE_3 ..., when /prog/init/lm_sensors.init is expecting the
file to start counting at MODULE_0 and go to MODULE_($modules - 1). The
result is that the last module isn't loaded and the modprobe is run
without any arguments before the first module is loaded.

This patch on sensors-detect ought to do the trick:



3038c3038
<       my $i = 1;
---
>       my $i = 0;


Please CC any replies to me as I am not on this list.

cya
.sig
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 232 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020829/f7512595/attachment.bin
