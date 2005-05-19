From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: Ticket# 1504
Message-Id: <3FFB581E.6080006@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF9D757.5070400@Rusin-Central.Com>
In-Reply-To: <3FF9D757.5070400@Rusin-Central.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sorry, typo (missed by one key!)
I meant min(x,y) not min*x,y)
good luck
mds

Chris Rusin wrote:
>   Hello,
> 
> In reference to TT# 1504.
> 
> I tried your suggrestion and
> 
> *"change min_t(t,x,y) to min*x,y) everyplace in the driver"*
> 
> for instance,
> 
> Orig:             *len = min_t(u8, data->block[0], 32);
> *Changed to:  *len = min*data->block[0], 32);*
> 
> Did I do this correctly?
> 
> which I did and I got:
> 
> gcc  -D__SMP__ -DMODVERSIONS -include 
> /lib/modules/2.4.9-e.34smp/build/include/linux/modversions.h 
> -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. 
> -Ikernel/include -I/usr/local/include  
> -I/lib/modules/2.4.9-e.34smp/build/include -nostdinc -I 
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/include  -Wall -O2  -c 
> kernel/busses/i2c-nforce2.c -o kernel/busses/i2c-nforce2.o
> kernel/busses/i2c-nforce2.c: In function `nforce2_access':
> kernel/busses/i2c-nforce2.c:169: `min' undeclared (first use in this 
> function)
> kernel/busses/i2c-nforce2.c:169: (Each undeclared identifier is reported 
> only once
> kernel/busses/i2c-nforce2.c:169: for each function it appears in.)
> kernel/busses/i2c-nforce2.c:169: warning: left-hand operand of comma 
> expression has no effect
> kernel/busses/i2c-nforce2.c:169: parse error before `)'
> kernel/busses/i2c-nforce2.c:178: warning: left-hand operand of comma 
> expression has no effect
> kernel/busses/i2c-nforce2.c:178: parse error before `)'
> kernel/busses/i2c-nforce2.c:267: warning: left-hand operand of comma 
> expression has no effect
> kernel/busses/i2c-nforce2.c:267: parse error before `)'
> kernel/busses/i2c-nforce2.c: At top level:
> kernel/busses/i2c-nforce2.c:387: warning: implicit declaration of 
> function `__devexit_p'
> kernel/busses/i2c-nforce2.c:387: initializer element is not constant
> kernel/busses/i2c-nforce2.c:387: (near initialization for 
> `nforce2_driver.remove')
> kernel/busses/i2c-nforce2.c:388: initializer element is not constant
> kernel/busses/i2c-nforce2.c:388: (near initialization for `nforce2_driver')
> make: *** [kernel/busses/i2c-nforce2.o] Error 1
> 
> 
> ----------------------------------
> 
> I also tried your other suggestion and:
> 
> *"Or else add a #define min_t(t,x,y) min(x,y)"
> *
> And I got:
> 
> gcc  -D__SMP__ -DMODVERSIONS -include 
> /lib/modules/2.4.9-e.34smp/build/include/linux/modversions.h 
> -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. 
> -Ikernel/include -I/usr/local/include  
> -I/lib/modules/2.4.9-e.34smp/build/include -nostdinc -I 
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/include  -Wall -O2  -c 
> kernel/busses/i2c-nforce2.c -o kernel/busses/i2c-nforce2.o
> kernel/busses/i2c-nforce2.c: In function `nforce2_access':
> kernel/busses/i2c-nforce2.c:170: warning: implicit declaration of 
> function `min'
> kernel/busses/i2c-nforce2.c: At top level:
> kernel/busses/i2c-nforce2.c:388: warning: implicit declaration of 
> function `__devexit_p'
> kernel/busses/i2c-nforce2.c:388: initializer element is not constant
> kernel/busses/i2c-nforce2.c:388: (near initialization for 
> `nforce2_driver.remove')
> kernel/busses/i2c-nforce2.c:389: initializer element is not constant
> kernel/busses/i2c-nforce2.c:389: (near initialization for `nforce2_driver')
> make: *** [kernel/busses/i2c-nforce2.o] Error 1
> 
> Any info would be much appreciated and thank you for your time,
> -Chris
