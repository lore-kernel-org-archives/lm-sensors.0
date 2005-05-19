From: alexander.pohl@tu-berlin.de (Alexander Pohl)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: Intel 82801DA ICH4
Message-Id: <32787.62.246.185.231.1058905435.squirrel@mailbox.TU-Berlin.DE>
List-Id: <lm-sensors.vger.kernel.org>
References: <32803.62.246.166.13.1058892758.squirrel@mailbox.TU-Berlin.DE>
In-Reply-To: <32803.62.246.166.13.1058892758.squirrel@mailbox.TU-Berlin.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have some trouble compiling the module p4b_smbus.o and adding support
for the i2c-bus. Adding support for pci-hotplug to my kernel was
successful.
(reference to ticket # 1345)


Here the compiler output:

cc  -D__SMP__ -DMODVERSIONS -include
/lib/modules/2.4.20-hotplug/build/include/linux/modversions.h -D__KERNEL__
-DMODULE -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -I/lib/modules/2.4.20-hotplug/build/include   -c -o
p4b_smbus.o p4b_smbus.c
p4b_smbus.c: In function `cleanup_module':
p4b_smbus.c:263: incompatible type for argument 1 of `write_lock'
p4b_smbus.c:268: invalid type argument of `->'
make: *** [p4b_smbus.o] Error 1


Here what setpci said:

setpci -d 24C0:24C3 f2.w
setpci: Warning: No devices selected for `f2.w'.


Thanks for your fast respond,
Alexander Pohl


