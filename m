From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040410154829.GD4678@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 10, 2004 at 05:22:15PM +0200, Jean Delvare wrote:
> > I tried the fixes as you posted them here and the same issue persists
> > :(
> > 
> > # find /usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at -name dmi_scan.\* | xargs grep EXPORT
> > /usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at/arch/i386/kernel/dmi_scan.c:EXPORT_SYMBOL(dmi_broken);
> > /usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at/drivers/i2c/dmi_scan.c:EXPORT_SYMBOL(dmi_ident);
> > /usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at/drivers/i2c/dmi_scan.c:EXPORT_SYMBOL(dmi_scan_mach);
> 
> That can't be with mkpatch from CVS. We do *not* add our own dmi_scan.c
> file anymore.

No, I used the patches posted here. Does CVS have more changes applied
than these?

At any rate I'll reiterate a build straight from the CVS, and check
whether dmi_scan.c sneaks in again. ;)

Thanks.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040410/e43949da/attachment.bin
