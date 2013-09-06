From: singumal <qdmd-pu1o@dea.spamcon.org>
Date: Fri, 06 Sep 2013 15:37:43 +0000
Subject: [lm-sensors] Cannot compile w83627ehf standalone driver
Message-Id: <4gtj299ua16tgbppavpscp3ljolbrs8o8r@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have an ASRock IMB-170 Mini-ITX board; 3.3.4's sensors-detect shows:

  Found `Winbond W83627UHG/NCT6627UD Super IO Sensors'        Success!
      (address 0x290, driver `w83627ehf')

I'm on an older kernel, and I can't seem to compile the driver
from:

   http://khali.linux-fr.org/devel/lm-sensors/drivers/w83627ehf/


[root@plain1 driver]# uname -a
Linux plain1 2.6.18-274.el5 #1 SMP Fri Jul 22 04:43:29 EDT 2011 x86_64 x86_64 x86_64 GNU/Linux
[root@plain1 driver]# make
  CC [M]  /root/driver/w83627ehf.o
/root/driver/w83627ehf.c: In function `in_from_reg':
/root/driver/w83627ehf.c:416: error: implicit declaration of function `DIV_ROUND_CLOSEST'
... [many more errors and warnings]


I think I have the environment needed:

[root@plain1 ~]# ls /lib/modules/$(uname -r)/build
arch     init            mm              scripts
block    ipc             Module.kabi     security
crypto   kabi_whitelist  Module.markers  sound
drivers  kernel          Module.symvers  symsets-2.6.18-274.el5.tar.gz
fs       lib             net             usr
include  Makefile        samples
[root@plain1 ~]# ls -l /boot/System.map-2.6.18-274.el5
-rw-r--r-- 1 root root 1268851 Jul 22  2011 /boot/System.map-2.6.18-274.el5


I have previously compiled other drivers OK for other boards using this distro, so I'm not sure where to go from here.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
