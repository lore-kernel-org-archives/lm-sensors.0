From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Centrino (855PM, ICH4-M): 82801DBM w/o LPC Bridge/SMBus?
Message-Id: <20040413100422.GD23129@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040412152503.GD6820@neu.nirvana>
In-Reply-To: <20040412152503.GD6820@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 13, 2004 at 11:03:28AM +0200, Jean Delvare wrote:
> > I will prepare a diff to cvs and send it to you. Thanks!  (BTW cvs
> > diff -N ... does not work with new, but not cvs added files and cvs
> > add is not allowed with anonymous read-only access. How does one
> > prepare a diff -N type patch?)
> 
> Never had to do that before. I guess that I would just duplicate the
> working repository and treat the whole thing as static, off-line
> directories. One of them being the snapshot of the CVS repository, the
> other being your working directory.
> 
> BTW, what file do you want to create?

I renamed p4b_smbus.c to 82801_smbus.c, as the problems is not
isolated to a specific motherboard.

The README.p4b mentioned that recent kernels (2.4.23 upwards) have the
i801 SMBus detection and activation patched in. I just checked and
the patch is less than a dozen lines, and very easily extendable to
Centrino laptops with hidden SMBus. But it is in the quirks.c, which
means that is needs a kernel patching.

Any chance that detection/enabling could enter i2c-i801.c? Should I
give it a try and merge p4b_smbus.c/quicks.c bits into i2c-i801.c?

> Another possibility is that we could grant you write access to the
> repository. You look like a responsible person so I'd say it is safe
> ;)

Thanks :)
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040413/f1bd6177/attachment.bin
