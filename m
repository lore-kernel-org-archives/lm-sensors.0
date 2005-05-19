From: baton@ozwide.net.au (Aaron Theodore)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: vt1211 2.6.6-mm4 patch
Message-Id: <010201c43f3c$a3b14d30$2500920a@bruce>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

heres a patch to get the via vt1211 working under the 2.6.6 kernel
(it should work under any 2.6 kernel though)

id spent weeks trying to get the vt1211 working under linux, after lotsa
searching i found:

http://jdelvare.net1.nerim.net/sensors/vt1211.c

it compiled fine in 2.6  but all the devices in sysfs were wrong so i edited
this file to follow the 2.6 naming convention

so here the patch is:
http://bat.ath.cx/vt1211-2.6.6-mm4.patch.gz
(also attatched to email)

enjoy!

latero

Aaron Theodore
-------------- next part --------------
A non-text attachment was scrubbed...
Name: vt1211-2.6.6-mm4.patch.gz
Type: application/x-gzip
Size: 6106 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040522/e701c69b/vt1211-2.6.6-mm4.patch.gz
