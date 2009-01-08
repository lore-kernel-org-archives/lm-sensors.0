From: Nick Pasich <NewsLetters@NickAndBarb.net>
Date: Thu, 08 Jan 2009 04:21:15 +0000
Subject: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <49657F3B.3060607@NickAndBarb.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Starting getting this error after upgrading from 2.6.26.2 to 2.6.27.10

 > modprobe -v abituguru3

FATAL: Error inserting abituguru3 
(/lib/modules/2.6.27.10-smp/kernel/drivers/hwmon/abituguru3.ko): No such 
device

syslog info:

Jan  7 20:00:46 localhost kernel: abituguru3: no Abit uGuru3 found, data 
= 0x00, cmd = 0xFF


Mother Board: Abit IP35 Pro

Anyone else experiencing the same thing??
 
Thanks,

Nick Pasich



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
