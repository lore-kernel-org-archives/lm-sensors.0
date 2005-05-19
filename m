From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Linux 2.6.3, lm_sensors 2.8.5
Message-Id: <20040220112841.GH19684@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218232559.2621d402.khali@linux-fr.org>
In-Reply-To: <20040218232559.2621d402.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Thu, Feb 19, 2004 at 11:07:18PM +0100, Jean Delvare wrote:
> > Could the versioning scheme be redesigned, so that the first two
> > digits indicate the same i2c/lm_sensors interface? E.g. lm_sensors
> > 2.9.x requires i2c 2.9.y where x is not necessarily equal to y.
> 
> This would need that the second number of the version would increase by
> one with almost each release. I don't like that idea much. Also, we more
> or less try to keep our release versions in sync with Linux 2.6, and
> that's something I wouldn't want to break.
> 
> > That way one could decouple release cycles of lm_sensors and i2c to
> > use different pacing. It would also help packagers to decide whether a
> > new kernel with mandatory i2c patching is necessary for building
> > lm_sensors kernel modules, and even embed virtually Provides and
> > Requires in kernels and lm_sensors packages (e.g. a future
> > kernel-2.6.10-i2c193 provides "kernel-i2c = 2.9.3" and
> > lm_sensors-2.9.7 requires "kernel-i2c >= 2.9.0, kernel-i2c <= 2.10").
> 
> I don't see much benefit (probably because I am not a packager (anymore)
> ;)). The minimal i2c version required is documented in
> lm_sensors2/INSTALL. OK, it happens that this information is *wrong* at
> least in the last (2.8.4) release, but we'll try to keep it up-to-date
> by now. I think that this information, if reliable, should be enough for
> packagers to know how to setup their dependencies.

Yes, that's what I am after, and the suggestion above was to embed it
in the versioning scheme itself. Which is the minimal required i2c in
kernel for lm_sensors 2.8.4/2.8.5? BTW I am about to build new kernels
for FC1 (2.4.22 & lots of backports based) and would like to include
2.8.5 (currently at 2.8.2), will you provide an i2c patch for it
again? :)

> I agree that this doesn't cover the "be foreseeable" part of your
> request. But, with the exception of i2c-2.8.0, lm_sensors verions should
> all work well with future versions of i2c, so this shouldn't be a big
> problem.
> 
> For my own information, do you have any exemple of project following the
> numbering scheme you suggest between two or more of their packages?

You mean projects releasing several subprojects? tetex for instance
has decoupled binaries and texmf packages where the texmf tree
requires a minimum binary version. gnome or kde could be also examples
of releasing several subprojects which do not require to be fully in
sync (e.g. you do not need gnome-common = 2.6.0 to build 2.6.0 gnome
applications).

If you are referring to the kernel-i2c versioning scheme, the
kernel-drm dependeny to XFree86 has been the patron of the above
suggestion ;)
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040220/151c4309/attachment.bin
