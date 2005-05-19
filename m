From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040404110510.GB9869@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Wed, Feb 25, 2004 at 07:19:09PM -0500, Mark Studebaker wrote:
> Even better is a patch that adds exactly what was added
> in kernel 2.5.34; that is,
> it puts all the detection logic in arch/i386/kernel/dmi_scan.c and
> simply exports is_unsafe_smbus.
> 
> Jean Delvare wrote:
> >>>What would an acceptable name be? The bugzilla reporter suggested
> >>>prepending "i2c-" to the two files.
> >>
> >>Sounds good to me.
> >
> >
> >Blah. I should have read the rest of the thread before replying. Mark's
> >approch sounds much better (I really should have thought of it too,
> >shame on me).
> >
> >So, we have to make some changes to mkpatch so that it:
> >1* Doesn't include our dmi_scan.
> >2* Patches the kernel one.
> >
> >1 is trivial, and 2 should not be too hard.

I'd like to reroll RHL & FC kernels (2.4.20 and 2.4.22 based), and fix
also the dmi_scan issue. Has any of the above suggestions found its
way into i2c CVS (I'd love a http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
patch :)?

Or should I use one of the less favoured, but easier (for me) to
implement solutions (renaming files)?
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040404/85b994a8/attachment.bin
