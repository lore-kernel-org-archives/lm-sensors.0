From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Ticket 1159 update
Message-Id: <20030322102158.53b016e6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <NCBBIHMBGFFKDDGNDMLKIEOGDMAA.merky_1@yahoo.com>
In-Reply-To: <NCBBIHMBGFFKDDGNDMLKIEOGDMAA.merky_1@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Added #define DEBUG 1 to kernel/chips/bmcsensors.c.
> 
> Now I am getting a compile error:
> 
> gcc  -D__SMP__ -DMODVERSIONS -include
> /lib/modules/2.4.20/build/include/linux/modversions.h -D__KERNEL__
> -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include
> -I/usr/local/inclu de -I/lib/modules/2.4.20/build/include   -O2   -c
> kernel/chips/bmcsensors.c -o kernel/chips/bmcsensors.o
> kernel/chips/bmcsensors.c: In function `bmcsensors_rcv_sdr_msg':
> kernel/chips/bmcsensors.c:575: parse error before `else'
> make: *** [kernel/chips/bmcsensors.o] Error 1

Right, there was a bracket missing. It's now fixed in the CVS. I
wouldn't recommend to get the whole CVS tree right now since it's a bit
unstable AFAIK. Just replace the line 569 of kernel/chips/bmcsensors.c
as follows:

		else if(type = 0x11) {

becomes

		} else if(type = 0x11) {

And it should compile right.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
