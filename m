From: merky_1@yahoo.com (Tom and Wendy)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Ticket 1159 update
Message-Id: <NCBBIHMBGFFKDDGNDMLKIEOGDMAA.merky_1@yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Added #define DEBUG 1 to kernel/chips/bmcsensors.c.

Now I am getting a compile error:

gcc  -D__SMP__ -DMODVERSIONS -include
/lib/modules/2.4.20/build/include/linux/modversions.h -D__KERNEL__ -DMODULE 
-DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/inclu
de -I/lib/modules/2.4.20/build/include   -O2   -c
kernel/chips/bmcsensors.c -o kernel/chips/bmcsensors.o
kernel/chips/bmcsensors.c: In function `bmcsensors_rcv_sdr_msg':
kernel/chips/bmcsensors.c:575: parse error before `else'
make: *** [kernel/chips/bmcsensors.o] Error 1

gcc --version
2.96

Redhat 7.2 with updates

Thanks.

-----Original Message-----
From: Nobody [mailto:nobody@Stimpy.netroedge.com]
Sent: Saturday, March 08, 2003 7:26 PM
To: merky_1@yahoo.com
Subject: ---== Lm_sensors Support DB Entry ==---


Your Lm_sensors support entry has been updated.

Please go to http://secure.netroedge.com/~lm78/support.html to check
the status of your entry.

Ticket # 1159

