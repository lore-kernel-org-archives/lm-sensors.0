From: powah <wong_powah@yahoo.ca>
Date: Wed, 21 Jan 2009 14:16:32 +0000
Subject: [lm-sensors] =?utf-8?q?cannot_install_lm=5Fsensors-2=2E5=2E5-x=2E?=
Message-Id: <loom.20090121T141214-149@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I cannot install lm_sensors-2.5.5-3.i386.rpm nor lm_sensors-2.5.5-6.i386.rpm on
RH 7.1.
The files complained by "failed dependencies" are present on my computer.
Why it fail to install?
Please help to fix the problem.
Thanks.

# rpm -ivh /home/tcma/rpm/lm_sensors-2.5.5-3.i386.rpm
error: failed dependencies:
        /sbin/ldconfig   is needed by lm_sensors-2.5.5-3
        /sbin/ldconfig   is needed by lm_sensors-2.5.5-3
        ld-linux.so.2   is needed by lm_sensors-2.5.5-3
        libc.so.6   is needed by lm_sensors-2.5.5-3
        /bin/sh   is needed by lm_sensors-2.5.5-3
        /usr/bin/perl   is needed by lm_sensors-2.5.5-3
        libc.so.6(GLIBC_2.0)   is needed by lm_sensors-2.5.5-3
        libc.so.6(GLIBC_2.1)   is needed by lm_sensors-2.5.5-3
        libc.so.6(GLIBC_2.1.3)   is needed by lm_sensors-2.5.5-3

# rpm -ivh /home/tcma/rpm/lm_sensors-2.5.5-6.i386.rpm
error: failed dependencies:
        /sbin/ldconfig   is needed by lm_sensors-2.5.5-6
        /sbin/ldconfig   is needed by lm_sensors-2.5.5-6
        ld-linux.so.2   is needed by lm_sensors-2.5.5-6
        libc.so.6   is needed by lm_sensors-2.5.5-6
        /bin/sh   is needed by lm_sensors-2.5.5-6
        /usr/bin/perl   is needed by lm_sensors-2.5.5-6
        libc.so.6(GLIBC_2.0)   is needed by lm_sensors-2.5.5-6
        libc.so.6(GLIBC_2.1)   is needed by lm_sensors-2.5.5-6
        libc.so.6(GLIBC_2.1.3)   is needed by lm_sensors-2.5.5-6
# uname -a
Linux pc1 2.4.7-10 #1 Thu Sep 6 17:27:27 EDT 2001 i686 unknown

# ls -l   /usr/bin/perl
-rwxr-xr-x    2 root     root       708188 Aug  9  2001 /usr/bin/perl

# ls -l /sbin/ldconfig
-rwxr-xr-x    1 root     root       460872 Sep  4  2001 /sbin/ldconfig



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
