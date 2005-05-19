From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040410143501.GA4678@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Fri, Apr 09, 2004 at 08:09:56PM +0200, Jean Delvare wrote:
> I've committed all the necessary changes to lm_sensors CVS. Hopefully it
> fix the issue. Please give it a try and confirm if you can.

I tried the fixes as you posted them here and the same issue persists :(

# depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.22-1.2174.nptl_44.rhfc1.at/kernel/arch/i386/kernel/powernow-k7.o
depmod:         dmi_broken
# find /usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at -name dmi_scan.\* | xargs grep EXPORT
/usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at/arch/i386/kernel/dmi_scan.c:EXPORT_SYMBOL(dmi_broken);
/usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at/drivers/i2c/dmi_scan.c:EXPORT_SYMBOL(dmi_ident);
/usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at/drivers/i2c/dmi_scan.c:EXPORT_SYMBOL(dmi_scan_mach);
# find /usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at -name dmi_scan.ver | xargs grep .
#define __ver_dmi_ident _ver_str(b6e4b69b)
#define dmi_ident _set_ver(dmi_ident)
#define __ver_dmi_scan_mach     _ver_str(0c5b4001)
#define dmi_scan_mach _set_ver(dmi_scan_mach)

I believe that two files may not have the same name and export the
same type of symbols (normal vs GPL), they will overwrite each
other. Note that the dmi_broken symbol is exported by the cpufreq
patch, so there is no guarantee that the kernel's dmi_scan will be
free of exports as currently assumed.

So maybe it is better to rename dmi_scan.* afterall? Or did I
patch/understand something wrong?

Thanks!
(and Happy Easter, of course ;)
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040410/0401d08e/attachment.bin
