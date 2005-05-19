From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040119090235.GB22028@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm having trouble understanding symbol exports :(

Some kernel modules, notably the ones from cpufreq, require an
exported dmi_broken. The RH kernel sources I use as a base to patch
i2c/lm_sensors 2.8.x upon, have a patch for exporting it, and
dmi_scan.o/.ver have indeed the exported modversioned symbol.

After the i2c patch the symbol dissapears, although the source still
has EXPORT_SYMBOL(dmi_broken)! Help! :)

RH kernel sources:                               linux-2.4.22-1.2163.nptl
ATrpms kernel sources with i2c/lm_sensors 2.8.2: linux-2.4.22-1.2163.nptl_32.rhfc1.at

# find linux-2.4.22-1.2163.nptl* -name dmi_scan.\*
linux-2.4.22-1.2163.nptl/arch/i386/kernel/dmi_scan.c
linux-2.4.22-1.2163.nptl/drivers/i2c/dmi_scan.c
linux-2.4.22-1.2163.nptl/drivers/i2c/dmi_scan.h
linux-2.4.22-1.2163.nptl/include/linux/modules/dmi_scan.stamp
linux-2.4.22-1.2163.nptl/include/linux/modules/dmi_scan.ver
linux-2.4.22-1.2163.nptl_32.rhfc1.at/arch/i386/kernel/dmi_scan.c
linux-2.4.22-1.2163.nptl_32.rhfc1.at/drivers/i2c/dmi_scan.c
linux-2.4.22-1.2163.nptl_32.rhfc1.at/include/linux/dmi_scan.h
linux-2.4.22-1.2163.nptl_32.rhfc1.at/include/linux/modules/dmi_scan.stamp
linux-2.4.22-1.2163.nptl_32.rhfc1.at/include/linux/modules/dmi_scan.ver
# find linux-2.4.22-1.2163.nptl* -name dmi_scan.\* | xargs grep EXPORT
linux-2.4.22-1.2163.nptl/arch/i386/kernel/dmi_scan.c:EXPORT_SYMBOL(dmi_broken);
linux-2.4.22-1.2163.nptl/drivers/i2c/dmi_scan.c:EXPORT_SYMBOL_GPL(dmi_ident);
linux-2.4.22-1.2163.nptl/drivers/i2c/dmi_scan.c:EXPORT_SYMBOL_GPL(dmi_scan_machine);
linux-2.4.22-1.2163.nptl_32.rhfc1.at/arch/i386/kernel/dmi_scan.c:EXPORT_SYMBOL(dmi_broken);
linux-2.4.22-1.2163.nptl_32.rhfc1.at/drivers/i2c/dmi_scan.c:EXPORT_SYMBOL(dmi_ident);
linux-2.4.22-1.2163.nptl_32.rhfc1.at/drivers/i2c/dmi_scan.c:EXPORT_SYMBOL(dmi_scan_mach);
# find linux-2.4.22-1.2163.nptl* -name dmi_scan.ver | xargs grep .
linux-2.4.22-1.2163.nptl/include/linux/modules/dmi_scan.ver:#if  defined(__module__smp) || defined(__module__up) || defined(__module__BOOT)
linux-2.4.22-1.2163.nptl/include/linux/modules/dmi_scan.ver:#define __ver_dmi_broken    _ver_str(565bcd17)
linux-2.4.22-1.2163.nptl/include/linux/modules/dmi_scan.ver:#define dmi_broken _set_ver(dmi_broken)
linux-2.4.22-1.2163.nptl/include/linux/modules/dmi_scan.ver:#endif
linux-2.4.22-1.2163.nptl_32.rhfc1.at/include/linux/modules/dmi_scan.ver:#define __ver_dmi_ident _ver_str(b6e4b69b)
linux-2.4.22-1.2163.nptl_32.rhfc1.at/include/linux/modules/dmi_scan.ver:#define dmi_ident _set_ver(dmi_ident)
linux-2.4.22-1.2163.nptl_32.rhfc1.at/include/linux/modules/dmi_scan.ver:#define __ver_dmi_scan_mach     _ver_str(0c5b4001)
linux-2.4.22-1.2163.nptl_32.rhfc1.at/include/linux/modules/dmi_scan.ver:#define dmi_scan_mach _set_ver(dmi_scan_mach)

It looks as if the EXPORT_SYMBOLs of drivers/i2c/dmi_scan.c override
the ones from arch/i386/kernel/dmi_scan.c. Previously
drivers/i2c/dmi_scan.c had only EXPORT_SYMBOL_GPL.
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040119/8a823782/attachment.bin
