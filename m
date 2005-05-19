From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Linux 2.6.3, lm_sensors 2.8.5
Message-Id: <20040224100912.GF6243@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218232559.2621d402.khali@linux-fr.org>
In-Reply-To: <20040218232559.2621d402.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 20, 2004 at 09:45:38PM +0100, Jean Delvare wrote:
> > BTW I am about to build new kernels for FC1 (2.4.22 & lots of
> > backports based) and would like to include 2.8.5 (currently at 2.8.2),
> > will you provide an i2c patch for it again? :)
> 
> To anyone else I'd have replied "no way, I'm busy". But since this is
> you... I just updated the files, go pick them and tell me how it goes :)

Thanks a lot! Rebuilding kernels, lm_sensors and kernel modules for
all other projects took me quite some time, but now there is the
latest FC1 kernel with patched in lm_sensors/i2c 2.8.4 as well as
lm_sensors 2.8.4 userland bits (and external kernel modules, but they
are probably redundant) available at

	 http://atrpms.physik.fu-berlin.de/name/kernel/
	 http://atrpms.physik.fu-berlin.de/name/lm_sensors/

(there is still the dmi_broken resolving issue I will comment on
another thread)

> > (...)
> > If you are referring to the kernel-i2c versioning scheme, the
> > kernel-drm dependeny to XFree86 has been the patron of the above
> > suggestion ;)
> 
> I guess we might consider it then... However, I still want to keep in
> sync (sort of) with Linux 2.6 for now. Once the rush is behind us,
> maybe...
> 
> That said, we better start with not creating unneeded dependencies with
> IDs, as MDS suggested. And keeping the docs accurate too. This should
> already make your life a bit easier.
> 
> Feel free to come back with your suggestion within a few months, in case
> we forget about it and you're still interested.

I will remind you :)
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040224/b7fa4182/attachment.bin
