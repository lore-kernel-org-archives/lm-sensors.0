From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors/i2c 2.8.2
Message-Id: <20040105150849.GA25497@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040104141910.64b647a2.khali@linux-fr.org>
In-Reply-To: <20040104141910.64b647a2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 04, 2004 at 05:18:08PM +0100, Jean Delvare wrote:
> > > And in fact I could even update my 2.4.21 patch from 2.8.0 to 2.8.2.
> > > I though nobody would be interested in it, but obviously you, at
> > > least, are. I want to have a new patch for 2.4.24-preX anyway, so
> > > I'll some work on the web page and files soon.
> > 
> > OK, I'll wait for the 2.4.21 patch, that should apply better to RH's
> > 2.4.20. FC1 is not the preferred distro for serious and stable server
> > monitoring that lm_sensors targets, so most people would like to see
> > it in RH9/RH7.3 (which is 2.4.20 with some 21-pre patches applied).
> 
> Done! Please give it a try and tell me how it goes.

Looks good, I had to massage 7 chunks, but it applied and built
well.

But just after finishing the RH9 kernels, I read the mremap() security
announcement, so I'll have to update the kernels again :(

I hope to have <= RH9 kernels, kernel modules and userland components
within the next days. I had already uploaded the FC1 equivalents, I
need to investigate whether the (latest) FC1 kernel I used had already
the mremap fix applied.

> > Also if 2.8.3/2.9.0 keep i2c 2.8.2 compatibility, I will be able to
> > supply new kernel module rpms for lm_sensors/i2c w/o rebuilding the
> > kernel. :)
> 
> Yes, it should be compatible. It should be released as 2.8.3 at the
> time Linux 2.6.1 is released.

Great!
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040105/49aa98dc/attachment.bin
