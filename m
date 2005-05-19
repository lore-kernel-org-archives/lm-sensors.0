From: andi@rhlx01.fht-esslingen.de (Andreas Mohr)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: 2.6.4: strange (?) include path order
Message-Id: <20020807205413.A23077@rhlx01.fht-esslingen.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,

I just tried compiling lm_sensors-2.6.4.
This didn't quite work:

gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__=
KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include=
 -I/usr/local/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c=
-ali1535.c -o kernel/busses/i2c-ali1535.o
kernel/busses/i2c-ali1535.c:183: `I2C_HW_SMBUS_ALI1535' undeclared here (no=
t in
a function)
kernel/busses/i2c-ali1535.c:183: initializer element is not constant
kernel/busses/i2c-ali1535.c:183: (near initialization for `ali1535_adapter.=
id')
make: *** [kernel/busses/i2c-ali1535.o] Fehler 1
root@andi:/usr/src/system/lm_sensors-2.6.4#

This is because I have an old i2c.h header in /usr/local/include.

Why do you specify /usr/local/include before /usr/src/linux/include ??
In this case it was fatal.

I guess you can safely assume that /usr/src/linux is the most recent tree.

BTW:

  Bus  0, device   0, function  1:
    IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 208).
      IRQ 14.
      Master Capable.  Latencyd.
      I/O at 0x4000 [0x400f].
  Bus  0, device   1, function  0:
    ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 1).

And on another system:
  Bus  0, device   2, function  0:
    ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 0).
  Bus  0, device   2, function  3:
    USB Controller: Silicon Integrated Systems [SiS] 7001 (#2) (rev 7).
      IRQ 11.
      Master Capable.  Latencyd.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xcffff000 [0xcfffffff].
  Bus  0, device   2, function  2:
    USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 7).
      IRQ 5.
      Master Capable.  Latencyd.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xcfffe000 [0xcfffefff].
  Bus  0, device   2, function  5:
    IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 208).
      Master Capable.  Latency=16.
      I/O at 0xff00 [0xff0f].

See ? I'm an "SiS only" house (well, not quite). :-)
(this is a GA586SGX and K7S5A, respectively)

BTW, I've even got 5595 chipset specs !!!

Needless to say I'll try to have a go about the 5511/12/13 misdetection iss=
ue.

Have fun !

--=20
Andreas Mohr                        Stauferstr. 6, D-71272 Renningen, Germa=
ny
Tel. +49 7159 800604                http://mohr.de.tt
