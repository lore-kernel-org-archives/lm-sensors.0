From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040226162934.GA18724@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 24, 2004 at 11:16:34PM -0500, Mark Studebaker wrote:
> In the stock kernel everything in arch/i386/kernel/dmi_scan.c is static.
> So that we could have access to those functions when building outside the 
> kernel,
> we copied what we needed and made dmi_ident non-static.
> Why is there a problem with two files the same name 
> or two static symbols the same name?
> 
> If you're going to patch the kernel the correct method is to export 
> dmi_ident
> from arch/i386/kernel/dmi_scan.c, not patch the whole i2c/busses/dmi_scan.c
> into drivers/i2c. We shouldn't have added dmi_scan to mkpatch; that was a
> hack (of mine). If Red Hat copied that hack, oh well.

It looks more like the cpufreq project adding EXPORTs to dmi_scan,
which now get overridden (e.g. your hack works only as long as
arch/i386/kernel/dmi_scan.c does not export anything).

> So in short, there's no merge required. Get rid of a 'static' in
> arch/i386/kernel/dmi_scan.c and it's done.
> I copied it to get a symbol I needed, not to change anything.

Thanks, your explanation makes much sense. I'll fix the kernel source
accordingly at the next kernel update, but perhaps these fixes will
already be in 2.8.5 if I understand Jean correctly.

> mds
> 
> 
> 
> Axel Thimm wrote:
> >On Tue, Feb 24, 2004 at 09:34:00PM +0100, Jean Delvare wrote:
> >
> >>>What is the relation of drivers/i2c/dmi_scan.c and
> >>>arch/i386/kernel/dmi_scan.c?
> >>
> >>Ours is shamelessly ripped from the kernel. It was the quickest way to
> >>get it working with all kernels, although it was admittedly not nice.
> >>
> >>
> >>>It seems to be unhealthy to have two
> >>>files of the same name, because they overwrite their symbol
> >>>files.
> >>
> >>Even if you build the lm_sensors modules outside of the kernel? I never
> >>had a problem, and that's how I do it.
> >
> >
> >Yes, you are right, I didn't think about that compile path. But I know
> >that Red Hat for instance will only think about patching the kernel
> >and not start building out of the tree. Other vendors will probably
> >also follow the monolithic kernel rpm strategy. So it would be good to
> >have the patching method well working, too.
> >
> >
> >>>Should one of these be renamed, or the two files merged?
> >>
> >>It's a bit late to merge them (would mean that lm_sensors would only
> >>work with linux 2.4.26 and above, at best).
> >>
> >>Renaming it is an option, although I can hear MDS complaining from
> >>here, because he doesn't like renaming files under the CVS repository.
> >>
> >>I don't see any other way though.
> >
> >
> >What would an acceptable name be? The bugzilla reporter suggested
> >prepending "i2c-" to the two files.

-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040226/fc270a47/attachment.bin
