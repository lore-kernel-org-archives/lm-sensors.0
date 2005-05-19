From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: lm_sensors/i2c for Red Hat Linux flavours
Message-Id: <20040109155731.GG5518@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040107224757.GB11093@neu.nirvana>
In-Reply-To: <20040107224757.GB11093@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 08, 2004 at 08:38:52PM +0100, Jean Delvare wrote:
> > the rebuilds due to the mremap security fix are finally ready :)
> > 
> > The kernels for RH 7.3, 8.0, 9 and FC1 under
> > 
> >     http://atrpms.physik.fu-berlin.de/name/kernel/
> > (...)
> 
> Great :) Shall we put an announcement on our news page?

That would be nice, thanks!

BTW there was another FC1 kernel released only two days later (2140),
for which I rebuilt lm_sensors/i2c-kernels and lm_sensors kmdls. I
also drop the dependency between userland and kernelland, so that user
w/o lm_sensors/i2c 2.8.2 enabled kernels (the proper RH kernels) can
still upgrade the userland (I am not sure how useful that is, but
that's how RH ships).
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040109/8ed2e074/attachment.bin
