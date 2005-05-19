From: yml@yml.com (Yermo M. Lamers)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Unresolved Symbols question lm_sensors 2.8.0/i2c 2.8.0/linux
Message-Id: <3F7B83FF.2060409@yml.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I am getting an unresolved symbol (dmi_scan_match) trying to install 
lm_sensors 2.8.0 and i2c 2.8.0 under stock RedHat Linux 9.0 install.

I am running on a SuperMicro Dual PIII P3TDLE motherboard.

     http://www.supermicro.com/PRODUCT/MotherBoards/RCC_LE/P3TDLE.htm

I have not been able to verify what sensor chip it uses but from lspci -v:

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
	Subsystem: ServerWorks OSB4 South Bridge
	Flags: bus master, medium devsel, latency 0


Output from sensors_detect:

[root@nbi_master lm_sensors-2.8.0]# ./prog/detect/sensors-detect
  This program will help you to determine which I2C/SMBus modules you 
need to
  load to use lm_sensors most effectively.
  You need to have done a `make install', issued a `depmod -a' and made sure
  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
  module path before you can use some functions of this utility. Read
  doc/modules for more information.
  Also, you need to be `root', or at least have access to the 
/dev/i2c[-/]* files for some things. You can use prog/mkdev/mkdev.sh to 
create these /dev files
  if you do not have them already.
  If you have patched your kernel and have some drivers built-in you can
  safely answer NO if asked to load some modules. In this case, things may
  seem a bit confusing, but they will still work.

  BIOS vendor (ACPI): AMI
  System vendor (DMI): Supermicro
  BIOS version (DMI): 0700xx
  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks OSB4 South Bridge
Probe succesfully concluded.

  We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.20-8smp/kernel/drivers/i2c/busses/i2c-piix4.o: 
unresolved symbol dmi_scan_mach
/lib/modules/2.4.20-8smp/kernel/drivers/i2c/busses/i2c-piix4.o: insmod 
/lib/modules/2.4.20-8smp/kernel/drivers/i2c/busses/i2c-piix4.o failed
/lib/modules/2.4.20-8smp/kernel/drivers/i2c/busses/i2c-piix4.o: insmod 
i2c-piix4 failed
Loading failed... skipping.
  Do you now want to be prompted for non-detectable adapters? (yes/NO):

I have the corresponding source for the kernel I am running:

[root@nbi_master i2c-2.8.0]# cat /proc/version
Linux version 2.4.20-8smp (bhcompile@porky.devel.redhat.com) (gcc 
version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP Thu Mar 13 
17:45:54 EST 2003

[root@nbi_master i2c-2.8.0]# ls /lib/modules/2.4.20-8smp/build/
arch             Documentation  kernel       README
configs          drivers        lib          REPORTING-BUGS
COPYING          fs             MAINTAINERS  Rules.make
COPYING.modules  include        Makefile     scripts
CREDITS          init           mm           tmp_include_depends
crypto           ipc            net


What am I doing wrong?

If I can be of any assistance in tracking this down please contact me 
here at yml@yml.com

thank you for your time,

-- Yermo


-- 
---------------------------------------------------------------------
DTLink Software                                 http://www.dtlink.com
---------------------------------------------------------------------
