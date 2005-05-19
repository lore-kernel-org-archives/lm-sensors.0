From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: W83627HF SuperIO support in lm_sensors
Message-Id: <20031001074549.GE1876@pua.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030929180436.GB1779@pua.nirvana>
In-Reply-To: <20030929180436.GB1779@pua.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 30, 2003 at 07:56:45PM +0200, Jean Delvare wrote:
> > > If you want more drivers, either tweak the FILES and Config.in files
> > > in mkpatch, or build the modules directly in the lm_sensors
> > > directory instead of patching the kernel.
> > 
> > What do you think is better for an rpm (and what is better supported
> > by you in general)?

> I would use solution 2. This is what I do as a user. It doesn't change a
> thing as far as packaging is concerned. You may build the modules inside
> the lm_sensors tree rather than inside the kernel tree, they still end
> up in /lib/modules, where they have to be. The only difference is that
> you can't choose which module you want to install with solution 2, but
> being packaging a kernel, you obviously don't want to exclude any driver
> anyway.

Ok, the packaging scheme looks like the following:
lm_sensors-2.8.x-...:			   Contains userland stuff.
lm_sensors-kmdl-2.4.20-20_29...-2.8.x-...: Contains kernel modules
					   built for the kernel
					   version embedded in the rpm
					   name.
I.e. there will be one main non-kernel rpm and several kmdl rpms (one
for each supported kernel rpm). The userland and kernel rpms would be
built out of the same src.rpm with different passes.

> > OK, sounds reasonable, what do you think, Jean?
> 
> Yes, let's go. Either you switch so solution 2, or you wait for us to
> update our list, if nobody on the list objects it, of course.

I will attack it in about a week, as I am currently on the road again.
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031001/6775a2e3/attachment.bin
