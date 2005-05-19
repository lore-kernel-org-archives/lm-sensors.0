From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: make fails
Message-Id: <20030730190453.4eb69679.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722165359.538d577f.khali@linux-fr.org>
In-Reply-To: <20030722165359.538d577f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 30 Jul 2003 18:56:33 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Do you have any sys/io.h file on your system (use find or locate)? Some
> systems have asm/io.h instead. There is a macro that is supposed to
> decide which one to chose, but maybe it isn't working for PPC systems.

zeno@zrr:/var/log$ sudo find / -name io.h
/usr/include/asm/io.h
/usr/src/benh_kernel/fs/befs/io.h
/usr/src/benh_kernel/include/asm-alpha/io.h
/usr/src/benh_kernel/include/asm-arm/arch-anakin/io.h
/usr/src/benh_kernel/include/asm-arm/arch-arc/io.h
/usr/src/benh_kernel/include/asm-arm/arch-cl7500/io.h
/usr/src/benh_kernel/include/asm-arm/arch-clps711x/io.h
/usr/src/benh_kernel/include/asm-arm/arch-ebsa110/io.h
/usr/src/benh_kernel/include/asm-arm/arch-ebsa285/io.h
/usr/src/benh_kernel/include/asm-arm/arch-epxa10db/io.h
/usr/src/benh_kernel/include/asm-arm/arch-integrator/io.h
/usr/src/benh_kernel/include/asm-arm/arch-l7200/io.h
/usr/src/benh_kernel/include/asm-arm/arch-mx1ads/io.h
/usr/src/benh_kernel/include/asm-arm/arch-nexuspci/io.h
/usr/src/benh_kernel/include/asm-arm/arch-rpc/io.h
/usr/src/benh_kernel/include/asm-arm/arch-sa1100/io.h
/usr/src/benh_kernel/include/asm-arm/arch-shark/io.h
/usr/src/benh_kernel/include/asm-arm/arch-tbox/io.h
/usr/src/benh_kernel/include/asm-arm/io.h
/usr/src/benh_kernel/include/asm-cris/io.h
/usr/src/benh_kernel/include/asm-i386/io.h
/usr/src/benh_kernel/include/asm-ia64/sn/io.h
/usr/src/benh_kernel/include/asm-ia64/io.h
/usr/src/benh_kernel/include/asm-m68k/io.h
/usr/src/benh_kernel/include/asm-mips/io.h
/usr/src/benh_kernel/include/asm-mips64/ip32/io.h
/usr/src/benh_kernel/include/asm-mips64/mips-boards/io.h
/usr/src/benh_kernel/include/asm-mips64/sgi/io.h
/usr/src/benh_kernel/include/asm-mips64/sibyte/io.h
/usr/src/benh_kernel/include/asm-mips64/sn/io.h
/usr/src/benh_kernel/include/asm-mips64/io.h
/usr/src/benh_kernel/include/asm-parisc/io.h
/usr/src/benh_kernel/include/asm-ppc/io.h
/usr/src/benh_kernel/include/asm-ppc64/io.h
/usr/src/benh_kernel/include/asm-s390/io.h
/usr/src/benh_kernel/include/asm-s390x/io.h
/usr/src/benh_kernel/include/asm-sh/io.h
/usr/src/benh_kernel/include/asm-sparc/io.h
/usr/src/benh_kernel/include/asm-sparc64/io.h
/usr/src/benh_kernel/include/asm-x86_64/io.h

Thanks for further feedback.

Zeno
