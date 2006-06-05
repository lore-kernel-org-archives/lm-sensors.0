From: ymu@winbond.com (Yuan Mu)
Date: Mon, 05 Jun 2006 06:57:18 +0000
Subject: [lm-sensors] an error when compile lm_sensors2
Message-Id: <4483D5CE.40801@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
When i compile lm_sensors2 on kernel 2.4 i met a error

kernel/busses/i2c-viapro.c: In function `vt596_probe':
kernel/busses/i2c-viapro.c:398: `PCI_DEVICE_ID_VIA_8237' undeclared (first use in this function)
kernel/busses/i2c-viapro.c:398: (Each undeclared identifier is reported only once
kernel/busses/i2c-viapro.c:398: for each function it appears in.)
make: *** [kernel/busses/i2c-viapro.o] Error 1

I just copy the definition of PCI_DEVICE_ID_VIA_8237 above function vt596_probe to skip this error.
did i missing some configure?

[root at ccxserver i2c]# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --with-system-zlib --enable-__cxa_atexit --host=i386-redhat-linux
Thread model: posix
gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
[root at ccxserver i2c]# uname -a
Linux ccxserver 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 i686 i386 GNU/Linux

-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

