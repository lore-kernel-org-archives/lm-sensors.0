From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 27 Aug 2011 15:02:25 +0000
Subject: Re: [lm-sensors] Odd warning in lm90.c (and other drivers)
Message-Id: <20110827170225.66e9d92a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314377205.2796.90.camel@groeck-laptop>
In-Reply-To: <1314377205.2796.90.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 26 Aug 2011 11:28:10 -0700, Guenter Roeck wrote:
> I also tried the same configuration with gcc 4.5.2. lm90 and smsc47b397
> warnings are still reported, others are gone.

Yes, I see them too using your configuration file with:

$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib64/gcc/x86_64-suse-linux/4.5/lto-wrapper
Target: x86_64-suse-linux
Configured with: ../configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man --libdir=/usr/lib64 --libexecdir=/usr/lib64 --enable-languages=c,c++,objc,fortran,obj-c++,java,ada --enable-checking=release --with-gxx-include-dir=/usr/include/c++/4.5 --enable-ssp --disable-libssp --disable-plugin --with-bugurl=http://bugs.opensuse.org/ --with-pkgversion='SUSE Linux' --disable-libgcj --disable-libmudflap --with-slibdir=/lib64 --with-system-zlib --enable-__cxa_atexit --enable-libstdcxx-allocator=new --disable-libstdcxx-pch --enable-version-specific-runtime-libs --program-suffix=-4.5 --enable-linux-futex --without-system-libunwind --enable-gold --with-plugin-ld=/usr/bin/gold --with-arch-32=i586 --with-tune=generic --build=x86_64-suse-linux
Thread model: posix
gcc version 4.5.0 20100604 [gcc-4_5-branch revision 160292] (SUSE Linux) 

I did not see the ones in adm1031 and pmbus though.

> Specifically the code in smsc47b397.c leads me to believe that this is
> just a compiler glitch, but I still would like to understand why it is
> only seen with some configurations ...

Apparently this is a combination of CONFIG_CC_OPTIMIZE_FOR_SIZE and at
least one other option. The warnings disappear if I turn off
CONFIG_CC_OPTIMIZE_FOR_SIZE on your configuration file, but they don't
show up if I turn it on on my own configuration.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
