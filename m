From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: i2c & lm_sensors for RH
Message-Id: <20030807064805.GD22080@puariko.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802172008.GA10034@puariko.nirvana>
In-Reply-To: <20030802172008.GA10034@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 05, 2003 at 08:31:34PM +0200, Jean Delvare wrote:
> > I wonder if I need LINUX_HEADERS at all, since I am not building
> > external modules, and whether I should simply "carry" the i2c tarball
> > with the lm_sensors source package and build against the i2c headers
> > in that tarball (in order to build independently of the running kernel
> > or installed kernel sources). Does that make sense?
> 
> You do not need LINUX_HEADERS at all. It is used for userspace tools in
> lm_sensors 2.8.0's Makefile but this is a bug and has been fixed in CVS
> (you may checkout the new one if you want).
> 
> You won't be able to use the headers directly from the i2c tarball
> because lm_sensors expects them in a linux/ subdirectory. But you can
> build such a subdirectory rather easily IMHO, and that may suit your
> needs for the lm_sensors package build process.

I ended using
make LINUX=`pwd`/empty LINUX_HEADERS=`pwd`/empty I2C_HEADERS=`pwd`i2c-%{version}/kernel \
     COMPILE_KERNEL=0 MODVER:=1 SMP:=0 WARN=1 \
     KERNELCHIPSDIR=kernel/chips SRCDIRS='mkpatch kernel/include lib prog/sensors prog/dump prog/detect ${PROG_EXTRA:%=prog/%} etc'
     PROG_EXTRA=sensord \
     user

and similar for make user_install. Before that I unpackged i2c into
lm_sensors topdir. This seems to work, also does the right thing with
respect to the missing sensors.h (Ticket 1344).

> Hope that helps.

Thanks, I will be testing, whether this works at all, and report some
found patches back (by Red Hat, not me). I will be building 2.8.0
enabled kernels & userland for RH 7.3, 8.0 and 9, if I succeed :)

> BTW: We had a Red Hat user reporting he couldn't get lm_sensors to
> compile on his RH9. The message is available here:
> http://archives.andrew.net.au/lm-sensors/msg03872.html
> Could you please take a look at the log and tell me if you have any
> idea?

The first rows of errors/warning is the dependency generation, so it
is OK (I also get similar warnings). I never compiled lm_sensors as
modules, so I didn't hit the other errors in kernel/busses. But I see
stuff like loops_per_jiffy_R_ver_str which should have been resolved
by some macros to the usuall R<hash> modhashes. So something is wrong
wrt the user's mod versioning configuration. The user should maybe
file the output of the preprocessor.
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030807/ab48897b/attachment.bin
