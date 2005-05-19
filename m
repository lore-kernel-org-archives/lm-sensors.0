From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: i2c & lm_sensors for RH
Message-Id: <20030811144126.GA3838@pua.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802172008.GA10034@puariko.nirvana>
In-Reply-To: <20030802172008.GA10034@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 11, 2003 at 03:57:17PM +0200, Jean Delvare wrote:
> > I forgot to mention: The 2.8.0 enabled kernel and drivers have a tag
> > like 2.4.20-19.23.rhxxx.at, while the non-enabled RH proper stuff has
> > the usual 2.4.20-19.x tag.
> 
> Is it something we should mention somewhere on our site, or is it obvous
> on your side?

It is obvious for kernel and userland tools. For driver compiled for a
given kernel it is hidden in the tag (needs to match the kernel relase
tag), but I think this is also rather obvious, as the kernel module
rpm are only installable if you have installed the matching kernel
(rpm barks otherwise). So I think it is quite safe.

> Have a nice vacation :)

Thanks! :)
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030811/f0e53f9a/attachment.bin
