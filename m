From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: RPM spec file patches for i2c and lm_sensors 2.8.1
Message-Id: <20031031165255.GI28151@puariko.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E13FDA5@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E13FDA5@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 29, 2003 at 12:01:11AM +0100, Jean Delvare wrote:
> > For people like me, who want to easily deploy lm_sensors across a
> > cluster of uniform machines, it's very handy to have a spec file there
> > so that we can build our own RPMs for specific systems with specific
> > kernels and configurations.  Even though the spec file you had was out
> > of date, it still saved me a lot of trouble.  
> > 
> > My vote would be to keep the spec files.  If nobody wants to maintain
> > them, call them unsupported or unmaintained.
> 
> OK, why not.
> 
> > Who's Axel?  I'd be happy to work with him, or just use whatever he
> > has or recommends.
> 
> Axel Thimm, the guy behind ATrpms:
> http://atrpms.physik.fu-berlin.de/
> He has RPMs for lm_sensors, I guess you'd be interested in his .spec
> files.

The kernel rpms for Fedora Core 1 (labeled as rawhide in the repo)
already have 2.8.1 support. Userland lm_sensors needs to be updated,
and I wanted to try building the kernel modules there also (otherwise
one may miss a few).

If I make lm_sensors.spec a specfile for kernel modules it will
probably become unreadable. Any help in packaging is appreciated!

BTW does lm_sensors 2.8.1 (userland & kernel modules) require i2c
2.8.1 or is i2c 2.8.0 already adequate? If the latter is true it would
save me from rebuilding the RH7.3-RH9 kernels.
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031031/059a4217/attachment.bin
