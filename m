From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: lmsensors 2.7.0 kann auf SuSE 7.2 nicht kompiliert werden
Message-Id: <20021213152742.37c43bfa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <02121221483700.10542@lighthouse>
In-Reply-To: <02121221483700.10542@lighthouse>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I tried a new compilation in my home dir to avoid that the i2c
> installation will destroy the installed 2.6.5 version of it. To make
> that way of compilation work I untared lm_sensors, put all necessary
> header files from i2c (2.7.0) into a subdir of the lm_sensors tree and
> modified the makefile so that lm_sensors is able to find the i2c
> header files.
> 
> At least I got the same errors on the i2c-md8111 module as I found
> them yesterday installing i2c/lm_sensors as root from /usr/src.
> 
> Here the error messages in full length:
> 
> gcc  -D__SMP__ -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB
> -fomit-frame-pointer -I. -Ikernel/include
> -I/home/marcus/lm_sensors-2.7.0
> -I/lib/modules/2.4.4-64GB-SMP/build/include   -O2   -c
> kernel/busses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
> kernel/busses/i2c-amd8111.c: In function `amd8111_access':
> kernel/busses/i2c-amd8111.c:272: parse error before `u8'
> kernel/busses/i2c-amd8111.c:281: parse error before `u8'
> kernel/busses/i2c-amd8111.c:300: parse error before `u8'
> kernel/busses/i2c-amd8111.c:360: parse error before `u8'
> kernel/busses/i2c-amd8111.c: At top level:
> kernel/busses/i2c-amd8111.c:500: initializer element is not constant
> kernel/busses/i2c-amd8111.c:500: (near initialization for
> `amd8111_driver.remove') kernel/busses/i2c-amd8111.c:501: initializer
> element is not constant kernel/busses/i2c-amd8111.c:501: (near
> initialization for `amd8111_driver') make: ***
> [kernel/busses/i2c-amd8111.o] Error 1
> 
> Wrong version of gcc? My is 2.95.3.

No, this is fine. I would be more suspicious about your kernel sources.
2.4.4 is *way* old and I don't think anyone would still use it,
considering the impressive number of fixes that have been merged since.
I'd suggest you update your kernel. 2.4.18 seems to be a clever choice.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
