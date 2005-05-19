From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: Issues with Arima HDAMA Opteron Motherboard
Message-Id: <20040520160816.3eb42499.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E13FD85@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E13FD85@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm back to playing with lm_sensors and i2c, now 2.8.6 and 2.8.4, on
> the Arima HDAMA motherboard.  Only now I'm using a ROCKS 3.1 system,
> which is based on RHEL 3.0.  I notice that I still have the same
> problem I saw long ago,   
> 
> gcc -D__SMP__ -DMODVERSIONS -include
> /lib/modules/2.4.21-4.0.1.ELsmp/build/include/linux/modversions.h
> -I/lib/modules/2.4.21-4.0.1.ELsmp/build/include -nostdinc -I
> /usr/lib/gcc-lib/x86_64-redhat-linux/3.2.3/include -Wall -O2
> -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer
> -DEXPORT_SYMTAB -fno-strict-aliasing -fno-common -fomit-frame-pointer
> -mno-red-zone -mcmodel=kernel -fno-reorder-blocks -finline-limit 00
> -fno-strength-reduce -c kernel/i2c-algo-biths.c -o
> kernel/i2c-algo-biths.o/tmp/ccdTd1Ul.s: Assembler messages:
> /tmp/ccdTd1Ul.s:1437: Error: Incorrect register `%rdx' used with `l'
> suffix make: *** [kernel/i2c-algo-biths.o] Error 1
> 
> I've removed it from Module.mk as you suggested in the past and now it
> builds OK, but I thought you might like to know that the problem is
> still there.

Well, I can't see any assembly code in i2c-algo-biths.c, so it is most
likely a compiler problem. Anyway, I'm not even sure i2c-algo-biths is
usable, so who cares...

> Everything else worked just fine, though.  It detected the adm1026
> chip automatically.

Do you mean that the same system on which we failed so hard to find the
adm1026 chip some times ago now just works, without any additional
effort needed. Wow.

I'm glad you finally made it, although it doesn't really explain
anything. And thanks for the hat again ;)

-- 
Jean Delvare
http://khali.linux-fr.org/
