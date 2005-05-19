From: mda@discerning.com (Mark D. Anderson)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: bmcsensors.c won't compile in 2.9.0
Message-Id: <1113198255.3499.231562842@webmail.messagingengine.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In 2.9.0, bmcsensors.c won't compile because of an
undefined symbol:

gcc  -D__SMP__ -DMODVERSIONS -include
/lib/modules/2.4.29-5asl-mda/build/include/linux/modversions.h
-D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikerne\
l/include -I/usr/local/include 
-I/lib/modules/2.4.29-5asl-mda/build/include -nostdinc -I
/usr/lib/gcc-lib/i386-redhat-linux/3.2.3/include  -Wall -O2  -c
kernel/chips/bmcs\
ensors.c -o kernel/chips/bmcsensors.o
kernel/chips/bmcsensors.c: In function `ipmi_sprintf':
kernel/chips/bmcsensors.c:220: warning: operation on `from' may be
undefined
kernel/chips/bmcsensors.c:221: warning: operation on `from' may be
undefined
kernel/chips/bmcsensors.c: In function `bmcsensors_select_thresholds':
kernel/chips/bmcsensors.c:300: `m' undeclared (first use in this
function)
kernel/chips/bmcsensors.c:300: (Each undeclared identifier is reported
only once
kernel/chips/bmcsensors.c:300: for each function it appears in.)
kernel/chips/bmcsensors.c: At top level:
kernel/chips/bmcsensors.c:45: warning: `addr_data' defined but not used

I fixed this by inserting a line in bmcsensors_select_threshold
to pull "m" out of the sd struct; beats me if that is correct:

static void bmcsensors_select_thresholds(struct sdrdata * sd)
{
+        long m = sd->m;
        u8 capab = sd->capab;
        u16 mask = sd->thresh_mask;

but this is making me if I'm doing something wrong -- why
would the most recent release have a fatal compile problem
for over 3 months?

-mda
