From: andrei@srr.ro (Andrei Boros)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm-sensors-2.7.0 on kernel 2.2.17 problems
Message-Id: <4047004D.82C2C16@srr.ro>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


 Hi!

I was trying to compile lm-sensors-2.7.0 on a kernel-2.2.17 system and
got boggled down with multiple compilation errors. Here's a summary :
(note : i2c-2.7.0 already compiled and installed, no problems)
(note : kernel source is a clean tree from www.kernel.org, also
currently running kernel, headers  are symlinked to the source tree.
Kernel has a few unrelated enhancement patches. (routing and traffic
control)).

For both i2c and lm-sensors I used method 1 : separate build.

-----------------------------------------------------------------

kernel/chips/lm92.c : line 180 : undeclared identifier mutex
solved by taking the following definition from kernel/buses/ali1535.c

#ifndef DECLARE_MUTEX
#define DECLARE_MUTEX(name)  struct semaphore name = MUTEX
#endif /* def DECLARE_MUTEX */

-----------------------------------------------------------------

Observation : kernel/chips/ds1307 doesn't seem to be activated in the
makefile.

-----------------------------------------------------------------

kernel/chips/lm92.c : line 302 : undeclared identifier THIS_MODULE
solved by adding definition from adm1021.c

#ifndef THIS_MODULE
#define THIS_MODULE NULL
#endif

-----------------------------------------------------------------

kernel/busses/i2c-amd8111.c: In function `amd8111_probe':
kernel/busses/i2c-amd8111.c:400: `IORESOURCE_IO' undeclared (first use
in this function)
kernel/busses/i2c-amd8111.c:400: (Each undeclared identifier is reported
only once
kernel/busses/i2c-amd8111.c:400: for each function it appears in.)

Couldn't find a similar identifier in another lm-sensors module, so I
commented this one in Module.mk

-----------------------------------------------------------------

Finally, after install, I get this : 
/lib/modules/2.2.17/misc/smbus-arp.o: unresolved symbol(s)
Ignored, since I read about it being something for test purposes.


Below is a log of the runtime failures (couldn't get anything to work)
-----------------------------------------------------------------
output of lspci
dingo:~/2/lm_sensors-2.7.0# lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:09.0 Ethernet controller: Intel Corporation 82557 (rev 08)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! (rev 07)
00:0b.1 Input device controller: Creative Labs SB Live! Daughterboard
(rev 07)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device
475a (rev 7a)

sensors-detect : 
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:07.3: Intel 82371AB PIIX4 ACPI
Probe succesfully concluded.

dmesg:
i2c-piix4.o version 2.7.0 (20021208)
i2c-piix4.o: Found PIIX4 device

Attempting to load the driver -> insmod hangs.
(can't be killed)

-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune
