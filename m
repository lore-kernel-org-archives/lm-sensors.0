From: decibel8@charter.net (David)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: 1250
Message-Id: <200306251330.01920.decibel8@charter.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Sorry, must have hit send. Anyways.
> This would make sense. David, correct me if I'm wrong, but I believe
> that you can actually write to the files (simply using "cat 1 2 >
> /proc/sys/dev/sensors/via686a-isa-6000/in1" for example). So, if
> "sensors -s" fails, this must be because of libsensors *thinking* it
> cannot write.

Actually no. Not using cat. I get this error if do that:

bash-2.05b# cat 1 2 > /proc/sys/dev/sensors/via686a-isa-6000/in1
cat: 1: No such file or directory
cat: 2: No such file or directory

I can though 'echo' to it:
bash-2.05b# echo 1 2 > /proc/sys/dev/sensors/via686a-isa-6000/in1
Haven't done that before though so not sure why it changed it to:
0.99 1.99 1.07
from the defaults in there. Doesn't matter now though. Root can write
to the file using 'echo'

>So, if  "sensors -s" fails, this must be because of libsensors *thinking* it
> cannot write.

Does seem so, yes.

> 1* Are you using i2c & lm_sensors 2.7.0 or CVS?

2.7.0 both, not CVS.

> 2* Are you using the mkpatch method or the traditional separated
> compilation tree method?

Not sure, Probably closer to the 2nd one. I could try not using the ebuild
below if you think it might be the problem.
**********************************************************
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/sys-apps/lm-sensors/lm-sensors-2.7.0-r1.ebuild,v 1.4 2003/06/23 12:26:33 phosphan Exp $

inherit flag-o-matic

MY_P=${PN/-/_}-${PV}

S="${WORKDIR}/${MY_P}"
MYI2C="${WORKDIR}/i2c-headers"

DESCRIPTION="Hardware Sensors Monitoring by lm_sensors"
SRC_URI="http://www2.lm-sensors.nu/~lm78/archive/${MY_P}.tar.gz
	mirror://gentoo/${P}-sensors-detect-gentoo.diff.bz2"
HOMEPAGE="http://www2.lm-sensors.nu/~lm78"

SLOT="0"
# gentoo-sources-2.4.20-r1 and xfs-sources-2.4.20-r1 will
# have support for this package, do not change these to ~
# until your arch has i2c-2.7.0 in it's kernel.
KEYWORDS="x86 amd64 -ppc -sparc"
LICENSE="GPL-2"

DEPEND="|| (
	     >=sys-apps/i2c-2.7.0
	     >=sys-kernel/gentoo-sources-2.4.20-r1
	     >=sys-kernel/lolo-sources-2.4.20.1
	     >=sys-kernel/xfs-sources-2.4.20_pre4
	   )"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	patch -p 1 <../${P}-sensors-detect-gentoo.diff || die
	# get the right i2c includes without dropping the kernel includes
	mkdir -p ${MYI2C}/linux
	cp /usr/include/linux/i2c* ${MYI2C}/linux/
}

src_compile()  {
	check_KV

	filter-flags -fPIC

	emake I2C_HEADERS=${MYI2C} clean all || die "lm_sensors requires the source of a compatible kernel\nversion installed in /usr/src/linux and >=i2c-2.7.0 support built as a modules this support is included in gentoo-sources as of 2.4.20-r1"
}

src_install() {
	einstall DESTDIR=${D} PREFIX=/usr MANDIR=/usr/share/man || die "Install failed"
	exeinto /etc/init.d
	newexe ${FILESDIR}/rc lm_sensors
}

pkg_postinst() {
	[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules

	einfo
	einfo "The lm_sensors hardware sensors package has been installed."
	einfo
	einfo "It is recommended that you read the lm_sensors documentation."
	einfo "To enable lm_sensors you will need to compile i2c support in"
	einfo "your kernel as a module and run /usr/sbin/sensors-detect to"
	einfo "detect the hardware in your system."
	einfo
	einfo "Be warned, the probing of hardware in your system performed by"
	einfo "sensors-detect could freeze your system.  Also do not use"
	einfo "lm_sensors on certain laptop models from IBM.  See the lm_sensors"
	einfo "documentation and website for more information."
	einfo
	einfo "IMPORTANT: When you merge this package it installs kernel modules"
	einfo "that can only be used with the specific kernel version whose"
	einfo "source is located in /usr/src/linux.  If you upgrade to a new"
	einfo "kernel, you will need to remerge the lm_sensors package to build"
	einfo "new kernel modules."
	einfo
}
***********************************************************
David


Previous message:
On Wednesday 25 June 2003 08:52 am, you wrote:
> > I don't have my lm_sensors source handy right now, but I wanted to
> > reply so perhaps you or someone else could look into this...
> >
> > I notice that the adapter is registered at address 6000.  That's a bit
> > of a strange isa address.  I believe that the original ISA bus only
> > has I/O addresses up to 3fff.  Anything above that is either an alias
> > or a PCI bus address.
> >
> > Perhaps there is a test in the ISA write function that makes sure the
> > address you're attempting to write is in the range: 0-3fff or less and
> > if not, returns an error.
>
> This would make sense. David, correct me if I'm wrong, but I believe
> that you can actually write to the files (simply using "cat 1 2 >
> /proc/sys/dev/sensors/via686a-isa-6000/in1" for example). So, if
> "sensors -s" fails, this must be because of libsensors *thinking* it
> cannot write.
>
> David, maybe we already asked you and I'm sorry for that, but I can't
> remember (it's been so long):
>
> 1* Are you using i2c & lm_sensors 2.7.0 or CVS?
>
> 2* Are you using the mkpatch method or the traditional separated
> compilation tree method?
>
> Thanks.
