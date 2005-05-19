From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040410172215.3d6b6c87.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I tried the fixes as you posted them here and the same issue persists
> :(
> 
> # find /usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at -name dmi_scan.\* | xargs grep EXPORT
> /usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at/arch/i386/kernel/dmi_scan.c:EXPORT_SYMBOL(dmi_broken);
> /usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at/drivers/i2c/dmi_scan.c:EXPORT_SYMBOL(dmi_ident);
> /usr/src/linux-2.4.22-1.2174.nptl_44.rhfc1.at/drivers/i2c/dmi_scan.c:EXPORT_SYMBOL(dmi_scan_mach);

That can't be with mkpatch from CVS. We do *not* add our own dmi_scan.c
file anymore.

> So maybe it is better to rename dmi_scan.* afterall? Or did I
> patch/understand something wrong?

Yes, I think you did something wrong. Correct thing to do:
1* Start with your 2.4.22 kernel, including all the patches you want it
   to have.
2* Apply the linux-2.4.22-i2c-2.8.4 patch.
3* Checkout the latest CVS version of lm_sensors2, use mkpatch to
   generate a patch against your source tree, and apply this patch.
4* Go go go ;)

I don't expect the error above to possibly happen if you do that
(although there may actually be other errors I wouldn't have thought
of).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
