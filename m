From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040404190434.GA15289@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sun, Apr 04, 2004 at 03:28:09PM +0200, Jean Delvare wrote:
> > > 1* Doesn't include our dmi_scan.
> > > 2* Patches the kernel one.
> > >
> > > 1 is trivial, and 2 should not be too hard.
> > 
> > I'd like to reroll RHL & FC kernels (2.4.20 and 2.4.22 based), and fix
> > also the dmi_scan issue. Has any of the above suggestions found its
> > way into i2c CVS (I'd love a
> > http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
> > patch :)?
> 
> No, I have to admit I had completely forgotten about this issue and
> nothing was done.
> 
> I just took a look at the files and I think I missed a step in my first
> plan. The problem is that our dmi_scan module exports the whole DMI
> information and leaves it do i2c-piix4 to compare the strings, while the
> kernel's dmi_scan, once patched, would preferably export a simple flag.
> 
> So step 1 is to make our own dmi_scan compute and export that flag
> instead of the whole data, and change i2c-piix4 so that it always looks
> for the flag and doesn't try to access the whole data. I just did that,
> proposed patch to lm_sensors2 attached.
> 
> I do *not* want to apply it right now since we're about to release and
> this is a sensible change. You can still apply it before building your
> RPMs.
> 
> Step 2 is that lm_sensors2's mkpatch shouldn't include dmi_scan.c/.h.
> Easy, patch attached.
> 
> Step 3 is that lm_sensors2's mkpatch should include a patch to
> arch/i386/kernel/dmi_scan.c. This is the hardest part. Even before
> changing mkpatch so that it is able to dynamically create the patch (it
> must work with every kernel version), we have to make sure that we agree
> on what has to be done exactly.
> 
> Attached is my proposal for a kernel 2.4.22. It looks like we have to
> patch i386_ksyms.c as well.
> 
> Please note that these changes do not belong to the i2c package. For
> this reason, I don't think it would be a good idea to include them to
> the i2c patch, as you once suggested IIRC. This would make things even
> more complex in the end.

Yes, my suggestion was for lm_sensors, i2c slipped into it by mistake.

> > Or should I use one of the less favoured, but easier (for me) to
> > implement solutions (renaming files)?
> 
> Well, I invite you to test the patches attached, and tell us how it is
> working for you. Note that I didn't test anything myself (except that it
> still compiles).

I tried them and couldn't compile. I applied the patches to lm_sensors
2.8.5 and used its mkpatch to generate the kernel patch. I also
applied the linux-2.4.22-dmi_scan.diff. Did I miss something?

gcc32 -D__KERNEL__
-I/var/tmp/bach-build/BUILD/kernel-2.4.22/linux-2.4.22/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
-mpreferred-stack-boundary=2 -march=i386  -nostdinc -iwithprefix
include -E -D__GENKSYMS
__ i2c-algo-ibm_ocp.c
| /sbin/genksyms  -k 2.4.22 > /var/tmp/bach-build/BUILD/kernel-2.4.22/linux-2.4.22/include/linux/modules/i2c-algo-ibm_ocp.ver.tmp
i2c-algo-ibm_ocp.c:63:21: asm/ocp.h: No such file or directory
mv
/var/tmp/bach-build/BUILD/kernel-2.4.22/linux-2.4.22/include/linux/modules/i2c-algo-ibm_ocp.ver.tmp
/var/tmp/bach-build/BUILD/kernel-2.4.22/linux
-2.4.22/include/linux/modules/i2c-algo-ibm_ocp.ver
make[4]: *** No rule to make target `dmi_scan.c', needed by
`/var/tmp/bach-build/BUILD/kernel-2.4.22/linux-2.4.22/include/linux/modules/dmi_scan.ver
'.  Stop.
make[3]: *** [_sfdep_i2c] Error 2
make[2]: *** [fastdep] Error 2
make[1]: *** [_sfdep_drivers] Error 2
make: *** [dep-files] Error 2

> If it works OK and nobody objects, after 2.8.6 has been released, I'll
> apply the changes our CVS repository and hack mkpatch.pl so that it
> learns how to generate the kernel patch to dmi_scan regardless of the
> kernel version.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040404/de077d7b/attachment.bin
