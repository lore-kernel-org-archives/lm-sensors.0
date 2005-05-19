From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040412145341.GC6820@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 10, 2004 at 06:17:32PM +0200, Jean Delvare wrote:
> > No, I used the patches posted here. Does CVS have more changes applied
> > than these?
> 
> I actually sent two sets of patches. The initial mkpatch patch being
> broken, I sent a second a few hours after. Maybe you simply missed that
> one and are using the wrong one (it would actually produce the error you
> are encountering).

Oh, well, I thought I had the second patch in, but I obviously had
not. :)

> > At any rate I'll reiterate a build straight from the CVS, and check
> > whether dmi_scan.c sneaks in again. ;)
> 
> Yes please. The CVS stuff is supposed to do the same as the patches I
> sent, but in a different way: mkpatch now handles the additional kernel
> change to dmi_scan by itself, with no external patch needed. This is
> worth testing to ensure it works properly, especially since you do have
> many more patches applied to you tree, which could cause trouble.

The latest ATrpms kernel for FC1 is patched that way and works great,
i.e. I still get the sensors' readings and no more depmod warnings :)

Thanks a lot!

BTW the FC1 kernels can be found under

    http://atrpms.physik.fu-berlin.de/name/kernel-testing/

(the "45" release has the CVS patches).

I'll move the kernel from the bleeding edge repo to the stable one in
a couple of days, and will also prepare the RH9/8.0/7.3 kernels
accordingly.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040412/41446ebe/attachment.bin
