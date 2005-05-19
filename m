From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: Intel 82801DA ICH4
Message-Id: <20030722234206.4645b4ab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <32803.62.246.166.13.1058892758.squirrel@mailbox.TU-Berlin.DE>
In-Reply-To: <32803.62.246.166.13.1058892758.squirrel@mailbox.TU-Berlin.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have some trouble compiling the module p4b_smbus.o and adding
> support for the i2c-bus. Adding support for pci-hotplug to my kernel
> was successful.
> (reference to ticket # 1345)
> 
> Here the compiler output:
> 
> cc  -D__SMP__ -DMODVERSIONS -include
> /lib/modules/2.4.20-hotplug/build/include/linux/modversions.h
> -D__KERNEL__-DMODULE -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer-fno-strict-aliasing
> -I/lib/modules/2.4.20-hotplug/build/include   -c -o p4b_smbus.o
> p4b_smbus.c p4b_smbus.c: In function `cleanup_module':
> p4b_smbus.c:263: incompatible type for argument 1 of `write_lock'
> p4b_smbus.c:268: invalid type argument of `->'
> make: *** [p4b_smbus.o] Error 1

Strange. I can compile it. I suspect the code isn't SMP-compliant. Try
forcing SMP=0 in Makefile.p4b, just to make sure this is the cause of
the failure. Once confirmed, Mark D. Studebaker will take a look at it.

> Here what setpci said:
> 
> setpci -d 24C0:24C3 f2.w
> setpci: Warning: No devices selected for `f2.w'.

That's normal. The README.p4b file may not be really clear about this,
but the -d parameter for ICH4 is 8086:24C0. 8086 is Intel's vendor ID,
24C0 is the PCI bus main ID, and 24C3 is the I2C bus (which we are
trying to activate) ID.

> Thanks for your fast respond,

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
