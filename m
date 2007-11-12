From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Nov 2007 13:32:55 +0000
Subject: Re: [lm-sensors] 2.10.5 on 2.4 kernel requires sysfs/libsysfs.h?
Message-Id: <20071112143255.4fc3dad2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071110095638.GA29181@puariko.nirvana>
In-Reply-To: <20071110095638.GA29181@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On Mon, 12 Nov 2007 01:05:17 +0200, Axel Thimm wrote:
> On Sun, Nov 11, 2007 at 11:25:39PM +0100, Jean Delvare wrote:
> > On Sat, 10 Nov 2007 11:56:38 +0200, Axel Thimm wrote:
> > > up to 2.10.4 sysfsutils was only required for 2.6 kernels. Now the
> > > build fails on 2.4 kernel system w/o sysfsutils with
> > > 
> > > make: *** No rule to make target `sysfs/libsysfs.h', needed by `lib/sysfs.ad'.
> > > 
> > > Is that a bug in the Makefiles or is sysfsutils now really required
> > > for 2.4. kernels as well?
> > > 
> > > (I hit this while building rpms for RHEL3).
> > 
> > No, sysfsutils is still not required for 2.4 kernels.
> > 
> > The only change in 2.10.5 that could cause this problem is this one:
> > http://www.lm-sensors.org/changeset/4738
> 
> I see, I will probably need to divert KERNELVERSION.
> 
> > But I tested this with a 2.4 kernel and it works as intended.
> > 
> > Hmmm, maybe I see what's going on. Are you cross-building the RHEL3
> > package, on a system itself running a 2.6 kernel?
> 
> Yes.
> 
> > And how are you pointing the build system to the right kernel tree
> > to build against in this case?
> 
> Something along
> make LINUX=/srv/atrpms.net/atrpms/kernelsrc/el3-x86_64/2.4.21-52.EL-x86_64 I2C_HEADERS=/usr/include/i2c COMPILE_KERNEL=0
> 
> I'll add an KERNELVERSION=2.4.21-52.EL for good measure ;)

Yes, that should solve the problem.

I admit that my fix introduced a regression, as it was previously
possible to only set LINUX and you now have to set both LINUX and
KERNELVERSION. However we have a chicken and egg problem, because the
"UTS release" number, which in practice is the kernel version number,
is defined in a different header depending on the kernel version.

But well, I'm not exactly sure what my change is fixing, so I might as
well revert it, and wait for a real bug report before I change it again.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
